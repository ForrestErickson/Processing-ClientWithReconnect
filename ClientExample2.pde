// ClientExample 2.
// Lee Erickson
// 3 June 2019
// Send command to socket for ST365 testing.

import processing.net.*; 

Client myClient; 
int dataIn; 
color myBackground = color(0,0,0);
PFont f;                          // Declare PFont variable


void setup() { 
  frameRate(60);
  background (myBackground);  
  size(400, 200); 
  f = createFont("Arial",6,true);     // Create Font 
  textAlign(RIGHT);                    // Credit will be in lower right corner.

  // Some client set up strings.
//  myClient = new Client(this, "10.123.45.1", 23); // Simple Link AP Server on Telnet port
//  myClient = new Client(this, "10.123.45.1", 5001); // Simple Link AP Server on Android app port
//  myClient = new Client(this, "127.0.0.1", 23); // Loop back to Server on Telnet port
  myClient = new Client(this, "127.0.0.1", 5001); // Loop back to Server on Android app port
} 

void draw() {
  background (myBackground);
  if (myClient.active() == true) {
    myBackground = (128);
    text("Client connected",400, 10);
//    text(s_clientStatus,400, 20);
//    text("Server:" + s_messageServer,400, 40);
//    text("Client: " + s_messageClient,400, 50);

 //   println("Client connected.");
    if (myClient.available() > 0) {
      background (0,0,255);
      dataIn = myClient.read();
      print(char(dataIn));
    }
  } else { //Client not aactive
    myBackground = color(255,0,0);
    text("Client non connected to server",400, 10);
    //println("Client is not active."); 
  }
  //background(dataIn);
} 

void mousePressed() {
    if (mouseButton == LEFT){  
    println(">04");
    myClient.write(">04\r");    
    }
    else {
      println(">Hello world");
      myClient.write(">Hello world.\n\r");
    }
}
