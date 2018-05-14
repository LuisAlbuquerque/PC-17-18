public class Caixa {
   public int X = 0, Y = 0, H = 35, W = 200;
   public String title;
   
   // COLORS
   public color Background = color(140, 140, 140);
   public color Foreground = color(0, 0, 0);
   public color BackgroundSelected = color(160, 160, 160);
   public color Border = color(30, 30, 30);
   
   public boolean BorderEnable = false;
   public int BorderWeight = 2;
   
   ;

   private boolean selected = false;
   
   Caixa() {
      // CREATE OBJECT DEFAULT TEXTBOX
   }
   
   Caixa(String tt, int x, int y, int w, int h) {
      X = x; Y = y; W = w; H = h; title=tt;
   }
   
   void DRAW() {
      // DRAWING THE BACKGROUND
      if (selected) {
         fill(BackgroundSelected);
      } else {
         fill(Background);
      }
      
      if (BorderEnable) {
         strokeWeight(BorderWeight);
         stroke(Border);
      } else {
         noStroke();
      }
      
      fill(255);
      rect(X, Y, W, H);
     fill(0); 
      text(title, (X+20) , Y+(H/2)+10);
      
   }
   
   // FUNCTION FOR TESTING IS THE POINT
   // OVER THE TEXTBOX
   private boolean overBox(int x, int y) {
      if (x >= X && x <= X + W) {
         if (y >= Y && y <= Y + H) {
            return true;
         }
      }
      
      return false;
   }
   
   void PRESSED(int x, int y, Caixa t) {
      if (overBox(x, y)) {
         selected = true;
         t.BorderEnable = true;
      } else {
         selected = false;
         t.BorderEnable = false;
      }
   }
}