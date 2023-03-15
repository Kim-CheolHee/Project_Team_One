#include <Servo.h>
#include <SoftwareSerial.h>
#include <WiFiEsp.h>
// AutoFeed
#define SECOND 1000L  // 1000밀리초를 해야 1초가 됨
#define MINUTE (60*SECOND)
#define HOUR (60*MINUTE)
#define DAY (24*HOUR)
const int SERVO_PIN = 3;  // 서보모터를 구동하고 싶은 핀
const int FILL_DEGREE = 20;  // 현재 상태 각도
const int DISPENSE_DEGREE = 45; // 사료 급여시 각도
Servo servo1;

char ssid[] = "kj"; // your network SSID (name)
char password[] = "1004100400"; // your network password
WiFiEspServer arduino_server(80);

char server[] = "52.79.197.208"; // server address
char serverPath[] = "/shop/commitTest.jsp"; // URL path
int port = 8080; // port number

WiFiEspClient client; // define WiFiEsp client object
SoftwareSerial espSerial(12, 13); // RX, TX

// waterpump
int ENA = 5;
int INA1 = 6;
int INA2 = 7;

// Define the pins for the RGB LEDs
const int redPin = A2;
const int greenPin = A1;
const int bluePin = A0;
int redValue;
int greenValue;
int blueValue;

// Define the pins for the waterHigh
int waterHigh = A3;

void setup() {

  Serial.begin(9600); // initialize serial communication

  // AutoFeed
  servo1.attach(SERVO_PIN);

  // waterPump pin
  pinMode(ENA, OUTPUT); // ena
  pinMode(INA1, OUTPUT); // in1
  pinMode(INA2, OUTPUT); // in2 
  
  // Set the pin modes for the RGB LEDs
  pinMode(redPin, OUTPUT);
  pinMode(greenPin, OUTPUT);
  pinMode(bluePin, OUTPUT);

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
    // client.stop();
    // Serial.println("client.stop");
  } else {
    Serial.println("Connection to server failed");
  }

  // led
  analogWrite(redPin, 255);
  analogWrite(greenPin, 255);
  analogWrite(bluePin, 255);
  
  // AutoFeed
  servo1.write(FILL_DEGREE);  // back
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

int getAutoFeedValue(String request, String feeding) {
  int value = 0;
  int index = request.indexOf(feeding);
  if (index >= 0) {
    index += feeding.length() + 1;
    value = request.substring(index).toInt();
  }
  return value;
}

// flag variable to keep track of client connection
bool clientConnected = false;

void loop() {

  // waterHigh
  int valueWaterHigh = analogRead(waterHigh);
  Serial.print("WaterHigh Sensor : ");
  Serial.println(valueWaterHigh);

  // TDS
  float TDS = analogRead(A4); // Read conductivity value from sensor
  TDS = map(TDS, 0, 1023, 0, 2000); // conductivity range is 0 to 2000 µS/cm
  // Print sensor readings to serial monitor
  Serial.print("TDS: ");
  Serial.print(TDS);
  Serial.println(" ppm");
  delay(1000); // Wait for 1 second before taking next reading

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
        String line = client.readStringUntil('\r');
        Serial.println(line);

        // AutoFeed
        int feedValue = getAutoFeedValue(line, "feeding");
        if(feedValue != 0){
          if(feedValue == 1){
            servo1.write(FILL_DEGREE);
            delay(3000);
            servo1.write(DISPENSE_DEGREE);  // Feeding
            delay(3000);
            servo1.write(FILL_DEGREE);  // back
          } else if(feedValue == 2){
            servo1.write(FILL_DEGREE);
            delay(3000);
            servo1.write(DISPENSE_DEGREE);  // Feeding
            delay(3000);
            servo1.write(FILL_DEGREE);  // back
            delay(3000);
            servo1.write(DISPENSE_DEGREE);  // Feeding
            delay(3000);
            servo1.write(FILL_DEGREE);  // back
          }
        }

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

        client.connect(server, port);
        int data = 100;
        String querydata = String("GET ") + serverPath + "?data=" + data + " HTTP/1.1\r\n" + "Host: " + server + "\r\n" + "Connection: keep-alive\r\n\r\n";
        int redvalue = 100;
        int greenvalue = 100;
        int bluevalue = 100;
        String queryrgb = String("GET ") + serverPath + "?red=" + redvalue + "&green=" + greenvalue + "&blue=" + bluevalue + " HTTP/1.1\r\n" + "Host: " + server + "\r\n" + "Connection: keep-alive\r\n\r\n";
        client.print(querydata);
        Serial.println(querydata);
        delay(500);
    
        client.print(queryrgb);
        Serial.println(queryrgb);
        delay(500);
        // client.stop();
        // Serial.println("client.stop");

        clientConnected = false;
      }
    }
  }

}