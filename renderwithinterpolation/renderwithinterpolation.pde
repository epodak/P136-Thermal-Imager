//Phoenix Game Development
//27/9/2015


//This function originally obtained from here:
//http://stackoverflow.com/questions/3018313/algorithm-to-convert-rgb-to-hsv-and-hsv-to-rgb-in-range-0-255-for-both
//Rewritten for processing by Phoenix Game Development

color hsv2rgb(int huein)
{
  //println(huein);
  float h = abs(255-huein);
  float s = 128.0;
  float v = 128.0;

  float r = 0.0;
  float g = 0.0;
  float b = 0.0;

  float      hh, p, q, t, ff;
  int        i;
  color         out;

  if (s <= 0.0) {       // < is bogus, just shuts up warnings
    r = v;
    g = v;
    b = v;

    out = color(r, g, b);

    return out;
  }
  hh = h;
  if (hh >= 360.0) hh = 0.0;
  hh /= 60.0;
  i = (int)hh;
  ff = hh - i;
  p = v * (1.0 - s);
  q = v * (1.0 - (s * ff));
  t = v * (1.0 - (s * (1.0 - ff)));

  switch(i) {
  case 0:
    //   print("0");
    //   print(" ");
    //   print(r);
    //   print(" ");
    //   print(g);
    //   print(" ");
    //   print(b);
    //   print(" ");
    //    print(h);
    //   print(" ");
    //    print(huein);

    //   println("");
    r = v;
    g = t;
    b = p;
    break;
  case 1:
    //   println("1");
    r = q;
    g = v;
    b = p;
    break;
  case 2:
    //    println("2");
    r = p;
    g = v;
    b = t;
    break;

  case 3:
    //    println("3");
    r = p;
    g = q;
    b = v;
    break;
  case 4:
    //    println("4");
    r = t;
    g = p;
    b = v;
    break;
  case 5:
    //    println("5");
  default:
    r = v;
    g = p;
    b = q;
    break;
  }
  out = color(r, g, b);
  return out;
}



int[][] rawarray = new int[80][60];
int[][] interpolatedarray = new int[80*2][60*2];


void renderrawimage() {

  int xpos = 0;
  int ypos = 0;

  for (int i = 0; i < 80; i++) {

    for (int j = 0; j < 60; j++) {

      int col = rawarray[i][j];

      color c =  hsv2rgb(col);

      noStroke(); //prevents visible borders on squares

      fill(c);
      // println(col);

      rect(xpos, ypos, 4, 4);

      xpos+=incamount;

      if (xpos >=(80*incamount)) {
        xpos = 0;
        ypos+=incamount;
      }

      if (ypos >= (60*incamount))
        ypos = 0;
    }
  }
}

void populateinterpolatedarray() {

  for (int i = 0; i < 80; i++) {

    print("1: ");
    for (int j = 0; j < 60; j++) {



      int col;

      int ix = 0;
      int iy = 0;

      if (i < 80 && j < 60) {
        ix = i;
        iy = j;
        col = rawarray[ix][iy]; //Get "Raw" value
      } else {
        col = 0;
      }
      col = rawarray[i][j]; //Get 


      //   if (j<60)
      //  col = rawarray[ix][iy]; //Get "Raw" value
      //     else
      //col = rawarray[i][0]; //Get "Raw" value


      // interpolatedarray[i][j] = col; //set raw value (this does not change)

      //Interpolate:
      //scale new points to correct range:
      int newx = i*1;
      int newy = j*1;

      interpolatedarray[newx][newy] = col;
      //  interpolatedarray[newx][newy+1] = col;
      //  interpolatedarray[newx+1][newy] = col;
      // interpolatedarray[newx+1][newy+1] = col;


      print(col);
      print(" ");

      // color c =  hsv2rgb(col);
    }
    println("1*");
  }
}

int incamount = 4;
void renderinterpolatedimage() {
  //first, populate the interpolated array:
  //populateinterpolatedarray();


  //interpolatedarray = (int[][]) expand(rawarray);

  int xpos = 0;
  int ypos = 0;

  int resx = 80*2;
  int resy = 60*2;

  for (int i = 0; i < 80; i++) {
    print("2: ");
    for (int j = 0; j < 60; j++) {

     // int col = rawarray[i][j];//interpolatedarray[i][j];

    //  print(col);
    //  print(" ");

    //  color c =  hsv2rgb(col);
      
         noStroke(); //prevents visible borders on squares
         
      //Grab neighbouring values:
    int value1 = rawarray[i][j];  
     
     int ix = i;
     int iy = j;
     
     if(ix >=79)
     ix = 78;
     
     if(iy >=59)
     iy = 58;
     
     int value2 = rawarray[ix][iy+1];    
     int value3 = 90;//rawarray[ix+1][iy];   
     int value4 = 90;//rawarray[ix+1][iy+1];

    int ivalue1 = (value1+value2)/2;
    int ivalue2 = (value1+value3)/2;
    int ivalue3 = (value1+value4)/2;

print(value1);
print(" ");
print(value2);
print(" ");
print(value3);
print(" ");
print(value4);
print(" ");
print(ivalue1);
print(" ");
print(ivalue2);
print(" ");
print(ivalue3);
println("");

      fill(hsv2rgb(value1));
     rect(xpos, ypos, incamount/2,incamount/2);
      
     fill(hsv2rgb(ivalue1));
     rect(xpos+2, ypos, incamount/2, incamount/2);
       
       fill(hsv2rgb(ivalue2));
       rect(xpos, ypos+2, incamount/2, incamount/2);
       
        fill(hsv2rgb(ivalue3));
           rect(xpos+2, ypos+2, incamount/2, incamount/2);

    //  xpos++;

      //   rect(xpos+1, ypos, 4, 4);

      xpos+=incamount;

      if (xpos >=(80*incamount)) {
        xpos = 0;
        ypos+=incamount;
      }

      if (ypos >= (60*incamount))
        ypos = 0;
    }
    
    
    println("2*");
  }
}


void setup() {
  size(1024, 768);

  String lines[] = loadStrings("output.txt"); 

  String image = "";
  for (int i = 0; i < lines.length; i++) {
    //println(lines[i]);
    image = image + lines[i];
  }

  int xpos = 0;
  int ypos = 0;

  int count = 0;

  int[] dataasint = int(split(image, ' '));

  for (int i = 0; i < 80; i++) {

    for (int j = 0; j < 60; j++) {

      int col = dataasint[count];

      rawarray[i][j] = col;

      count++;
    }
  }

//  renderrawimage();
  renderinterpolatedimage();
  //  for (int i : dataasint) {   
  // }

  println("COUNT: ");

  println(count);

  println();
}