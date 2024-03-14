package sokoban;

import com.codingame.gameengine.runner.SoloGameRunner;

import java.io.*;
import java.util.Scanner;

public class SokobanMain {

    public static void main(String[] args) throws Exception {
        Scanner config = new Scanner(new File("config.txt"));
        int level = Integer.parseInt(config.nextLine());
        config.close();

        LevelSolver solver = new LevelSolver();
        solver.solve(level);

        SoloGameRunner gameRunner = new SoloGameRunner();
        gameRunner.setAgent(Agent.class);
        gameRunner.setTestCase("test" + level + ".json");

        gameRunner.start();
    }
}
