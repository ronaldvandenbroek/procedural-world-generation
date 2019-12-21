void Draw() {
    surface.setTitle(getSettings());

    //Draw
    background(0);
    //stroke(255);
    //stroke(terrain[x][y] * 255);
    //noFill();
    translate(width / 2, height / 2);

    if (renderMode == 2) {
        rotateX(PI / 3);
    }

    translate(-w / 2, -h / 2);

    for (int y = 0; y < rows - 1; y++) {
        beginShape(TRIANGLE_STRIP);
        for (int x = 0; x < cols; x++) {
            color c = getColor(heightMap[x][y]);
            fill(c);
            if (!wireFrame) {
                noStroke();
            } else {
                stroke(0);
            }


            if (renderMode == 1) {
                vertex(x * scale, y * scale);
                vertex(x * scale, (y + 1) * scale);
            } else if (renderMode == 2) {
                float z = 0;
                if (heightMap[x][y] > waterlvl) {
                    z = heightMap[x][y];
                } else {
                    z = waterlvl;
                }

                float z1 = 0;
                if (heightMap[x][y + 1] > waterlvl) {
                    z1 = heightMap[x][y + 1];
                } else {
                    z1 = waterlvl;
                }

                vertex(x * scale, y * scale, z);
                vertex(x * scale, (y + 1) * scale, z1);
            }
        }
        endShape();
    }
}