//Change-able settings
int scale = 5;
int w = 1000;
int h = 1000;
int renderMode = 1; // 1:2d, 2:3d
float intensity = 0.04;
boolean wireFrame = false;
int waterlvl = 70;
int beachlvl = 80;
int plainlvl = 110;
int forestlvl = 140;
int mountainlvl = 180;
int snowlvl = 255;
int lod = 1;
float falloff = 1;
boolean smoothingFunction = true;

//Unchangeable
int cols, rows;
color water = color(30, 144, 255);
color beach = color(76, 70, 50);
color plain = color(0, 204, 0);
color forest = color(0, 51, 25);
color mountain = color(128, 128, 128);
color snow = color(255, 255, 255);
float seed;
float[][] heightMap;

void setup() {
    size(1000, 1000, P3D);
    Generate();
    Draw();
}

void draw() {
    //
}

void keyPressed() {
    boolean regen = false;
    switch (key) {
        case '1': //Set 2d render
            renderMode = 1;
            break;
        case '2': //Set 2d render
            renderMode = 2;
            break;
        case 'q': //Regenerate seed
            NewSeed();
            regen = true;
            break;
        case 'a': //Toggle wireframe
            if (wireFrame) {
                wireFrame = false;
            } else {
                wireFrame = true;
            }
            break;
        case 'w': //Increase scale
            scale += 1;
            regen = true;
            break;
        case 's': //Decrease scale
            scale -= 1;
            if (scale < 1) {
                scale = 1;
            }
            regen = true;
            break;
        case 'e': //Increase intensity
            intensity += 0.002;
            regen = true;
            break;
        case 'd': //Decrease intensity
            intensity -= 0.002;
            if (intensity < 0.002) {
                intensity = 0.002;
            }
            regen = true;
            break;
        case 'r': //Increase waterlevel
            waterlvl += 1;
            break;
        case 'f': //Decrease waterlevel
            waterlvl -= 1;
            break;
        case 't': //Increase beachlevel
            beachlvl += 1;
            break;
        case 'g': //Decrease beachlevel
            beachlvl -= 1;
            break;
        case 'y': //Increase plainlevel
            plainlvl += 1;
            break;
        case 'h': //Decrease plainlevel
            plainlvl -= 1;
            break;
        case 'u': //Increase forestlevel
            forestlvl += 1;
            break;
        case 'j': //Decrease forestlevel
            forestlvl -= 1;
            break;
        case 'i': //Increase mountainlevel
            mountainlvl += 1;
            break;
        case 'k': //Decrease mountainlevel
            mountainlvl -= 1;
            break;
        case 'o': //Increase snowlevel
            snowlvl += 1;
            break;
        case 'l': //Decrease snowlevel
            snowlvl -= 1;
            break;
        case 'z': //Increase lod
            lod += 1;
            regen = true;
            break;
        case 'x': //Decrease lod
            lod -= 1;
            if (lod < 1) {
                lod = 1;
            }
            regen = true;
            break;       
        case 'c': //Increase falloff
            falloff += 0.01;
            regen = true;
            break;
        case 'v': //Decrease falloff
            falloff -= 0.01;
            if (falloff < 0) {
                falloff = 0;
            }
            regen = true;
            break;
        case 'b': //Toggle smoothing
            if (smoothingFunction) {
                smoothingFunction = false;
            } else {
                smoothingFunction = true;
            }
            regen = true;
            break;     
    }


    if (regen) {
        Generate();
    }
    Draw();
}