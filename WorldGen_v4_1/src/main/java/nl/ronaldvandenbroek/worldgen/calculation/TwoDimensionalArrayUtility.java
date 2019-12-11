package nl.ronaldvandenbroek.worldgen.calculation;

import static java.lang.Math.abs;

public class TwoDimensionalArrayUtility implements ITwoDimensionalArrayUtility {
    public float[][] merge(float[][] array1, float[][] array2, float weight1, float weight2) {
        float weightPercentage = (weight1 / (weight1 + weight2));
        // System.out.println("Merge Weights: " + weight1 + " " + weight2 + " " + weightPercentage);
        return merge(array1, array2, weightPercentage);
    }

    public float[][] merge(float[][] array1, float[][] array2, float weight) {
        // Check if the arrays are the same size
        if (getArrayHeight(array1) != getArrayHeight(array2) || getArrayWidth(array1) != getArrayWidth(array2)) {
            return null;
        }

        // Check if weight is within constraints
        if (weight < 0.0f || weight > 1.0f) {
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

    public float[][] map(float[][] array, float min, float max, float arrayMin, float arrayMax){
        int arrayHeight = getArrayHeight(array);
        int arrayWidth = getArrayWidth(array);
        float[][] mappedArray = new float[arrayHeight][arrayWidth];

        //Map to min and max
        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                float result = (array[h][w] - arrayMin) * (max - min) / (arrayMax - arrayMin) + min;
                mappedArray[h][w] = result;
            }
        }

//        float afterMin = getLowestArrayValue(mappedArray);
//        float afterMax = getHighestArrayValue(mappedArray);
//        System.out.println("map initial: " + initialMin + " " + initialMax);
//        System.out.println("map after: " + afterMin + " " + afterMax);

        return mappedArray;
    }

    public float[][] map(float[][] array, float min, float max) {
        if (min >= max) {
            return null;
        }

        float initialMin = getLowestArrayValue(array);
        float initialMax = getHighestArrayValue(array);

        // Fix so that if the min and max of an array are the same map will output max instead of min
        if (initialMin == initialMax) {
            initialMin = initialMax - 0.001f;
        }

        return map(array, min, max, initialMin, initialMax);
    }

    public float[][] curve(float[][] array, float power) {
        int arrayHeight = getArrayHeight(array);
        int arrayWidth = getArrayWidth(array);

        float[][] curvedArray = new float[arrayHeight][arrayWidth];

        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                curvedArray[h][w] = (float) Math.pow(array[h][w], power);
            }
        }
        return curvedArray;
    }

    public float[][] add(float[][] array, float min, float max, float amount) {
        int arrayHeight = getArrayHeight(array);
        int arrayWidth = getArrayWidth(array);

        float[][] addedArray = new float[arrayHeight][arrayWidth];

        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                float newValue = array[h][w] + amount;
                if (newValue < min) {
                    newValue = min;
                }
                else if (newValue > max) {
                    newValue = max;
                }
                addedArray[h][w] = newValue;
            }
        }
        return addedArray;
    }

    public float[][] invert(float[][] array) {
        int arrayHeight = getArrayHeight(array);
        int arrayWidth = getArrayWidth(array);

        float max = getHighestArrayValue(array);

        float[][] invertedArray = new float[arrayHeight][arrayWidth];

        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                invertedArray[h][w] = max - array[h][w];
            }
        }
        return invertedArray;
    }

    public float[][] ridge(float[][] array) {
        int arrayHeight = getArrayHeight(array);
        int arrayWidth = getArrayWidth(array);

        float[][] ridgedArray = new float[arrayHeight][arrayWidth];

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

                ridgedArray[h][w] = (initialMax + ((abs(array[h][w] - centerPoint) + centerPoint) * -1)) * 2;
            }
        }

//        float afterMin = getLowestArrayValue(array);
//        float afterMax = getHighestArrayValue(array);
//        System.out.println(initialMin + " " + initialMax);
//        System.out.println(afterMin + " " + afterMax);

        return ridgedArray;
    }

    public float[][] circularFalloffPercentile(float[][] array, float falloffStrength) {
        int arrayHeight = getArrayHeight(array);
        int centerHeight = arrayHeight / 2;
        int arrayWidth = getArrayWidth(array);
        int centerWidth = arrayWidth / 2;

        float[][] falloffArray = new float[arrayHeight][arrayWidth];

        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                falloffArray[h][w] -= array[h][w] * calculateDistancePercentage(h, w, centerHeight, centerWidth, falloffStrength);
            }
        }
        return falloffArray;
    }

    public float[][] circularFalloffAbsolute(float[][] array, float falloffStrength) {
        int arrayHeight = getArrayHeight(array);
        int centerHeight = arrayHeight / 2;
        int arrayWidth = getArrayWidth(array);
        int centerWidth = arrayWidth / 2;

        float[][] falloffArray = new float[arrayHeight][arrayWidth];

        float maxHeight = getHighestArrayValue(array);
        float minHeight = getLowestArrayValue(array);

        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                falloffArray[h][w] = (float) (array[h][w] - (maxHeight * calculateDistancePercentage(h, w, centerHeight, centerWidth, falloffStrength)));

                if (falloffArray[h][w] < minHeight) {
                    falloffArray[h][w] = minHeight;
                }
            }
        }
        return falloffArray;
    }

    public float[][] verticalFalloffAbsolute(float[][] array, int offset) {
        int arrayHeight = getArrayHeight(array);
        int arrayWidth = getArrayWidth(array);
        float centerHeight = arrayHeight / 2f;

        float[][] falloffArray = new float[arrayHeight][arrayWidth];

        for (int h = 0; h < arrayHeight; h++) {
            for (int w = 0; w < arrayWidth; w++) {
                falloffArray[h][w] = centerHeight - abs(h - centerHeight + offset);
            }
        }

//        float min = getLowestArrayValue(falloffArray);
//        float max = getHighestArrayValue(falloffArray);
//        System.out.println("map vertical falloff: " + min + " " + max);

        falloffArray = map(falloffArray, 0, 1, 0, centerHeight);

//        min = getLowestArrayValue(falloffArray);
//        max = getHighestArrayValue(falloffArray);
//        System.out.println("map vertical falloff mapped: " + min + " " + max);

        return falloffArray;
    }

    public double calculateDistancePercentage(int h, int w, int centerHeight, int centerWidth, float falloffStrength) {
        //double hDistance = Math.pow(Math.abs(centerHeight - h), 2);
        //double wDistance = Math.pow(Math.abs(centerWidth - w), 2);
        //double distance = Math.sqrt(hDistance + wDistance);
        //double distancePercentage = (distance / centerHeight) * falloffStrength;
        double distancePercentage = (Math.sqrt(Math.pow(abs(centerHeight - h), 2) + Math.pow(abs(centerWidth - w), 2)) / centerHeight) * falloffStrength;
        if (distancePercentage > 1) {
            distancePercentage = 1;
        }
        return distancePercentage;
    }

    public float getHighestArrayValue(float[][] array) {
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

    public float getLowestArrayValue(float[][] array) {
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

    public int getArrayHeight(float[][] array) {
        return array.length;
    }

    public int getArrayWidth(float[][] array) {
        return array[0].length;
    }
}
