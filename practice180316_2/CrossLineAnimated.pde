class CrossLineAnimated {
  //used outside this file (to trigger the animation)
  public boolean isActivated;
  
  //private vars
  private final float LWIDTH = 50f, LHEIGHT = 50f;
  private final int animationTime = 160;
  private float lineWidth, lineHeight;
  private float ellipseScale;
  private float stretchVal;
  private float incVal;
  private float angleStretch;
  private float angleRotate;
  //used in isOnSequence()
  private int tm;

  //////////////////////////////////////
  //Constructor
  //////////////////////////////////////
  public CrossLineAnimated() {
    //public
    isActivated = false;
    //private
    lineWidth = LWIDTH;
    lineHeight = LHEIGHT;
    ellipseScale = 4f;
    stretchVal = lineWidth * 0.5f;
    incVal = 4f;
    angleStretch = 0f;
    angleRotate = 0f;
    //used in isOnSequence()
    tm = 0;
  }

  //////////////////////////////////////
  //Init
  //////////////////////////////////////
  public void Init() {
    lineWidth = LWIDTH;
    lineHeight = LHEIGHT;
    angleStretch = 0f;
    angleRotate = 0f;
  }

  //////////////////////////////////////
  //Update
  //////////////////////////////////////
  public void Update() {
    //time manager
    tm++; //nextize timer
    if(!isOnSequence()) return; //get out when not on sequence
    if(tm == 1) Init(); //initialize on 1st frame
    
    //main processing
    angleStretch = (angleStretch < 180) ? angleStretch + incVal : 180;
    lineWidth = LWIDTH - sin(radians(angleStretch)) * stretchVal;
    lineHeight = LHEIGHT - sin(radians(angleStretch)) * stretchVal;
    
    angleRotate = angleStretch*0.5f;
  }
  
  private boolean isOnSequence(){
    if(!isActivated){tm = 0; return false;} //never be on sequence & nextize tm unitl activated from parental file
    
    if(tm > animationTime){
      tm = 0; //init timer
      return false;
    }
    return true;
  }
  
  //////////////////////////////////////
  //Draw
  //////////////////////////////////////
  public void Draw(float px, float py) {
    translate(px, py);
    rotate(radians(45 + angleRotate));
    ellipseMode(CENTER);
    strokeWeight(1.5);
    fill(50,100,50);
    float x, y;
    
    //draw vertical line
    x = lineWidth*0.5f - lineWidth*0.5f;
    y = -lineHeight*0.5f;
    stroke(120,190,120);
    line(x, y, x, y + lineHeight);
    noStroke();
    ellipse(x, y, ellipseScale, ellipseScale);
    ellipse(x, y + lineHeight, ellipseScale, ellipseScale);
    //draw horizontal line
    x = -lineWidth*0.5f;
    y = lineHeight*0.5f - lineHeight*0.5f;
    stroke(120,190,120);
    line(x, y, x + lineWidth, y);
    noStroke();
    ellipse(x, y, ellipseScale, ellipseScale);
    ellipse(x + lineWidth, y, ellipseScale, ellipseScale);

    resetMatrix();
  }
  
  //////////////////////////////////////
  //Get Set
  //////////////////////////////////////
  public float getLength(){
    return LWIDTH / sqrt(2);
  }
  public int getTime(){
    return tm;
  }
  public int getAnimationTIme(){
    return animationTime;
  }
}