public class Receiver implements Runnable{
  BufferedReader in;


  public Receiver(Socket s){
    try{
      this.in = new BufferedReader(new InputStreamReader( s.getInputStream()));
    }catch(Exception e){
      e.printStackTrace();
      System.exit(0);
    }
  }
  public void run(){
      try{
        while(true){
          String r = in.readLine();
          rec = r.split(",");
        }
      }catch(Exception e){
        e.printStackTrace();
        System.exit(0);
      }
  }
}
