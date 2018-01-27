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
  writeTextLeft("A| Egde:" + edge);
  writeTextLeft("Z| GreyScale:" + greyScale);
  writeTextLeft("X| Debug:" + debug);
  
  if(debug){
      textAlign(RIGHT);
      offset = 0;
      writeTextRight("Seed:" + seed);
      writeTextRight("HeightRange:[" + minHeight + "][" + maxHeight + "]");
      writeTextRight("TempRange:[" + minTemp + "][" + maxTemp + "]");
  }
}

public void writeTextLeft(String string){
  offset += 20;
  text(string,0,offset);
}

public void writeTextRight(String string){
  offset += 20;
  text(string,1000,offset);
}