package sokoban;

import com.codingame.gameengine.runner.SoloGameRunner;

public class SokobanMain {

    private static int level = 37;
    public static void main(String[] args) {
        if(args.length > 0) {
            int oldValue = level;
            try {
                level = Integer.parseInt(args[0]);
            } catch (Exception e) {
                level = oldValue;
            }
        }
        LevelSolver solver = new LevelSolver();
        solver.solve(SokobanMain.getLevel());

        SoloGameRunner gameRunner = new SoloGameRunner();
        gameRunner.setAgent(Agent.class);
        gameRunner.setTestCase("test" + level + ".json");

        gameRunner.start();
    }

    public static int getLevel() {
        return level;
    }
}
