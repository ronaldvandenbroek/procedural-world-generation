int offset;
public void information(){
  textFont(font);       
  fill(textC);

  textAlign(LEFT);
  offset = 0;
  writeTextLeft("W/S| Intensity:" + intensity / 1000.0f);
  writeTextLeft("E/D| Octaves:" + octaves);
  writeTextLeft("R/F| Falloff:" + falloff / 10.0f);
  writeTextLeft("T/G| Cutoff:" + cutoff / 100.0f);
  writeTextLeft("Y/H| WindDir:" + windDir);
  writeTextLeft("U/J| EquatorOffset:" + equatorOffset);
  writeTextLeft("I/K| RidgeFactor:" + ridgeFactor);
  writeTextLeft("A| Egde:" + edge);
  writeTextLeft("Z| GreyScale:" + greyScale);
  writeTextLeft("X| Debug:" + debug);
  writeTextLeft("C| Terrain Curving:" + terrainCurving);
  
  if(debug){
      textAlign(RIGHT);
      offset = 0;
      writeTextRight("Seed:" + seed);
      writeTextRight("HeightRange:[" + minHeight + "][" + maxHeight + "]");
      writeTextRight("TempRange:[" + minTemp + "][" + maxTemp + "]");
      writeTextRight("HumRange:[" + minHum + "][" + maxHum + "]");
  }
}

public void writeTextLeft(String string){
  offset += 18;
  text(string,0,offset);
}

public void writeTextRight(String string){
  offset += 18;
  text(string,1000,offset);
}

public void pixelInfo(){
  
  textFont(fontSmall);       
  fill(textC);
  int xM = mouseX;
  int yM = mouseY;

  ellipse( xM, yM, 2, 2 );
  textAlign(LEFT);
  text( "x: " + xM + " y: " + yM + " z:" + nf(terrainMap[yM][xM][0],1,2)+ " t:" + nf(terrainMap[yM][xM][1],1,2) + " h:" + nf(terrainMap[yM][xM][2],1,2) + " p:" + nf(terrainMap[yM][xM][3],1,2), xM + 2, yM );
}