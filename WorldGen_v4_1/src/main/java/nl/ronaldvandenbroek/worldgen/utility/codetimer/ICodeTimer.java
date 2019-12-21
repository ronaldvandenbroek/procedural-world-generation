package nl.ronaldvandenbroek.worldgen.utility.codetimer;

public interface ICodeTimer {
    void start();

    void round();

    void end();

    long averageRoundTime();
}
