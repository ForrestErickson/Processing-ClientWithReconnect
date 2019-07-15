//Mouse press to send ST365 command or text.

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
