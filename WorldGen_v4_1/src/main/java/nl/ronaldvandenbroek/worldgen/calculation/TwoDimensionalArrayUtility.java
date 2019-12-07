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
    public float[][] merge(float[][] array1, float[][] array2, float weight) {
        // Check if the arrays are the same size
        if (getArrayHeight(array1) != getArrayHeight(array2) || getArrayWidth(array1) != getArrayWidth(array2)){
            return null;
        }

        // Check if weight is within constraints
        if (weight < 0.0f || weight > 1.0f){
            return null;
        }

        // Create the new array
        int mapHeight = getArrayHeight(array1);
        int mapWidth = getArrayWidth(array2);
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
    public float[][] map(float[][] array, float min, float max) {
        if (min >= max){
            return null;
        }

        int arrayHeight = getArrayHeight(array);
        int arrayWidth = getArrayWidth(array);
        float initialMin = getLowestArrayValue(array);
        float initialMax = getHighestArrayValue(array);

        //Map to min and max
        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                float result = (array[h][w] - initialMin) * (max - min) / (initialMax - initialMin) + min;
                array[h][w] = result;
            }
        }

        return array;
    }

    /**
     * Curve the array values via powers
     * @param array float[][]
     * @param power float
     * @return float[][]
     */
    public float[][] curve(float[][] array, float power) {
        int arrayHeight = getArrayHeight(array);
        int arrayWidth = getArrayWidth(array);

        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                array[h][w] = (float)Math.pow(array[h][w], power);
            }
        }
        return array;
    }

    /**
     * Create ridges within the array via absolute
     * @param array float[][]
     * @return float[][]
     */
    public float[][] ridge(float[][] array) {
        int arrayHeight = getArrayHeight(array);
        int arrayWidth = getArrayWidth(array);

        float initialMin = getLowestArrayValue(array);
        float initialMax = getHighestArrayValue(array);
        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                float centerPoint = (initialMax + initialMin) / 2;
                //float moveHalfDown = array[h][w] - centerPoint;
                //float absolute = Math.abs(moveHalfDown);
                //float moveHalfUp = absolute + centerPoint;
                //float flip = initialMax + (moveHalfUp * -1);
                //float flip = moveHalfUp * -1;

                array[h][w] = (initialMax + ((Math.abs(array[h][w] - centerPoint) + centerPoint) * -1)) * 2;
            }
        }
        float afterMin = getLowestArrayValue(array);
        float afterMax = getHighestArrayValue(array);

        //System.out.println(initialMin + " " + initialMax);
        //System.out.println(afterMin + " " + afterMax);

        return array;
    }

    /**
     * Add percentile circular falloff to the array
     * @param array float[][]
     * @param falloffStrength float
     * @return float[][]
     */
    public float[][] circularFalloffPercentile(float[][] array, float falloffStrength){
        int arrayHeight = getArrayHeight(array);
        int centerHeight = arrayHeight / 2;
        int arrayWidth = getArrayWidth(array);
        int centerWidth = arrayWidth / 2;

        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                array[h][w] -= array[h][w] * calculateDistancePercentage(h, w, centerHeight, centerWidth, falloffStrength);
            }
        }
        return array;
    }

    /**
     * Add absolute circular falloff to the array
     * @param array float[][]
     * @param falloffStrength float
     * @return float[][]
     */
    public float[][] circularFalloffAbsolute(float[][] array, float falloffStrength){
        int arrayHeight = getArrayHeight(array);
        int centerHeight = arrayHeight / 2;
        int arrayWidth = getArrayWidth(array);
        int centerWidth = arrayWidth / 2;

        float maxHeight = getHighestArrayValue(array);
        float minHeight = getLowestArrayValue(array);

        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                array[h][w] -= maxHeight * calculateDistancePercentage(h, w, centerHeight, centerWidth, falloffStrength);

                if (array[h][w] < minHeight){
                    array[h][w] = minHeight;
                }
            }
        }
        return array;
    }

    /**
     * Calculate the percentage of the way to the border of the grid you are from any given point
     * @param h int
     * @param w int
     * @param centerHeight int
     * @param centerWidth int
     * @param falloffStrength float
     * @return double
     */
    private double calculateDistancePercentage(int h, int w, int centerHeight, int centerWidth, float falloffStrength){
        //double hDistance = Math.pow(Math.abs(centerHeight - h), 2);
        //double wDistance = Math.pow(Math.abs(centerWidth - w), 2);
        //double distance = Math.sqrt(hDistance + wDistance);
        //double distancePercentage = (distance / centerHeight) * falloffStrength;
        double distancePercentage = (Math.sqrt(Math.pow(Math.abs(centerHeight - h), 2) + Math.pow(Math.abs(centerWidth - w), 2)) / centerHeight) * falloffStrength;
        if (distancePercentage > 1){
            distancePercentage = 1;
        }
        return distancePercentage;
    }

    /**
     * Get the highest value in the 2D array
     * @param array float[][]
     * @return float
     */
    public float getHighestArrayValue(float[][] array){
        int arrayHeight = getArrayHeight(array);
        int arrayWidth = getArrayWidth(array);

        float max = Float.NEGATIVE_INFINITY;
        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                if (array[h][w] >= max) {
                    max = array[h][w];
                }
            }
        }
        return max;
    }

    /**
     * Get the lowest value in the 2D array
     * @param array float[][]
     * @return float
     */
    public float getLowestArrayValue(float[][] array){
        int arrayHeight = getArrayHeight(array);
        int arrayWidth = getArrayWidth(array);

        float min = Float.POSITIVE_INFINITY;
        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                if (array[h][w] <= min) {
                    min = array[h][w];
                }
            }
        }
        return min;
    }

    /**
     * Get the height (amount of rows) of the array
     * @param array float[][]
     * @return int
     */
    public int getArrayHeight(float[][] array){
        return array.length;
    }

    /**
     * Get the width (amount of columns) of the array
     * @param array float[][]
     * @return int
     */
    public int getArrayWidth(float[][] array){
        return array[0].length;
    }
}
