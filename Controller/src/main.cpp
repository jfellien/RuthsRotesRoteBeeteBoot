#include <Arduino.h>
#include <BleGamepad.h>
#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include <Wire.h>

#define numOfButtons 0
#define numOfHatSwitches 0
#define enableX true
#define enableY true
#define enableZ true
#define enableRZ false
#define enableRX false
#define enableRY false
#define enableSlider1 false
#define enableSlider2 false
#define enableRudder false
#define enableThrottle false
#define enableAccelerator false
#define enableBrake false
#define enableSteering false

Adafruit_MPU6050 mpu;
BleGamepad gamepad("ESP32GameJamPad","medialesson", 100);

void setupMpuSensors(){
  // Try to initialize!
  if (!mpu.begin()) {
    Serial.println("Failed to find MPU6050 chip");
    while (1) {
      delay(10);
    }
  }
  Serial.println("MPU6050 Found!");

mpu.setAccelerometerRange(MPU6050_RANGE_8_G);
  Serial.print("Accelerometer range set to: ");
  switch (mpu.getAccelerometerRange()) {
  case MPU6050_RANGE_2_G:
    Serial.println("+-2G");
    break;
  case MPU6050_RANGE_4_G:
    Serial.println("+-4G");
    break;
  case MPU6050_RANGE_8_G:
    Serial.println("+-8G");
    break;
  case MPU6050_RANGE_16_G:
    Serial.println("+-16G");
    break;
  }
  mpu.setGyroRange(MPU6050_RANGE_500_DEG);
  Serial.print("Gyro range set to: ");
  switch (mpu.getGyroRange()) {
  case MPU6050_RANGE_250_DEG:
    Serial.println("+- 250 deg/s");
    break;
  case MPU6050_RANGE_500_DEG:
    Serial.println("+- 500 deg/s");
    break;
  case MPU6050_RANGE_1000_DEG:
    Serial.println("+- 1000 deg/s");
    break;
  case MPU6050_RANGE_2000_DEG:
    Serial.println("+- 2000 deg/s");
    break;
  }

  mpu.setFilterBandwidth(MPU6050_BAND_5_HZ);
  Serial.print("Filter bandwidth set to: ");
  switch (mpu.getFilterBandwidth()) {
  case MPU6050_BAND_260_HZ:
    Serial.println("260 Hz");
    break;
  case MPU6050_BAND_184_HZ:
    Serial.println("184 Hz");
    break;
  case MPU6050_BAND_94_HZ:
    Serial.println("94 Hz");
    break;
  case MPU6050_BAND_44_HZ:
    Serial.println("44 Hz");
    break;
  case MPU6050_BAND_21_HZ:
    Serial.println("21 Hz");
    break;
  case MPU6050_BAND_10_HZ:
    Serial.println("10 Hz");
    break;
  case MPU6050_BAND_5_HZ:
    Serial.println("5 Hz");
    break;
  }

}

void setupGamepad(){
  Serial.println("Starting gamepad work!");

  BleGamepadConfiguration gamepadConfig;
  gamepadConfig.setAutoReport(false);
  // CONTROLLER_TYPE_JOYSTICK, CONTROLLER_TYPE_GAMEPAD (DEFAULT), CONTROLLER_TYPE_MULTI_AXIS
  gamepadConfig.setControllerType(CONTROLLER_TYPE_JOYSTICK); 
  gamepadConfig.setButtonCount(numOfButtons);
  gamepadConfig.setIncludeStart(true);
  gamepadConfig.setIncludeSelect(true);
  // Can also be done per-axis individually. All are true by default
  gamepadConfig.setWhichAxes(enableX, enableY, enableZ, enableRX, enableRY, enableRZ, enableSlider1, enableSlider2);
  // Can also be done per-control individually. All are false by default      
  gamepadConfig.setWhichSimulationControls(enableRudder, enableThrottle, enableAccelerator, enableBrake, enableSteering); 
  // 1 by default
  gamepadConfig.setHatSwitchCount(numOfHatSwitches);                                                                       
  gamepadConfig.setVid(0xe502);
  gamepadConfig.setPid(0xabcd);
  
  gamepadConfig.setModelNumber("1.0");
  gamepadConfig.setSoftwareRevision("Software Rev 1");
  gamepadConfig.setSerialNumber("9876543210");
  gamepadConfig.setFirmwareRevision("2.0");
  gamepadConfig.setHardwareRevision("1.7");
  
  gamepad.begin(&gamepadConfig);
}

void setup(void) {
  Serial.begin(115200);
 
  while (!Serial)
    delay(10);

  setupMpuSensors();
  setupGamepad();

  Serial.println("");
  Serial.println("Setup done");
  delay(100);
}
 
void loop() {

  if (gamepad.isConnected())
  {
    /* Get new sensor events with the readings */
    sensors_event_t a, g, temp;
    mpu.getEvent(&a, &g, &temp);

    int xValue = map(a.acceleration.x, -10, 10, 32737, 0);
    int yValue = map(a.acceleration.y, -10, 10, 32737, 0);

    gamepad.setX(xValue);
    gamepad.setY(yValue);

    Serial.print("\rX: ");
    Serial.print(xValue);
    Serial.print("; Y: ");
    Serial.print(yValue);
    Serial.flush();

    gamepad.sendReport();
    delay(10);
  }
}