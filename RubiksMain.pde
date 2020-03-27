import peasy.*;
PeasyCam cam;

//to index colors
final int R = 0;
final int L = 1;
final int U = 2;
final int F = 3;
final int D = 4;
final int B = 5;


int dim = 3; //dimension = 3, could change for bigger
Cubie[] cube = new Cubie[dim * dim * dim]; //rows, columns, z

void setup(){
  size(800, 800, P3D); //drawing in 3D
  cam = new PeasyCam(this, 1000); //how zoomed in/out
  int index = 0;
  for (int x = -1; x <= 1; x++){
      for (int y = -1; y <= 1; y++){
        for (int z = -1; z <= 1; z++){
          PMatrix3D matrix = new PMatrix3D();
          matrix.translate(x, y, z);
          cube[index] = new Cubie(matrix, x, y, z);
          index++;
        }
      }
    }
    //cube[2].highlight = true; 
    //cube[0].highlight = true;
    //cube[1].highlight = true;
    //cube[a], counts from z, back to front, meaning front top left cubie = 2
    //13 = center of cube
  }
  
int index = 0;
//ROTATE FRONT, M, BACK ANTI/CLOCK
void turnZ(int index, int dir){ //where index = -1 for back face, index = 0 for middle, index = 1 for front face
  for (int i = 0; i < cube.length; i++){
    Cubie qb = cube[i];
    if (qb.z == index){
      //example rotation 90' clockwise
      // 1,-1 -> -1,-1
      // 0,-1 -> -1,0
      PMatrix2D matrix = new PMatrix2D();
      //making 2D matrix out of x, y as not changing z
      matrix.rotate(dir * HALF_PI);
      matrix.translate(qb.x, qb.y);
      qb.turnFacesZ(dir);
      qb.update(round(matrix.m02), round(matrix.m12), round(qb.z));
    }
  }
}
 
//U, M, D
void turnY(int index, int dir){ //where index = -1 for back face, index = 0 for middle, index = 1 for front face
  for (int i = 0; i < cube.length; i++){
    Cubie qb = cube[i];
    if (qb.y == index){
      //example rotation 90' clockwise
      // 1,-1 -> -1,-1
      // 0,-1 -> -1,0
      PMatrix2D matrix = new PMatrix2D();
      //making 2D matrix out of x, y as not changing z
      matrix.rotate(dir * HALF_PI);
      matrix.translate(qb.x, qb.z);
      qb.turnFacesY(dir);
      qb.update(round(matrix.m02), qb.y, round(matrix.m12));
    }
  }
}

//L, M, R
void turnX(int index, int dir){ //where index = -1 for back face, index = 0 for middle, index = 1 for front face
  for (int i = 0; i < cube.length; i++){
    Cubie qb = cube[i];
    if (qb.x == index){
      //example rotation 90' clockwise
      // 1,-1 -> -1,-1
      // 0,-1 -> -1,0
      PMatrix2D matrix = new PMatrix2D();
      //making 2D matrix out of x, y as not changing z
      matrix.rotate(dir * HALF_PI);
      matrix.translate(qb.y, qb.z);
      qb.turnFacesX(dir);
      qb.update(qb.x, round(matrix.m02), round(matrix.m12));
    }
  }
}

String keys = "";
void keyPressed(char move){
  keys.append(String(key));

  switch(key)
  {
    case ' ':
      print(keys);
    //lower case: clockwise, upper case: primes
    case 'b':
      turnZ(-1, -1);
      break;
    case 'B':
      turnZ(-1, 1);
      break;
      
    case 'f':
      turnZ(1, 1);
      break;
    case 'F':
      turnZ(1, -1);
      break;
      
    case 's':
      turnZ(0, 1);
      break;
    case 'S':
      turnZ(0, -1);
      break;      
      
    case 'L':
      turnX(-1, 1);
      break;
    case 'l':
      turnX(-1, -1);
      break;
      
    case 'm':
      turnX(0, -1);
      break;
    case 'M':
      turnX(0, 1);
      break;
      
    case 'r':
      turnX(1, 1);
      break;
    case 'R':
      turnX(1, -1);
      break;      

    case 'u':
      turnY(-1, 1);
      break;
    case 'U':
      turnY(-1, -1);
      break; 
      
    case 'e':
      turnY(0, -1);
      break;
    case 'E':
      turnY(0, 1);
      break;    
      
    case 'd':
      turnY(1, -1);
      break;
    case 'D':
      turnY(1, 1);
      break;
  }
}
  
  

void draw(){
  background(200);
  scale(100);
  
    for (int i = 0; i < cube.length; i++){
          cube[i].show();
          
          if (i % 2 == 0){
            fill(255);
          }
        }
  
  
}
