//Mouse press to send ST365 command or text.

void mousePressed() {
    if (mouseButton == LEFT){  
    println(">04");
    myClient.write(">04\r");  
    s_messageClient = ">04\r";
    s_messageServer = "";

    }
    else if (mouseButton == CENTER ){
      println(">05");
      myClient.write(">05\r");
      s_messageClient = ">05\r\n";
      s_messageServer = "";
    }
    else {
      println(">Hello world");
      myClient.write(">Hello world.\r\n");
      s_messageClient = ">Hello world.\n\r";
      s_messageServer = "";
    }
}//end mousePressed
