public class Sender implements Runnable{
  PrintWriter out;

  public Sender(Socket s){
    try{
      this.out = new PrintWriter( s.getOutputStream(),true);
    }catch(Exception e){
      e.printStackTrace();
      System.exit(0);
    }
  }
  public void run(){
      try{
        while(true){
          out.println(send);
      }catch(Exception e){
        e.printStackTrace();
        System.exit(0);
      }
  }
}
