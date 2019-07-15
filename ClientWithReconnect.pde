// ClientWithReconnect.
// Lee Erickson
// 3 June 2019
// Send command to socket on server for testing of server coming and going and coming.
// 25 June 2019. Client try to connect to server and keeps on trying in setup() till success.
// 26 June 2019. In draw() the Client reconnectes to server.
// 27 Rename file.  Some clean up on notes.

import processing.net.*;  

Client myClient; 
int dataIn; 
int timeDisconnect = millis(); 
color myBackground = color(255,0,0);
PFont f;                          // Declare PFont variable

/*Some IP addresses and ports. Comment all but one each. */
//String sIPAddress = "10.1.10.11";// Simple Link STA on LAN
int MY_PORT = 23;  //Telnet port even though we are RAW socket.
//String sIPAddress = "10.123.45.1";// Simple Link AP Server
//int MY_PORT = 23;  //Telnet port even though we are RAW socket.
String sIPAddress = "127.0.0.1";  //Local host.
//int MY_PORT = 5001;  //Android app port

String s_messageServer = "Not initilized";
//int isconnected = 0; // Set zero for false. 1 for true.
boolean isconnected = false; // Set zero for false. 1 for true.

void getSocket(){
/// Opens a client network socket connection. Blockes and retries indefinatly.
do{  
  try {// Might through an IOException when connecting to socket.
      myClient = new Client(this, sIPAddress, MY_PORT); // Open client as would Android app port  
      if (myClient.active() == true) {
        isconnected = true; // has become true
      } else {
        text("Look for Socket",400,10);
        print("Hr:Min:Seconds = " +hour()+":"+ minute() +":"+ second());
        println(" Looking for server.");
        delay(500);  //No server so waite before trying again.
      }// else delay
  }// end of try
   catch (Exception npe) {     
     println ("Some other exception. I got npe= ", npe);
   }//end of catch   
} while (!isconnected);  
  print("Hr:Min:Seconds = " +hour()+":"+ minute() +":"+ second());
  println(" We have a server. Setup finished.");
}//GetSocket

void setup() { 
  frameRate(60);
  background (myBackground);  
  size(400, 200); 
  f = createFont("Arial",6,true);     // Create Font 
  textAlign(RIGHT);    // Credit will be in lower right corner.
  timeDisconnect = millis();
}// end of setup. 

void draw() {
  background (myBackground);
  if (isconnected){
      if (myClient.active() == true) {
      myBackground = (128);
      text("Client connected to server: "+sIPAddress+":"+MY_PORT, 400, 10);
      if (myClient.available() > 0) {
        background (0,0,255);
        dataIn = myClient.read();
        s_messageServer = "Receiving characters from server.";
        print(char(dataIn));
        text(s_messageServer, 400,50);
        }
      } else { //Client not active.          //We need to get a socket again.  
        isconnected = false; // Set zero for false
        myBackground = color(255,0,0);
        background (myBackground);
        text("Client not Active, Not connected to server: " + sIPAddress+":"+MY_PORT, 400, 10);
        timeDisconnect = millis();        
      }//end Client not active  
  } else if (timeDisconnect +3500 >millis()) {// Not isconnected
      text("Get a socket.",400, 10);  
      println("Get a socket.");
      getSocket();
  } else {
    myBackground = color(255,0,0);
    background (myBackground);
    text("Pause before connecting to server",400, 10);  
    println("Pause before connecting to server");
  }
} // end of draw.

void mousePressed() {
    if (mouseButton == LEFT){  
    println(">04");
    myClient.write(">04\r");    
    }
    else {
      println(">Hello world");
      myClient.write(">Hello world.\r\n");
    }
}//end mousePressed
