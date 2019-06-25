// ClientExample 2.
// Lee Erickson
// 3 June 2019
// Send command to socket for ST365 testing.

import processing.net.*; 

Client myClient; 
int dataIn; 

//color myBackground = (255,0,0);
color myBackground = color(0,0,0);

void setup() { 
  frameRate(60);
  background (myBackground);  
  //background (255,0,0);
  size(400, 200); 
  // Connect to the local machine at port 5204.
  // This example will not run if you haven't
  // previously started a server on this port.
//  myClient = new Client(this, "10.123.45.1", 23); // Simple Link Server on Telnet port
//  myClient = new Client(this, "10.123.45.1", 5001); // Simple Link Server on Telnet port
//  myClient = new Client(this, "127.0.0.1", 23); // Loop back to Server on Telnet port
  myClient = new Client(this, "127.0.0.1", 5001); // Loop back to Server on Telnet port
} 

void draw() {
  background (myBackground);
  if (myClient.active() == true) {
    myBackground = (128);
    //background (255);
 //   println("Client connected.");
    if (myClient.available() > 0) {
      background (0,0,255);
      dataIn = myClient.read();
      print(char(dataIn));
      //println("Client data recevied; " +stringIn);
    }
  } else { //Client not aactive
    myBackground = color(255,0,0);
    //background(0);
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
