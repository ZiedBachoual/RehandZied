#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include <Wire.h>
#include <Firebase_ESP_Client.h>
#include <WiFi.h>
#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"
#include "FlexLibrary.h"

#define WIFI_SSID "Airbox-C46D"
#define WIFI_PASSWORD "MTTX9Ax7U6cA"
#define API_KEY "AIzaSyCuRBZwxYYgErkPXArTV3mScG2Nb0xP5Fo"
#define DATABASE_URL "https://rehand-6f638-default-rtdb.europe-west1.firebasedatabase.app/"
#define NUM_FLEX_SENSORS 5

Flex flex[NUM_FLEX_SENSORS] = {Flex(35), Flex(32), Flex(33), Flex(25), Flex(26)};
String debug = "";

Adafruit_MPU6050 mpu;
FirebaseData fbdo;      // Declare FirebaseData instance here
FirebaseConfig config;
FirebaseAuth auth;

unsigned long sendDataPrevMillis = 0;
unsigned long retryInterval = 5000;
unsigned long lastRetryTime = 0;
bool signupOK = false;

void sendDataToFirebase(float data, const char* path) {
    if (Firebase.RTDB.setFloat(&fbdo, path, data)) {
        Serial.print(path);
        Serial.print(": ");
        Serial.print(data);
        Serial.print(" successfully stored in ");
        Serial.println(fbdo.dataPath());
    } else {
        Serial.print("FAILED to send ");
        Serial.print(path);
        Serial.print(": ");
        Serial.println(fbdo.errorReason());
    }
}

void reconnectWiFi() {
    if (WiFi.status() != WL_CONNECTED) {
        Serial.print("Reconnecting to Wi-Fi");
        while (WiFi.status() != WL_CONNECTED) {
            WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
            Serial.print(".");
            delay(300);
        }
        Serial.println();
        Serial.print("Reconnected with IP: ");
        Serial.println(WiFi.localIP());
    }
}

int readFlexSensor(int i) {
    flex[i].updateVal();
    debug = "flex " + String(i) + " - Val: " + flex[i].getSensorValue();
    Serial.println(debug);
    return flex[i].getSensorValue();
}

void tokenStatusCallback(bool status) {
    if (status) {
        Serial.println("Token is valid");
    } else {
        Serial.println("Token is invalid");
    }
}

void setup() {
    Serial.begin(115200);

    WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
    Serial.print("Connecting to Wi-Fi");
    while (WiFi.status() != WL_CONNECTED) {
        Serial.print(".");
        delay(300);
    }
    Serial.println();
    Serial.print("Connected with IP: ");
    Serial.println(WiFi.localIP());
    Serial.println();

    config.api_key = API_KEY;
    config.database_url = DATABASE_URL;

    if (!mpu.begin()) {
        Serial.println("Failed to find MPU6050 chip");
        while (1) {
            delay(10);
        }
    }
    Serial.println("MPU6050 Found!");

    mpu.setAccelerometerRange(MPU6050_RANGE_8_G);
    Serial.print("Accelerometer range set to: +-8G ");
    mpu.setGyroRange(MPU6050_RANGE_1000_DEG);
    Serial.print("Gyro range set to: +-1000 deg/s ");
    mpu.setFilterBandwidth(MPU6050_BAND_21_HZ);
    Serial.print("Filter bandwidth set to: 21 Hz ");
    Serial.println();

    if (Firebase.signUp(&config, &auth, "", "")) {
        Serial.println("SignUp Ok ");
        signupOK = true;
    } else {
        Serial.println(config.signer.signupError.message.c_str());
    }

    config.token_status_callback = tokenStatusCallback;
    Firebase.begin(&config, &auth);
    Firebase.reconnectWiFi(true);

    // Calibrate each flex sensor
    for (int i = 0; i < NUM_FLEX_SENSORS; i++) {
        for (int j = 0; j < 500; j++) {  // Reduced calibration iterations
            flex[i].Calibrate();
        }
        delay(500);  // Reduced delay
    }
}

void loop() {
    reconnectWiFi();
    String documentPath1 = "variables/ex1";
    String documentPath2 = "variables/ex2";

    // Get document ex1
    int ex1 = 0; // Assuming ex1 is an integer
    if (Firebase.RTDB.getInt(&fbdo, "/variables/ex1")) {
        ex1 = fbdo.intData();
        Serial.print("ex1 value: ");
        Serial.println(ex1);
    } else {
        Serial.println("Failed to get ex1");
    }

    // Get document ex2
    int ex2 = 0; // Assuming ex2 is an integer
    if (Firebase.RTDB.getInt(&fbdo, "/variables/ex2")) {
        ex2 = fbdo.intData();
        Serial.print("ex2 value: ");
        Serial.println(ex2);
    } else {
        Serial.println("Failed to get ex2");
    }

    // Run flex sensor iterations if ex1==true and ex2==false
    if (ex1 == 1 && ex2 == 0) {
        if (millis() - sendDataPrevMillis > 1000 || sendDataPrevMillis == 0) {
            readFlexSensor(0); // Read and print value from sensor 0
            delay(500); // Add a small delay
            readFlexSensor(1); // Read and print value from sensor 1
            delay(500); // Add a small delay
            readFlexSensor(2); // Read and print value from sensor 2
            delay(500); // Add a small delay
            readFlexSensor(3); // Read and print value from sensor 3
            delay(500); // Add a small delay
            readFlexSensor(4); // Read and print value from sensor 4
            delay(500);

            int flexSum = readFlexSensor(0) + readFlexSensor(1) + readFlexSensor(2) + readFlexSensor(3) + readFlexSensor(4);

            if (flexSum != 0) {
                sendDataToFirebase(1, "sensor3/flex");
            } else {
                sendDataToFirebase(0, "sensor3/flex");
            }

            sendDataPrevMillis = millis(); // Update last send time
        }
    }
    // Run MPU6050 iterations if ex2==true and ex1==false
    else if (ex2 == 1 && ex1 == 0) {
        if (millis() - sendDataPrevMillis > 1000 || sendDataPrevMillis == 0) {
            sensors_event_t a, g, temp;
            mpu.getEvent(&a, &g, &temp);
            sendDataToFirebase(a.acceleration.x, "sensor1/acceleration/x");
            sendDataToFirebase(a.acceleration.y, "sensor1/acceleration/y");
            sendDataToFirebase(a.acceleration.z, "sensor1/acceleration/z");

            sendDataPrevMillis = millis(); // Update last send time
        }
    }

    // Handle Firebase HTTP code
    if (fbdo.httpCode() == -1) {
        if (millis() - lastRetryTime >= retryInterval) {
            lastRetryTime = millis();
            Serial.println("Retrying Firebase operation...");
        } else {
            delay(retryInterval); // Prevents tight loop in case of repeated failures
        }
    }

    Serial.print("Free heap memory: ");
    Serial.println(ESP.getFreeHeap());
    delay(1000);
}
