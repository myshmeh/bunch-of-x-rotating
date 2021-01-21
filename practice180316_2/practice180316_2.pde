int t;
int row = 15, col = 15;
CrossLineAnimated[][] cLine = new CrossLineAnimated[row][col];

////////////////////////////
//Main Functions
////////////////////////////
void setup(){
  size(600, 600);
  frameRate(60);
  background(0);
  
  t = 0;
  for(int i=0; i<row; i++){
    for(int j=0; j<col; j++){
      cLine[i][j] = new CrossLineAnimated();
    }
  }
}

void draw(){
  UpdateMgr();
  Flip();
  DrawMgr();
}

void Flip(){
  fill(255, 255, 255, 120);
  noStroke();
  rectMode(CORNER);
  rect(0, 0, width, height);
}

////////////////////////////
//Sub Functions
////////////////////////////
void UpdateMgr(){
  ActivateMgrSpade();
  t++; //nextize timer
  
  int i, j;
  for(i=0; i<row; i++){
    for(j=0; j<col; j++){
      cLine[i][j].Update();
    }
  }
}

void ActivateMgrSpade(){
  int i, j;
  float iVal, jVal;
  float incVal = 8f;
  int ioff = 0, joff = 0;
  boolean isPeakI = false, isPeakJ = false;
  //<i
  for(i=0; i<row; i++){
    iVal = ioff * incVal;
    ioff += (!isPeakI) ? 1 : -1;
    if(ioff == (int)row/2) isPeakI = true;
    //<j
    for(j=0; j<col; j++){
      jVal = joff * incVal;
      joff += (!isPeakJ) ? 1 : -1;
      if(joff == (int)col/2) isPeakJ = true;
      if(t == iVal+jVal){
        cLine[i][j].isActivated = true;
        println("activated..." + i + " " + j);
      }
    }
    //j>
    joff = 0;
    isPeakJ = false;
  }//i>
}

void ActivateMgrSphere(){

}

void DrawMgr(){
  int i, j;
  for(i=0; i<row; i++){
    for(j=0; j<col; j++){
      float x = 50 + i * cLine[i][j].getLength();
      float y = 50 + j * cLine[i][j].getLength();
      cLine[i][j].Draw(x, y);
      //fill(0);
      //text("" + (cLine[i][j].getAnimationTIme()-cLine[i][j].getTime()), x, y);
    }
  }
}