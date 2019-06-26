// ClientExample 2.
// Lee Erickson
// 3 June 2019
// Send command to socket for ST365 testing.
//25 June 2019. Client try to connect to server and keeps on trying in setup() till success.

import processing.net.*;  

Client myClient; 
int dataIn; 
int timeDisconnect = millis(); 
color myBackground = color(255,0,0);
PFont f;                          // Declare PFont variable

//String sIPAddress = "10.123.45.1";// Simple Link AP Server
//int MY_PORT = 23;  //Telnet port even though we are RAW socket.
String sIPAddress = "127.0.0.1";
int MY_PORT = 5001;  //Android app port

String s_messageServer = "Not initilized";
int isconnected = 0; // Set zero for false

void getSocket(){
/// Opens a client network socket connection. Retries indefinatly.
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
}//GetSocket

void setup() { 
  frameRate(60);
  background (myBackground);  
  size(400, 200); 
  f = createFont("Arial",6,true);     // Create Font 
  textAlign(RIGHT);    // Credit will be in lower right corner.
  //getSocket();
}// end of setup. 

void draw() {
  background (myBackground);
  if (isconnected == 1){
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
      //We need to get a socket again.  
      isconnected = 0; // Set zero for false
      myBackground = color(255,0,0);
      background (myBackground);
      text("Client not Active, Not connected to server",400, 10);
      timeDisconnect = millis();
      //myClient.stop();  //Just in case stop.
      //getSocket();
    }//Client not active  
  } else if (timeDisconnect +1500 >millis()) {// Not isconnected
      println("Get a socket.");
      //myClient.stop();  //Just in case stop.
      getSocket();
  } else {
    text("Pause before connecting to server",400, 10);
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
