public void information(){
  textFont(font);       
  fill(255, 0, 0);

  textAlign(LEFT);
  offset = 0;
  
  writeText("W/S| Intensity:" + intensity / 1000.0f);
  writeText("E/D| Octaves:" + octaves);
  writeText("R/F| Falloff:" + falloff / 10.0f);
  writeText("T/G| Cutoff:" + cutoff / 100.0f);
  writeText("A| Egde:" + edge);
}

public void writeText(String string){
  offset += 20;
  text(string,0,offset);
}