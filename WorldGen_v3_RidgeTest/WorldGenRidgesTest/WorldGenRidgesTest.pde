import controlP5.*;

ControlP5 cp5;
float[][] heightMap;
float[][] temperatureMap;
int mapWidth, mapHeight;

//Default starting values, see Presets for slider starter values
int seed = 1;
int sliderPosition = 0;
int buttonPosition = 0;
boolean guiShow = true;
int currentMap = 0;

public void setup() {
  //Setup window and map
  size(1024, 1024);
  heightMap = new float[height][width];
  mapWidth = width;
  mapHeight = height;

  //Configure GUI
  cp5 = new ControlP5(this);
  createGUISliderTitle("HeightMap Configuration", true);
  createGUISlider("intensity1", 1, 30);
  createGUISlider("power1", 0, 50);
  createGUISlider("falloff1", 0, 10);
  createGUISlider("octaves1", 1, 15);
  createGUISlider("circularFalloff1", 0, 1);
  createGUISlider("blendPower12", 0, 1);
  createGUISlider("intensity2", 1, 30);
  createGUISlider("power2", 0, 50);
  createGUISlider("falloff2", 0, 10);
  createGUISlider("octaves2", 1, 15);
  createGUISlider("circularFalloff2", 0, 1);

  createGUISliderTitle("TemperatureMap Configuration", false);
  createGUISlider("equatorOffset", -height/2, height/2);
  createGUISlider("temperatureFalloff", 0, 1);
  createGUISlider("temperatureHeight", 0, 1);
  
  CallbackListener mapCallbackListener = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      int buttonPressed = int(theEvent.getController().getValue());
      currentMap = buttonPressed;
      drawMap(buttonPressed);
    }
  };

  createGUIMapButton("Height Map", 0, mapCallbackListener);
  createGUIMapButton("Temperature Map", 1, mapCallbackListener);
  
  //Generate and display the default map
  generateAllMaps();
  drawMap(0);
}

public void createGUISliderTitle(String name, Boolean first) {
  if (!first) {
    sliderPosition += 10;
  }
  cp5.addLabel(name).setPosition(0, sliderPosition);
  sliderPosition += 10;
}

public void createGUISlider(String name, int min, int max) {
  cp5.addSlider(name).setPosition(0, sliderPosition).setRange(min, max);
  sliderPosition += 10;
}

public void createGUIMapButton(String name, int value, CallbackListener callbackListener) {
  cp5.addButton(name).setPosition(width - 80, buttonPosition).setValue(value).onRelease(callbackListener);
  buttonPosition += 20;
}

public void draw() {
}

public void keyPressed() {
  switch (key) {
  case '1': //Previous Seed
    if (seed <= 0) {
      seed = 0;
    } else {
      seed -= 1;
    }
    generateAllMaps();
    drawMap(currentMap);
    break;
  case '2': //Next Seed
    seed += 1;
    generateAllMaps();
    drawMap(currentMap);
    break;
  case 'q':
    if (guiShow) {
      cp5.hide();
      guiShow = false;
    } else {
      cp5.show();
      guiShow = true;
    }
    drawMap(currentMap);
    break;
  }
}

public void mouseReleased() {
  generateAllMaps();
  drawMap(currentMap);
}

public void generateAllMaps(){
  generateHeightMap();
  generateTemperatureMap();
}
