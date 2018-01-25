void Draw(){
  
  //Draw
  background(0);
  //stroke(255);
  //stroke(terrain[x][y] * 255);
  //noFill();
  translate(width/2, height/2);
  
  if(renderMode == 2){
    rotateX(PI/3);
  }
        
  translate(-w/2, -h/2);
  
  for (int y = 0; y < rows -1; y++){  
    beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < cols; x++){
          int[] c = getColor(heightMap[x][y]);
        
          fill(c[0], c[1], c[2]);
          if (!wireFrame){
            stroke(c[0], c[1], c[2]);
          }
          else{stroke(0);}
          
          
          if(renderMode == 1){
               vertex(x * scale, y * scale);
               vertex(x * scale, (y + 1) * scale);
          }
          else if(renderMode == 2){
               vertex(x * scale, y * scale, heightMap[x][y]);
              vertex(x * scale, (y + 1) * scale, heightMap[x][y+1]);
          }
      }
      endShape();
  }
}