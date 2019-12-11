package nl.ronaldvandenbroek.worldgen;

public interface NoiseMapGenerator {

    float[][] generate(int height, int width, float time, int seed, int octaves, float falloff, float intensity);
}
