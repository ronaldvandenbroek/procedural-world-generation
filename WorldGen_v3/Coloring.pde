color baseC = color(105, 130, 80);
color topC = color(55, 58, 58);
color seaC = color(85, 155, 168);
color textC = color(0);

color getColor(float z){
  if (greyScale){
    return color(map(z,0,1,0,255));
  }
  else{
    return lerpColor(baseC, topC, z);
  }
}