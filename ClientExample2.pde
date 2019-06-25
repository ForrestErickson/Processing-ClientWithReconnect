// ClientExample 2.
// Lee Erickson
// 3 June 2019
// Send command to socket for ST365 testing.
//25 June 2019. Client try to connect to server and keeps on trying in setup() till success.

import processing.net.*;  

Client myClient; 
int dataIn; 
color myBackground = color(255,0,0);
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
  textAlign(RIGHT);                    // Credit will be in lower right corner.

int isconnected = 0; // Set zero for false
do{
  try {// Might through an IOException when connecting to socket.
      myClient = new Client(this, sIPAddress, MY_PORT); // Open client as would Android app port  
      if (myClient.active() == true) {
        isconnected = 1; // has become true
      } else {
        print("Hr:Min:Seconds = " +hour()+":"+ minute() +":"+ second());
        println(" Looking for server.");
        delay(500);  //No server so waite before trying again.
      }// else delay
  }
   catch (Exception npe) {     
     println ("Some other exception. I got npe= ", npe);
   }   
} while (isconnected ==0);  
  print("Hr:Min:Seconds = " +hour()+":"+ minute() +":"+ second());
  println(" We have a server. Setup finished."); 
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
  } else { //Client not active
    myBackground = color(255,0,0);
    text("Client not Active, Not connected to server",400, 10);
  }
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
