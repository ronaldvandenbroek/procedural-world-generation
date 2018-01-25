void Generate(){
  NewSeed();
 
  cols = w / scale;
  rows = h / scale;
  heightMap = new float[cols][rows];
  float yoff = 0;
    for (int y = 0; y < rows; y++){  
      float xoff = 0;
      for (int x = 0; x < cols; x++){
          heightMap[x][y] = map(noise(xoff + seed,yoff + seed), 0 , 1 ,0 , 255);

          xoff += intensity;
      }
      yoff += intensity;
  }
}