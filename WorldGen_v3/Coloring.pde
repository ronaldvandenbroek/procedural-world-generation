color baseC = color(105, 130, 80);
color topC = color(55, 58, 58);
color seaC = color(85, 155, 168);
color textC = color(0);

color getColor(float z){
  return lerpColor(baseC, topC, z);
}