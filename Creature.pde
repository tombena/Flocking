  public class Creature {
    public float px;//position x
    public float py;// position y
    public float vx;//velocity x
    public float vy;//velocity y
    public boolean exist;
    public float oldpx;
    public float oldpy;
    public float olderpx;
    public float olderpy;
    public float fwx;
    public float fwy;
    public float fcex;
    public float fcey;
    public float fcvx;
    public float fcvy;
    public float delta_time;
    public float wv;
    //weights
    public float wan;
    public float cen;
    //collision avoidance
    public float sumwa;
    public float sumwav;
    public float sumpax;
    public float sumpay;
    public float sumpvx;
    public float sumpvy;
    public float fcax;
    public float fcay;
    public float wca;
    public float wpre;
    public float prex;//predator - prey
    public float prey;
    public float predistance;
    public float fpx;
    public float fpy;
    public boolean centering;
    public boolean velocity;
    public boolean wandering;
    public boolean avoidance;
    public boolean attraction;
    
    //exist=false if no attributes defined
    public Creature(){
      exist=false;
    }
      
    
      
    public Creature(float posx,float posy, float speedx, float speedy){
      px=posx;
      py=posy;
      vx=speedx;
      vy=speedy;
      exist=true;
    }
    
    public void setpx (float posx){
      px=posx;
      exist=true;
    }
    
    public void setpy (float posy){
      py=posy;
      exist=true;
    }
    
    public void setvx (float speedx){
      vx=speedx;
      exist=true;
    }
    
    public void setvy (float speedy){
      vy=speedy;
      exist=true;
    }
    
    public void setAll (float posx,float posy, float speedx, float speedy){
      px=posx;
      py=posy;
      vx=speedx;
      vy=speedy;
      exist=true;
    }
    
    public void update(boolean wandering, boolean centering, float cx, float cy, boolean avoidance, float sumwa, float sumpax, float sumpay, boolean velocity, float sumwav, float sumpvx, float sumpvy, float fpx, float fpy){
      //parameters
      delta_time=0.05;
      //weights of different forces
      wan=1; //wandering 0.1
      cen=1;//centering  1
      wca=15;//collision avoidance 10
      wv=0.1; //velocity matching 1
      
      //Euler method
      if(px+delta_time*vx>100 || px+delta_time*vx<0 ){
        vx=-vx;
      }
      olderpx=oldpx;
      oldpx=px;
      px=px+delta_time*vx;
      
      if(py+delta_time*vy>100 || py+delta_time*vy<0 ){
        vy=-vy;
      }
      olderpy=oldpy;
      oldpy=py;
      py=py+delta_time*vy;


      
      //wandering force
      if(wandering==true){
      fwx=wan*(random(10)-5); //centered noise
      fwy=wan*(random(10)-5);
      } else {
        fwx=0;
        fwy=0;
      }
      
      //weighted centering force
      if(centering==true){
        if(cx==0 && cy==0){
          fcex=0;
          fcey=0;
        }
        else {
          fcex=cen*(cx-px);
          fcey=cen*(cy-py);
        }
      }
      else {
        fcex=0;
        fcey=0;
      }
      
      //collision avoidance force
      if(avoidance==true){
            if( sumpax==0 && sumpay==0){
              fcax=0;
              fcay=0;
            }
            else {
               fcax=wca*sumpax;
               fcay=wca*sumpay;
            }
      } else {
        fcax=0;
        fcay=0;
      }


      //velocity matching force
      if(velocity==true){
        if(sumpvx==0 && sumpvy==0){
          fcvx=0;
          fcvy=0;
        }
        else {
          fcvx=wv*sumpvx;
          fcvy=wv*sumpvy;
        }
      }
      else {
        fcvx=0;
        fcvy=0;
      }
        
  
      vx=vx+delta_time*(fwx+fcex+fcax+fcvx+fpx); 
      vy=vy+delta_time*(fwy+fcey+fcay+fcvy+fpy);
    }
    
    
  }
