// ClientExample 2.
// Lee Erickson
// 3 June 2019
// Send command to socket for ST365 testing.

import processing.net.*; 

Client myClient; 
int dataIn; 

void setup() { 
  frameRate(10);  
  background (255,0,0);
  size(200, 200); 
  // Connect to the local machine at port 5204.
  // This example will not run if you haven't
  // previously started a server on this port.
  myClient = new Client(this, "10.123.45.1", 23); // Simple Link Server on Telnet port
} 

void draw() { 
  if (myClient.active() == true) {
    background (255);
 //   println("Client connected.");
    if (myClient.available() > 0) {
      background (0,0,255);
      dataIn = myClient.read();
      print(char(dataIn));
      //println("Client data recevied; " +stringIn);
    }
  } else { //Client not aactive
    background(0);
    println("Client is not active."); 
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
