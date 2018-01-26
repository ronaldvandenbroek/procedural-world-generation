public int add(int number, int amount){
  return number + amount;
}

public int remove(int number, int amount, int limit){
    number -= amount;
    if (number < limit) {
         number = limit;
    }     
    return number;
}