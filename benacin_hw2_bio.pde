public Creature[] list;//=1 if creature, 0 else
int size;
float centerx;
float centery;
boolean continuous;
float sumwa;
float sumwav;
float sumpax;
float sumpay;
float sumpvx;
float sumpvy;
float locald;
float rfc;
float distancetocenter;
float localw;
boolean path;
boolean centering;
boolean velocity;
boolean wandering;
boolean avoidance;
boolean clearwindow;
float ind;
boolean attraction;
float prex;
float prey;
float pred;
float fpx;
float fpy;
float wp;
boolean pressed;
void setup(){
  pressed=false;
  wp=1;
  attraction = true;
  clearwindow=false;
  path=false;
  continuous=true;
  centering=true;
  velocity=true;
  wandering=true;
  avoidance=true;
  size(600,600);
  centerx=0;
  centery=0;
  size=10;
  list = new Creature[100];
  for (int i=0;i<size;i++){ //initialization of position and speed // GO TO SIZE
  list[i]= new Creature (random(10),i+5,20,15);
  }
}


void mouseDragged(){
    pressed=true;
    prex=mouseX/6;
    prey=mouseY/6;
    println(prex);
    println(prey);
}

void mouseReleased(){
  pressed=false;
   prex=0;
    prey=0;
}

void keyPressed(){
  if(key==' '){
    continuous=!continuous;
  }
  
  if(key=='a' || key=='A'){
    attraction=true;
  }
  
  if(key=='r' || key=='R'){
    attraction=false;
  }
  
  if(key=='=' || key=='+'){
    if(size<100){
    list[size]=new Creature(random(99), random(99),0,0);
    size=size+1;
    }
    else {
      println("Sorry Birdman, 100 is the limit :)");
    }
  }
  
  if(key=='-'){
    if(size!=1){
    list[size]=null;
    size=size-1;
    }
    else {
      println("Let him be :)");
    }
    
  }
  
  if(key=='c' || key=='C'){
    clearwindow=true;
  }
    
    if(key=='s' || key=='S'){
      for(int i=0;i<size;i++){
        list[i]=new Creature(random(99),random(99),0,0);
        
      }
    }
    
    if(key=='p' || key=='P'){
      path=!path;
}
    if(key=='1'){
      centering=!centering;
 
    }
    
    if(key=='2'){
      velocity=!velocity;
}

    if(key=='3'){
  avoidance=!avoidance;
}

    if(key=='4'){
      wandering=!wandering;
    }

  if(key=='1' || key=='2' || key=='3' || key=='4'){
  
  if(centering==true){
    print("Centering: on  ");
  }
  else {
    print("Centering: off  ");
  }
  
  if(velocity==true){
    print("Velocity matching: on  ");
  }
  else {
    print("Velocity matching: off  ");
  }
  
  if(avoidance==true){
    print("Avoidance: on  ");
  }
  else {
    print("Avoidance: off  ");
  }
  
  if(wandering==true){
    println("Wandering: on  ");
  }
  else {
    println("Wandering: off  ");
  }
}
}

void draw(){
  delay(100);//simulation step
  if(path==false ||clearwindow==true){
  background(0,0,0);
  noStroke();
  fill(255,0,0);
  }
  clearwindow=false;
  centerx=0;
  centery=0;
    if(size>0){
    fill(20,75,200);
    rect(6*list[0].px,6*list[0].py,6,6);
    }
  for(int i=1;i<size;i++){ //display
    
    if(list[i].exist==true){
      fill(204,102,0);//204,102
      rect(6*list[i].px,6*list[i].py,6,6); // boid
    }
  }
  if (continuous==true){
  sumwa=0;
  sumpax=0;
  sumpay=0;

    
  //velocity determination
  for (int i=0;i<size;i++){
    fpx=0;
    fpy=0;
  sumwa=0;
  sumwav=0;
  //collision avoidance
  sumpax=0;
  sumpay=0;
  locald=0;//local distance i,j
  //velocity matching
  sumpvx=0;
  sumpvy=0;
  
  //local centering
  ind=0;
  centerx=0;
  centery=0;
    for (int j=0;j<size;j++){
      if(i!=j){
        
      //collision avoidance w=max1/dij^2
      locald=sqrt((list[i].px-list[j].px)*(list[i].px-list[j].px) + (list[i].py-list[j].py)*(list[i].py-list[j].py)); //distance(i,j)
      
        
        //centering
        if(locald<20 && locald>0){
          centerx=centerx+list[j].px;
          centery=centery+list[j].py;
          ind=ind+1;
          
       //velocity matching
          
          sumwav=sumwav+1/(locald*locald);
          sumpvx=sumpvx+(list[j].vx-list[i].vx)/(locald*locald);
          sumpvy=sumpvy+(list[j].vy-list[i].vy)/(locald*locald);
          
        }
        
        
      //collision avoidance

        if(locald<5 && locald>0){
          sumwa=sumwa + 1/(locald*locald);
          sumpax=sumpax+(list[i].px-list[j].px)/(locald*locald);
          sumpay=sumpay+(list[i].py-list[j].py)/(locald*locald);
        } 
      }

    //finish of flock centering, normalization
      }
//      
    pred=sqrt((list[i].px-prex)*(list[i].px-prex)+(list[i].py-prey)*(list[i].py-prey));
    
      if(pressed){
      if(pred>0 && pred<10){
        if(attraction==true){
          println("attraction");
          fpx=wp*(prex-list[i].px);
          fpy=wp*(prey-list[i].py);
        }
        else {
          println("repulsion");
          fpx=wp*(list[i].px-prex);
          fpy=wp*(list[i].py-prey);
      }
      }
      }
      else {
        fpx=0;
        fpy=0;
      }
  
//      
      
    if(sumwa>0.1){
          sumpax=sumpax/sumwa;
          sumpay=sumpay/sumwa;
        }
        else {
          sumpax=0;
          sumpay=0;
        }
        
    if(sumwav>0.1){
          sumpvx=sumpvx/sumwav;
          sumpvy=sumpvy/sumwav;
    }
    else {
          sumpvx=0;
          sumpvy=0;
    }
    
    centerx=centerx/(ind+0.00000000000001);
    centery=centery/(ind+0.00000000000001);
    
    
    //update of the position of boid i
    if(list[i].exist==true){
      list[i].update(wandering, centering, centerx, centery,avoidance, sumwa,sumpax,sumpay,velocity, sumwav, sumpvx,sumpvy, fpx, fpy);
    }
  }
  }
 }

