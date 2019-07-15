/** ClientWithReconnect.
 
 * /author F. Lee Erickson
 * /date 3 June 2019
 * /brief Send command to socket on server for testing of server coming and going and coming.
 *
 * 25 June 2019. Client try to connect to server and keeps on trying in setup() till success.
 * 26 June 2019. In draw() the Client reconnectes to server.
 * 27 Rename file.  Some clean up on notes.
 * 15 July. Change isconnected to boolean. Update screen prompt when tryint to get socket.
 * Change some comments to Doxygen format.
 * Move keypress and mouse press to UserInput tab.  
*/

import processing.net.*;  

Client myClient; 
int timeReconnect = millis(); 
color myBackground = color(255,0,0);
PFont f;                                          // Declare PFont variable

/*Some IP addresses and ports. Comment all but one each. */
//String sIPAddress = "10.1.10.11";// Simple Link STA on LAN
//String sIPAddress = "10.123.45.1";// Simple Link AP Server
String sIPAddress = "127.0.0.1";  //Local host.
int MY_PORT = 23;  //Telnet port even though we are RAW socket.

String s_clientStatus = "Not initilized";
String s_messageServer = "No message";
String s_messageClient = "No message";

boolean isconnected = false;                         // Set zero for false. 1 for true.

void getSocket(){
/// Opens a client network socket connection. Blockes and retries indefinatly.
  if (timeReconnect +1000 <millis())
  {
  try {                                // Might through an IOException when connecting to socket.
      myClient = new Client(this, sIPAddress, MY_PORT); // Open client as would Android app port  
      if (myClient.active() == true) {
        isconnected = true; // has become true
        timeReconnect = millis();
      } else {
        text("Look for Socket",400,10);
        print("Hr:Min:Seconds = " +hour()+":"+ minute() +":"+ second());
        println(" Looking for server.");        
      }// else delay
  }// end of try
   catch (Exception npe) {     
     println ("Some other exception. I got npe= ", npe);
   }//end of catch     
  print("Hr:Min:Seconds = " +hour()+":"+ minute() +":"+ second());
  println(" Try to connect to a server.");
  }
}//GetSocket

void setup() { 
  frameRate(60);
  background (myBackground);  
  size(400, 200); 
  f = createFont("Arial",6,true);                       // Create Font 
  textAlign(RIGHT);                                     // Credit will be in lower right corner.
  text("Client not Active, Not connected to server: " + sIPAddress+":"+MY_PORT, 400, 10);
  timeReconnect = millis();
}// end of setup. 

void draw() {
  background (myBackground);
  if (isconnected){
      if (myClient.active() == true) {
      myBackground = color(128,128, 128); //(128);
      text("Client connected to server: "+sIPAddress+":"+MY_PORT, 400, 10);
      if (myClient.available() > 0) {                   //We have some socket data from server.
        background (0,0,255);
        String whatServerSaid = myClient.readString();
        println(whatServerSaid);
        s_messageServer = whatServerSaid;
        s_messageClient = "";
        text("Client: " + s_messageClient,400, 40);
        text("Server:" + s_messageServer,400, 20);  
      } else {                                          // Connected but no new data.
        myBackground = color(128,128, 128); //(128);
        background (myBackground);
        text("Client: " + s_messageClient,400, 40);
        text("Server:" + s_messageServer,400, 20);  
      }
      } else { //Client not active.                      //We need to get a socket again.  
        isconnected = false;                             // Set zero for false
        myBackground = color(255,0,0);
        background (myBackground);
        text("Client not Active, Not connected to server: " + sIPAddress+":"+MY_PORT, 400, 10);
//        timeReconnect = millis();    
        text("Client: " + s_messageClient,400, 40);
        text("Server:" + s_messageServer,400, 20);  
      }//end Client not active  
  } else if (timeReconnect +3500 >millis()) {          // Not isconnected
        //Update window
            text("Tring to get a socket.",400, 10);  
            text("Client Connection: "+s_clientStatus,400, 50);
            text("Client: " + s_messageClient,400, 40);
            text("Server:" + s_messageServer,400, 20);                
      println("Tring to get a socket.");
      getSocket();              
    
  } else {
    myBackground = color(255,0,0);
    background (myBackground);
    text("Pause before connecting to server",400, 10);  
    println("Pause before connecting to server");
    text("Client Connection: "+s_clientStatus,400, 50);
    text("Client: " + s_messageClient,400, 40);
    text("Server:" + s_messageServer,400, 20);  
    getSocket();  
  }
} // end of draw.
