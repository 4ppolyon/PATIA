package sokoban;

import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class LevelSolver {

    private static final String JSON_PATH = "config/";
    private static final String PDDL_PATH = "pddl/";
    private static final String PLAN_PATH = "plans/";
    private int level;

    public LevelSolver() {
    }

    public int solve(int level) {
        this.level = level;

        try {
            jsonToPddl();
            findPlan();
        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        }

        return 0;
    }

    private void jsonToPddl() throws Exception {
        LevelParser parser = new LevelParser(JSON_PATH + "test" + this.level + ".json", PDDL_PATH + "problem" + this.level + ".pddl");
        parser.writeFile();
    }

    private void findPlan() throws Exception {
        String[] command = new String[]{"java", "-cp", "libs/pddl4j-4.0.0.jar", "fr.uga.pddl4j.planners.statespace.HSP", PDDL_PATH + "domain.pddl", PDDL_PATH + "problem" + this.level + ".pddl"};

        ProcessBuilder plannerBuilder = new ProcessBuilder(command);
        Process planner = plannerBuilder.start();
        BufferedReader rawPlan = new BufferedReader(new InputStreamReader(planner.getInputStream()));
        FileWriter plan = new FileWriter(PLAN_PATH + "plan" + this.level + ".txt");

        String action = null;
        while((action = rawPlan.readLine()) != null) {
            if(action.contains("deplacer")) {
                plan.write(processAction(action) + "\n");
            }
        }

        rawPlan.close();
        plan.close();
    }

    private char processAction(String action) {
        Pattern pattern = Pattern.compile("\\((.*?)\\)");
        Matcher matcher = pattern.matcher(action);
        if(matcher.find()) {
            String[] args = matcher.group(1).trim().split(" ");
            return args[1].toUpperCase().charAt(0);
        }
        return ' ';
    }

    public static void main(String[] args) {
        if(args.length > 0) {
            LevelSolver solver = new LevelSolver();
            int exitCode = solver.solve(Integer.parseInt(args[0]));
            System.exit(exitCode);
        } else {
            System.exit(-1);
        }
    }
}
