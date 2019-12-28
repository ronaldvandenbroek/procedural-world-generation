package nl.ronaldvandenbroek.worldgen.calculation.noise.simplex;

import nl.ronaldvandenbroek.worldgen.calculation.noise.INoiseMapGenerator;
import nl.ronaldvandenbroek.worldgen.properties.Config;

public class SimplexNoise implements INoiseMapGenerator {
    @Override
    public float[][] generate(int height, int width, float time, int seed, int octaves, float falloff, float intensity) {
        //falloff = falloff / Config.PERLIN_FALLOFF_MODIFIER;
        double intensityDouble = (intensity / Config.PERLIN_INTENSITY_MODIFIER);

        OpenSimplexNoise simplex = new OpenSimplexNoise(seed);

        float[][] noiseMap = new float[height][width];
        double y = 0;
        for (int h = 0; h < height; h++) {
            double x = 0;
            for (int w = 0; w < width; w++) {
                noiseMap[h][w] = (float)
                        (
                            simplex.eval(x, y) +
                                simplex.eval(x * 2, y * 2) / 2 +
                                simplex.eval(x * 3, y * 3) / 3 +
                                simplex.eval(x * 4, y * 4) / 4 +
                                simplex.eval(x * 5, y * 5) / 5 +
                                simplex.eval(x * 6, y * 6) / 6
                        );
                x += intensityDouble;
            }
            y += intensityDouble;
        }
        return noiseMap;
    }
}
