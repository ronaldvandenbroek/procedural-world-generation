package nl.ronaldvandenbroek.worldgen.calculation.noise;

public interface INoiseMapGenerator {
    float[][] generate(int height, int width, float time, int seed, int octaves, float falloff, float intensity);
}
