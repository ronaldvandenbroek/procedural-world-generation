package nl.ronaldvandenbroek.worldgen.calculation;

public class TwoDimensionalArrayUtility {
    /**
     * Merge the two given arrays via linear interpolation
     * Where array 1 and 2 are the same size
     * @param array1 float[][]
     * @param array2 float[][]
     * @param weight float between 0 and 1
     * @return float[][]
     */
    public static float[][] merge(float[][] array1, float[][] array2, float weight) {
        // Check if the arrays are the same size
        if (array1.length != array2.length || array1[0].length != array2[0].length){
            return null;
        }

        // Check if weight is within constraints
        if (weight < 0.0f || weight > 1.0f){
            return null;
        }

        // Create the new array
        int mapHeight = array1.length;
        int mapWidth = array1[0].length;
        float[][] mergedArray = new float[mapHeight][mapWidth];

        // Merge the array cells
        for (int h = 0; h < mapHeight; h++) {
            for (int w = 0; w < mapWidth; w++) {
                mergedArray[h][w] = array1[h][w] * weight + array2[h][w] * (1.0f - weight);
            }
        }
        return mergedArray;
    }

    /**
     * Re-map all array values from one range to another
     * Should replace the processing map function: map(array[h][w], initialMin, initialMax, min, max)
     * @param array float[][]
     * @param min float smaller than max
     * @param max float
     * @return float[][]
     */
    public static float[][] map(float[][] array, float min, float max) {
        if (min >= max){
            return null;
        }

        int arrayHeight = array.length;
        int arrayWidth = array[0].length;

        //Determine min and max value of the original map
        float initialMin = Float.POSITIVE_INFINITY;
        float initialMax = Float.NEGATIVE_INFINITY;
        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                if (array[h][w] <= initialMin) {
                    initialMin = array[h][w];
                }
                if (array[h][w] >= initialMax) {
                    initialMax = array[h][w];
                }
            }
        }

        //Map to min and max
        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                float result = (array[h][w] - initialMin) * (max - min) / (initialMax - initialMin) + min;
                array[h][w] = result;
            }
        }

        return array;
    }
}
