#include <SoftwareSerial.h> // SoftwareSerial
#include <WiFiEsp.h> // WIFI
#include <LiquidCrystal_I2C.h> // LCD
#define LCD_COLUMNS 16
#define LCD_ROWS 2
LiquidCrystal_I2C lcd(0x27, LCD_COLUMNS, LCD_ROWS); // Initialize the LCD display
#include <OneWire.h> // TMP
#define ONE_WIRE_BUS 2
OneWire oneWire(ONE_WIRE_BUS);
#include <DallasTemperature.h>
DallasTemperature sensors(&oneWire);
#define PH_SENSOR_PIN A3 // PH
#define MotionSensor 4 // MotionDetection

char ssid[] = "kj"; // your network SSID (name)
char password[] = "1004100400"; // your network password
WiFiEspServer arduino_server(80);

char server[] = "54.180.22.195"; // server address
char serverPath[] = "/team_one/watercon.ww"; // URL path
int port = 8080; // port number

WiFiEspClient client; // define WiFiEsp client object
SoftwareSerial espSerial(12, 13); // RX, TX

// waterpump
int ENA = 7;
int INA1 = 6;
int INA2 = 5;

// Define the pins for the RGB LEDs
const int redPin = A2;
const int greenPin = A1;
const int bluePin = A0;
int redValue;
int greenValue;
int blueValue;

void setup() {

  Serial.begin(9600); // initialize serial communication

  // waterPump pin
  pinMode(ENA, OUTPUT); // ena
  pinMode(INA1, OUTPUT); // in1
  pinMode(INA2, OUTPUT); // in2 
  
  // Set the pin modes for the RGB LEDs
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);

  // Set TMP
  sensors.begin(); 

  // Set LCD
  lcd.init(); 
  lcd.backlight();

  // Set PH
  pinMode(A3, INPUT);
  pinMode(A5, OUTPUT);

  // Set Motion
  pinMode(MotionSensor, INPUT);

  espSerial.begin(9600); // initialize ESP8266 communication
  WiFi.init(&espSerial); // initialize WiFiEsp library

  // Set the WiFiEsp client timeout to 10 seconds
  client.setTimeout(10000);

  // connect to WiFi network
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print("Attempting to connect to WPA SSID: ");
    Serial.println(ssid);
    WiFi.begin(ssid, password);
  }
  Serial.println("Connected to WiFi");
  IPAddress ip = WiFi.localIP();
  Serial.print("IP Address: ");
  Serial.println(ip);
  arduino_server.begin();

  // connect to server
  if (client.connect(server, port)) {
      Serial.println("Connected to server");
      
      String queryMT = String("GET ") + serverPath + "?MT=" + 1 + " HTTP/1.1\r\n" + "Host: " + server + "\r\n" + "Connection: keep-alive\r\n\r\n";
      client.print(queryMT);
      Serial.println(queryMT);

      client.stop();
      Serial.println("client.stop");
  } else {
    Serial.println("Connection to server failed");
  }

  // led
  analogWrite(redPin, 255);
  analogWrite(greenPin, 255);
  analogWrite(bluePin, 255);

}

int getRGBValue(String request, String color) {
  int value = 0;
  int index = request.indexOf(color);
  if (index >= 0) {
    index += color.length() + 1;
    value = request.substring(index).toInt();
  }
  return value;
}

int getWaterPumpValue(String request, String pump) {
  int value = 0;
  int index = request.indexOf(pump);
  if (index >= 0) {
    index += pump.length() + 1;
    value = request.substring(index).toInt();
  }
  return value;
}

// flag variable to keep track of client connection
bool clientConnected = false;

void loop() {

  // TMP
  sensors.requestTemperatures(); 
  float temperature = sensors.getTempCByIndex(0); // Get the temperature in Celsius

  Serial.print("Temp: ");
  Serial.println(temperature, 2);

  lcd.setCursor(0,0); // Set the cursor to the first column of the first row
  lcd.print("Temp : "); 
  
  lcd.print(temperature); // Print the temperature value on the LCD display
  lcd.print(" C"); 
  delay(500);

  // PH
  float voltageValue = analogRead(PH_SENSOR_PIN); // Read the voltage value from the Crowtail PH Sensor
  float pHValue = 7 - (voltageValue / 1024.0) * 5; // Convert the voltage value to pH value

  Serial.print("PH value: ");
  Serial.println(pHValue, 2); // Print the pH value on the serial monitor with 2 decimal places

  delay(500); // Wait for 1 second before reading the pH value again
  lcd.setCursor(0,1); // Set the cursor to the first column of the first row
  lcd.print("P  H : "); 
  
  lcd.print(pHValue, 2); // Print the temperature value on the LCD display
  lcd.print(" ph"); 
  delay(500);

  // Motion
  int MotionValue = (int)digitalRead(MotionSensor); // read the sensor value
  int MotionTrue = 0;
  if (MotionValue == HIGH) { // if an object is detected
    Serial.println("Motion Detection!"); // output 1 on the serial monitor
    MotionTrue = 1;
  }
  if (MotionValue == LOW) { // if no object is detected
    Serial.println("No Motion."); // output 0 on the serial monitor
  }
  delay(500);

  // wifi
  if (!clientConnected) {
    // accept new client connection if no client is currently connected
    client = arduino_server.available();
    if (client) {
      Serial.println("New client connected");

      // set flag variable to true to indicate client is connected
      clientConnected = true;
    }
  } else {
    // handle client communication if client is connected
    if (client.connected()) {
      if (client.available()) {
        delay(10);
        String line = client.readStringUntil('\r');
        delay(10);
        Serial.println(line);

        // waterpump
        int waterpumponoff = getWaterPumpValue(line, "pump");
        if(waterpumponoff == 1){
            Serial.println("pump on");
            digitalWrite(ENA, HIGH);
            digitalWrite(INA1, HIGH);
            digitalWrite(INA2, LOW);
        } else if(waterpumponoff == 2){
            Serial.println("pump off");
            digitalWrite(ENA, LOW);
            digitalWrite(INA1, LOW);
            digitalWrite(INA2, LOW);
        }

        // Extract the RGB values from the request
        redValue = getRGBValue(line, "red");
        greenValue = getRGBValue(line, "green");
        blueValue = getRGBValue(line, "blue");

        // Set the RGB LED to the requested values
        analogWrite(redPin, redValue);
        analogWrite(greenPin, greenValue);
        analogWrite(bluePin, blueValue);
        delay(500);
        client.stop();
        Serial.println("Client disconnected");

        // send data to AWS EC2 server jsp file
        client.connect(server, port);

        String queryPH = String("GET ") + serverPath + "?PH=" + pHValue + " HTTP/1.1\r\n" + "Host: " + server + "\r\n" + "Connection: keep-alive\r\n\r\n";
        client.print(queryPH);
        Serial.println(queryPH);
        delay(500);

        String queryTMP = String("GET ") + serverPath + "?TMP=" + temperature + " HTTP/1.1\r\n" + "Host: " + server + "\r\n" + "Connection: keep-alive\r\n\r\n";
        client.print(queryTMP);
        Serial.println(queryTMP);
        delay(500);

        String queryMT = String("GET ") + serverPath + "?MT=" + MotionTrue + " HTTP/1.1\r\n" + "Host: " + server + "\r\n" + "Connection: keep-alive\r\n\r\n";
        client.print(queryMT);
        Serial.println(queryMT);
        delay(500);

        client.stop();
        Serial.println("client.stop");
        clientConnected = false;
      }
    }
  }
  // lcd.clear(); // Clear the LCD display
}