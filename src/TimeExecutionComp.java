import fr.uga.pddl4j.parser.DefaultParsedProblem;
import fr.uga.pddl4j.parser.ErrorManager;
import fr.uga.pddl4j.parser.Message;
import fr.uga.pddl4j.parser.Parser;
import fr.uga.pddl4j.plan.Plan;
import fr.uga.pddl4j.planners.LogLevel;
import fr.uga.pddl4j.problem.DefaultProblem;
import fr.uga.pddl4j.problem.Problem;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;

public class TimeExecutionComp {

    public static void main(String[] args) {
        if(args.length != 1) {
            System.err.println("Need one arg for the type of problem to use");
            System.exit(1);
        }

        try {
            final String PATH = "pddl/" + args[0];
            File directory = new File(PATH);

            File[] problems = directory.listFiles();
            assert problems != null;

            // Creates an instance of the PDDL parser
            final Parser parser = new Parser();
            parser.setLogLevel(LogLevel.OFF);

            for(File fileProblem : problems) {
                if(fileProblem.getName().contains("domain")) {
                    continue;
                }

                // Parses the domain and the problem files.
                final DefaultParsedProblem parsedProblem = parser.parse(PATH + "/domain.pddl", PATH + "/" + fileProblem.getName());
                // Gets the error manager of the parser
                final ErrorManager errorManager = parser.getErrorManager();
                // Checks if the error manager contains errors
                if (!errorManager.isEmpty()) {
                    // Prints the errors
                    for (Message m : errorManager.getMessages()) {
                        System.out.println(m.toString());
                    }
                } else {
                    // Create a problem
                    final Problem problem = new DefaultProblem(parsedProblem);
                    // Instantiate the planning problem
                    problem.instantiate();

                    long begin = System.currentTimeMillis();
                    ASP planner = new ASP();
                    planner.setLogLevel(LogLevel.OFF);
                    Plan plan = planner.solve(problem);
                    long end = System.currentTimeMillis();

                    int nb_steps = plan.actions().size();

                    System.out.print(nb_steps + " ");
                    System.out.print(convertToSeconds(end - begin) + " ");

                    begin = System.currentTimeMillis();
                    SATEncoding encoding = new SATEncoding(problem, nb_steps);
                    encoding.solve();
                    end = System.currentTimeMillis();
                    System.out.println(convertToSeconds(end - begin));
                }
            }
            // This exception could happen if the domain or the problem does not exist
        } catch (IOException ignored) {
        }
    }

    private static String convertToSeconds(long time) {
        DecimalFormat df = new DecimalFormat("#.####");
        float n = (float) time / 1000;
        return df.format(n);
    }
}
