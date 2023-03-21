#include <WiFiEsp.h>
#include <SoftwareSerial.h> 
#define esp_rxPin 13 // esp01 RX -> arduino 2
#define esp_txPin 12 // esp01 TX -> arduino 3 
SoftwareSerial esp01(esp_txPin, esp_rxPin); // (RX, TX)
WiFiEspClient client; // define WiFiEsp client object
WiFiEspServer arduino_server(80);

#include "WiFiEsp.h"
#include "WiFiEspUdp.h"
#include <TimeLib.h>

char ssid[] = "kj"; // 공유기 "SSID"     
char pass[] = "1004100400"; // 공유기 "password" 
int status = WL_IDLE_STATUS;     // the Wifi radio's status

//char timeServer[] = "time.google.com";  // NTP server
char timeServer[] = "kr.pool.ntp.org";  // NTP server
unsigned int localPort = 2390;        // local port to listen for UDP packets

const int NTP_PACKET_SIZE = 48;  // NTP timestamp is in the first 48 bytes of the message
const int UDP_TIMEOUT = 2000;    // timeout in miliseconds to wait for an UDP packet to arrive

byte packetBuffer[NTP_PACKET_SIZE]; // buffer to hold incoming and outgoing packets

WiFiEspUDP Udp;

bool got_NTP = false;
uint8_t timeZone = 9;

int h = 12; // initial Time display is 12:59:45 PM
int m = 59;
uint8_t s = 45;
bool meridian = true;
uint8_t hm;
bool now_am = true; //AM
uint16_t yy = 2019;
uint8_t mm = 1;
uint8_t dd = 1;
uint8_t week_num = 1;
String week_day = "SUN";
bool adjust = false;

bool display_t = false;

unsigned long int start_time = 0;

void setup() {
  Serial.begin(9600);
  esp01.begin(9600);
  WiFi.init(&esp01);
  while ( status != WL_CONNECTED) {
    Serial.print("Attempting to connect to WPA SSID: ");
    Serial.println(ssid);
    status = WiFi.begin(ssid, pass);
  }
  Serial.println("You're connected to the network");
  Udp.begin(localPort);
}

bool clientConnected = false;

void loop() {
  cal_time();
  adjust_time();
  NTP_send(); // 현재 시간을 가져옴
  getNtpTime(); // 현재 시간을 가져옴
}

void adjust_time() {
  if (Serial.available() > 0) {
    String temp = Serial.readStringUntil('\n');
    if (temp == "dtime") display_time();
    else if (temp == "s") { s = 0; start_time = millis(); display_t = true; }
    else if (temp == "mm") { m++; display_t = true; }
    else if (temp == "m") { m--; display_t = true; }
    else if (temp == "hh") { h++; display_t = true; }
    else if (temp == "h") { h--; display_t = true; }
    else if (temp == "24") { meridian = !meridian; display_t = true; }
    else if (temp == "yy") { yy++; display_t = true; }
    else if (temp == "y") { yy--; display_t = true; }
    else if (temp == "mon") { mm++; adjust = true; display_t = true; }
    else if (temp == "mon-") { mm--; adjust = true; display_t = true; }
    else if (temp == "dd") { dd++; adjust = true; display_t = true; }
    else if (temp == "d") { dd--; adjust = true; display_t = true; }
    else if (temp == "ww") { week_num++; adjust = true; display_t = true; }
    else if (temp == "w") { week_num--; adjust = true; display_t = true; }
    else if (temp.startsWith("tset")) {
      String set = temp.substring(4, 6);
      h = set.toInt();
      set = temp.substring(6, 8);
      m = set.toInt();
      set = temp.substring(8, 10);
      s = set.toInt();
      start_time = millis();
      adjust = true;
      display_t = true;
    }
    else if (temp.startsWith("dset")) {
      String set = temp.substring(4, 8);
      yy = set.toInt();
      set = temp.substring(8, 10);
      mm = set.toInt();
      set = temp.substring(10, 12);
      dd = set.toInt();
      adjust = true;
      display_t = true;
    }
    if (m >= 60) m = 0;
    else if (m < 0) m = 59;
    if (h >= 24) h = 0; 
    else if (h < 0) h = 23; 
    if (h < 12) now_am = true;
    else now_am = false; 
    hm = h; 
    if (meridian == true && hm == 12) { now_am = false; }
    else if (meridian == true && hm > 12) { hm = hm - 12; }
    cal_dd();
    if (display_t == true) { display_time(); display_t = false; }
  }
}

void cal_time() {
  if (millis() - start_time >= 1000) { // 시간 간격: 밀리초
    start_time = millis(); // 상기 조건을 만족할때의 밀리초를 다시 start_time에 저장하여 조건 초기화
    s++;
    if (s == 60) {
      s = 0;
      m++;
    }
    if(m == 60) { m = 0; h++; }
    if(h == 12) { now_am = false;}
    else if (h == 24) { h = 0; now_am = true; dd++; week_num++; cal_dd(); } 
    hm = h;
    if(meridian == true && hm == 12) { now_am = false; }
    else if (meridian == true && hm > 12) { hm = hm - 12; }
    else now_am = true;
    display_time();
    if (h == 1 && m == 1 && s == 10) { // NTP 동기화 시간
      got_NTP = false; 
    }
  }
}

void cal_dd() {
  uint8_t m_dds;
  switch (mm) {
    case 1:   m_dds = 31; break;
    case 2:   m_dds = 28; break;
    case 3:   m_dds = 31; break;
    case 4:   m_dds = 30; break;
    case 5:   m_dds = 31; break;
    case 6:   m_dds = 30; break;
    case 7:   m_dds = 31; break;
    case 8:   m_dds = 31; break;
    case 9:   m_dds = 30; break;
    case 10:  m_dds = 31; break;
    case 11:  m_dds = 30; break;
    case 12:  m_dds = 31; break;
  }
  if (adjust == false) {
    if (dd > m_dds) { dd = 1; mm++; }
    if (mm > 12) { mm = 1; yy++; }
    if (week_num > 7) week_num = 1;
    week_day_converter();
  }
  else {
    if (dd > m_dds) dd = 1;
    else if (dd < 1) dd = m_dds;
    if (mm > 12) mm = 1;
    else if (mm < 1) mm = 12;
    if (week_num > 7) week_num = 1;
    else if (week_num < 1) week_num = 7; 
    week_day_converter();
    adjust = false;
  }
}

void week_day_converter() {
  switch (week_num) {
    case 1:   week_day = "SUN"; break;
    case 2:   week_day = "MON"; break;
    case 3:   week_day = "TUE"; break;
    case 4:   week_day = "WED"; break;
    case 5:   week_day = "THU"; break;
    case 6:   week_day = "FRI"; break;
    case 7:   week_day = "SAT"; break;
  }
}

void display_time() {
  Serial.print(yy); Serial.print("."); 
  if (mm < 10) { Serial.print("0"); Serial.print(mm); Serial.print("."); }
  else { Serial.print(mm); Serial.print("."); }
  if (dd < 10) { Serial.print("0"); Serial.print(dd); Serial.print(". "); }
  else { Serial.print(dd); Serial.print(". "); }
  Serial.print(week_day); Serial.print(" ");  
  if (meridian == true) {
    if (now_am == true) Serial.print("AM ");
    else Serial.print("PM ");
    if (hm < 10) { Serial.print("0"); Serial.print(hm); Serial.print(":"); }
    else { Serial.print(hm); Serial.print(":"); }
  }
  else {
    if (h < 10) { Serial.print("0"); Serial.print(h); Serial.print(":"); }
    else { Serial.print(h); Serial.print(":"); }
  }
  if (m < 10) { Serial.print("0"); Serial.print(m); Serial.print(":"); }
  else { Serial.print(m); Serial.print(":"); }
  if (s < 10) { Serial.print("0"); Serial.println(s); }
  else Serial.println(s);
}

unsigned long startMs = 0;

void NTP_send() {
  if (got_NTP == false) { // NTP 수신값이 없으면 2초마다 요청
    if (millis() - startMs >=  2000) {
      startMs = millis();
      sendNTPpacket(timeServer);
    }
  }
}

void getNtpTime() {
  if (got_NTP == false) {
    if (Udp.available()) {
      if (Udp.parsePacket()) { // 수신된 값이 있으면
        Udp.read(packetBuffer, NTP_PACKET_SIZE);
        unsigned long highWord = word(packetBuffer[40], packetBuffer[41]);
        unsigned long lowWord = word(packetBuffer[42], packetBuffer[43]);
        unsigned long secsSince1900 = highWord << 16 | lowWord;
        const unsigned long seventyYears = 2208988800UL;
        unsigned long epoch = secsSince1900 - seventyYears + timeZone * 3600;
        yy = year(epoch);
        mm = month(epoch);
        dd = day(epoch); 
        h = hour(epoch); 
        m = minute(epoch); 
        s = second(epoch); 
        week_num = weekday(epoch);
        week_day_converter();
        got_NTP = true;
      }
    }
  }
}

void sendNTPpacket(char *ntpSrv) {
  memset(packetBuffer, 0, NTP_PACKET_SIZE);
  packetBuffer[0] = 0b11100011;   // LI, Version, Mode
  packetBuffer[1] = 0;     // Stratum, or type of clock
  packetBuffer[2] = 6;     // Polling Interval
  packetBuffer[3] = 0xEC;  // Peer Clock Precision
  packetBuffer[12]  = 49;
  packetBuffer[13]  = 0x4E;
  packetBuffer[14]  = 49;
  packetBuffer[15]  = 52;
  Udp.beginPacket(ntpSrv, 123); //NTP requests are to port 123
  Udp.write(packetBuffer, NTP_PACKET_SIZE);
  Udp.endPacket();
}