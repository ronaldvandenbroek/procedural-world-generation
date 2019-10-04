package nl.ronaldvandenbroek.worldgen;

public interface NoiseMapGenerator {
    float[][] generate(int height, int width, int seed, int octaves, float falloff, float intensity);
}
