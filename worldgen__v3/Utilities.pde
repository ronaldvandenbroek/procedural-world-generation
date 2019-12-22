public int add(int number, int amount) {
  return number + amount;
}

public int remove(int number, int amount, int limit) {
  number -= amount;
  if (number < limit) {
    number = limit;
  }     
  return number;
}

public int add(int number, int amount, int min, int max) {
  number += amount;
  if (number > max) {
    return min;
  }
  return number;
}

public int remove(int number, int amount, int min, int max) {
  number -= amount;
  if (number < min) {
    return max;
  }
  return number;
}
