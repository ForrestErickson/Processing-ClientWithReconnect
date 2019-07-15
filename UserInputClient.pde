//Mouse press to send ST365 command or text.

void mousePressed() {
    if (mouseButton == LEFT){  
      s_messageClient = ">04";
      s_messageServer = "";
      print(s_messageClient);
      myClient.write(s_messageClient);
    }    
    else if (mouseButton == CENTER ){
      s_messageClient = ">05";
      s_messageServer = "";
      print(s_messageClient);
      myClient.write(s_messageClient);
    }
    else {
      s_messageClient = ">Hello from client.\n\r";
      s_messageServer = "";
      print(s_messageClient);
      myClient.write(s_messageClient);
    }
}//end mousePressed
