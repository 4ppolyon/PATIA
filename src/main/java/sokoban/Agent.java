package sokoban;

public class Agent {
    public static void main(String[] args) {
        // The path to the benchmarks directory
        final String benchmarks = "/home/bossyr/Master/S8/PATIA/Sokoban/pddl";

        


        /*PlannerConfiguration config = HSP.getDefaultConfiguration();

        config.setProperty(HSP.DOMAIN_SETTING, benchmarks + "domain.pddl");

        config.setProperty(HSP.PROBLEM_SETTING, benchmarks + "problem01.pddl");

        config.setProperty(HSP.TIME_OUT_SETTING, 1000);

        config.setProperty(HSP.LOG_LEVEL_SETTING, LogLevel.INFO);

        config.setProperty(HSP.HEURISTIC_SETTING, StateHeuristic.Name.MAX);

        config.setProperty(HSP.WEIGHT_HEURISTIC_SETTING, 1.2);

        Planner planner = Planner.getInstance(Planner.Name.HSP, config);

        StringBuilder solution = new StringBuilder();

        try {
            Plan plan = planner.solve();
            List<Action> actions = plan.actions();

            for (Action a: actions) {
                if (a.getName().contains("est")) {
                    solution.append("R");
                } else if (a.getName().contains("ouest")) {
                    solution.append("L");
                } else if (a.getName().contains("nord")) {
                    solution.append("U");
                } else if (a.getName().contains("sud")) {
                    solution.append("D");
                }
            }
        } catch (InvalidConfigurationException e) {
            e.printStackTrace();
        }*/

        String solution = "DDDD";
        for (char c : solution.toString().toCharArray()) System.out.println(c);
    }
}
