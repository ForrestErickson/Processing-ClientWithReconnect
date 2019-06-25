// ClientExample 2.
// Lee Erickson
// 3 June 2019
// Send command to socket for ST365 testing.

import processing.net.*; 
//import processing.net.*; 

Client myClient; 
int dataIn; 
color myBackground = color(0,0,0);
PFont f;                          // Declare PFont variable

//String sIPAddress = "10.123.45.1";// Simple Link AP Server
//int MY_PORT = 23;  //Telnet port even though we are RAW socket.
String sIPAddress = "127.0.0.1";
int MY_PORT = 5001;  //Android app port

String s_messageServer = "Not initilized";

void setup() { 
  frameRate(60);
  background (myBackground);  
  size(400, 200); 
  f = createFont("Arial",6,true);     // Create Font 
  textAlign(RIGHT);                    // Credit will be in lower right corner. //<>//

//  myClient = new Client(this, sIPAddress, MY_PORT); // Open client as would Android app port

int isconnected = 0; 
do{

  try {// Might through an IOException when connecting to socket.
      myClient = new Client(this, sIPAddress, MY_PORT); // Open client as would Android app port  
      if (myClient.active() == true) {
        isconnected = 1;
        println("I got an active client");
      } else {
        delay(100);
      }
      println("after that if");
  }
   //catch (IOException e) {
   //   println ("Did not get server. I got e= ", e);
   //}
   catch (Exception npe) {
     println("Rod's print line.");
      println ("Some other exception. I got npe= ", npe);
   }
   
} while (isconnected ==0);
 println("end of setup."); 
}// end of setup. 

void draw() {
  background (myBackground);
  if (myClient.active() == true) {
    myBackground = (128);
    text("Client connected to server",400, 10);
    if (myClient.available() > 0) {
      background (0,0,255);
      dataIn = myClient.read();
      s_messageServer = "Receiving characters from server.";
      print(char(dataIn));
      text(s_messageServer, 400,50);
    }
  } else { //Client not aactive
    myBackground = color(255,0,0);
    text("Client not Active, Not connected to server",400, 10);
    //println("Client is not active."); 
  }
  //background(dataIn);
} // end of draw.

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
