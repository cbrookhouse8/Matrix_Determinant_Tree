// before becoming a repository this
// file was stored locally as fact_disp_exp_8

void setup() {
 size(1800,1000);
 background(255);
   noStroke();
   fill(0);
   
  float[] nums = new float[16];
  
  for (int i = 0 ; i < nums.length ; i++) {
     nums[i] = round(random(0,10));
  }

   f(nums,width-100,3*height/5);
}

void f(float[] a,float w, float h) {
  
  int dimension = round(pow(a.length,0.5));
  
  // get this recursive work done before
  // calling the main recursive function
  
  float minSpace = w/float(fact(dimension)-1);
  float maxGap = float(fact(dimension-1))*minSpace;
  
  g(a,1,0,dimension,0,-1,maxGap,minSpace,w,h);
}

void g(float[] a, int level, int position, int dimension, int parentPos, int index, float parentSpace, float minSpace, float w, float h) {
  float space = parentSpace/(dimension-(level-1));
  
  if (level == 1) {
        space = parentSpace; // i.e. maxSpace 
  }
  
  float leftStart = ((space/2)-(minSpace/2))+(width-w)/2;
  
  if (level < dimension) {
    float y = ((level-1)*(h/(dimension-2)))+(height-h)/2;  // (dimension-2) can be made (dimension-1) if you wish
 
       int idx = position;
        
        if (level != 1) {
         idx += index*(1+dimension-level); 
        }
       
        if (level >= dimension-1) {
         leftStart = (width-w)/2;
         space = minSpace;
        }
  
    int no = dimension-(level-1);
     if (position < no) {
       
        display(a,new PVector(leftStart+(idx*space),y),1,position+1,pow(-1,position+2)*a[position],30);
        
        g(a,level,position+1,dimension,parentPos,index,parentSpace,minSpace,w,h);           // move along this level
        g(subArray(a,1,position+1),level+1,0,dimension,position,idx,space,minSpace,w,h);    // go to the next level
     } // pos < no
  } // level <= dimension
  
} // end of g()

void display(float[] a, PVector c, int _i, int _j, float scalar, float sf) {
  int side = round(pow(a.length,0.5));
  PVector shift = new PVector(c.x-((side-1)*sf/2),c.y-((side-1)*sf/2));
  fill(0);
  
  for (int i = 1 ; i <= side ; i++) {
    for (int j = 1 ; j <= side ; j++) {
      int idx = ((i-1)*side)+j-1;
      int val = round(a[idx]*1000)/1000;
      
      float x = sf*(j-1);
      float y = sf*(i-1);
            
            textAlign(CENTER,CENTER);
            text(val,shift.x+x,shift.y+y);
    }
  }
  
  if (_i > 0 && _j > 0) {
    stroke(0);
    line(shift.x,shift.y+((_i-1)*sf),shift.x+((side-1)*sf),shift.y+((_i-1)*sf));
    line(shift.x+((_j-1)*sf),shift.y,shift.x+((_j-1)*sf),shift.y+((side-1)*sf));
  }
  
  int scr = round(scalar*1000)/1000;
  
  fill(0,0,255);
  text(scr,shift.x-(3*sf/5),c.y);
} // end of display

float[] subArray(float[] a, int row, int column) {
  int dimension = round(pow(a.length,0.5));
  float[] newA = new float[round(pow(dimension-1,2))];
  int iNew = 0;
  
  for (int i = 0 ; i < a.length ; i++) {
    int rowLow = (row-1)*dimension;
    int rowHigh = row*dimension;
    int colCheck = (i-(column-1))%dimension;
    if (!(rowLow <= i && i < rowHigh)) {
      if (colCheck != 0) {
       newA[iNew] = a[i];
       iNew++;
      }
    }
  }
  
  return newA;
}

int fact(int a) {
  if (a > 1) {
     return a*fact(a-1); 
  } else {
     return 1; 
  }
}