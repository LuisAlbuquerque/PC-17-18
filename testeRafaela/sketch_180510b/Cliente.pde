public class Cliente{
  Socket s;
  Receiver receiver;
  Sender senderC;
  
  Cliente(String port1, String port2){
    try{
      Socket s = new Socket(port1, Integer.parseInt(port2));
      receiver = new Receiver(s);
      senderC = new Sender(s);
      Thread reader = new Thread(receiver);
      Thread sender = new Thread(senderC);
      reader.start();
      sender.start();
    }catch(Exception e){
      e.printStackTrace();
      System.exit(0);
    }
  }  
}
