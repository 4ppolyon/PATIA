import fr.uga.pddl4j.parser.DefaultParsedProblem;
import fr.uga.pddl4j.parser.ErrorManager;
import fr.uga.pddl4j.parser.Message;
import fr.uga.pddl4j.parser.Parser;
import fr.uga.pddl4j.plan.Plan;
import fr.uga.pddl4j.planners.LogLevel;
import fr.uga.pddl4j.problem.DefaultProblem;
import fr.uga.pddl4j.problem.Fluent;
import fr.uga.pddl4j.problem.Problem;
import fr.uga.pddl4j.problem.operator.Action;
import fr.uga.pddl4j.util.BitVector;
import org.sat4j.core.VecInt;
import org.sat4j.minisat.SolverFactory;
import org.sat4j.specs.ContradictionException;
import org.sat4j.specs.ISolver;
import org.sat4j.specs.TimeoutException;

import java.io.FileNotFoundException;
import java.util.*;

public class SATEncoding {

    // Le problème à encoder
    private final Problem problem;
    // Le nombre minimal d'étapes du plan pour ce problème
    private final int maxSteps;
    // Pour chaque prédicat, est t'il un effet d'une action
    private final HashMap<Fluent, Action[]> fluentsEffects;
    // Solver sat4j
    private final ISolver solver;
    // Les ids des variables des actions et des prédicats à chaque étape
    private final Map<Integer, Integer> ids;
    private int lastID;

    public SATEncoding(Problem problem, int steps) {
        this.problem = problem;
        this.maxSteps = steps;
        this.fluentsEffects = new HashMap<>();
        this.solver = SolverFactory.newMiniLearningHeap();
        this.ids = new HashMap<>();
        this.lastID = 0;

        for(int i = 0; i < problem.getFluents().size(); i++) {
            final Fluent fluent = problem.getFluents().get(i);
            final List<Action> effectActions = new ArrayList<>();

            for(int j = 0; j < problem.getActions().size(); j++) {
                BitVector positive = problem.getActions().get(j).getUnconditionalEffect().getPositiveFluents();
                BitVector negative = problem.getActions().get(j).getUnconditionalEffect().getNegativeFluents();

                if(positive.get(i) || negative.get(i)) {
                    effectActions.add(problem.getActions().get(j));
                }
            }

            if(!effectActions.isEmpty()) {
                this.fluentsEffects.put(fluent, effectActions.toArray(new Action[0]));
            }
        }

        int nb_actions = problem.getActions().size();
        for (int i = 0; i < maxSteps; i++) {
            if (nb_actions > 1) {
                convertActionDisjunction(i);
            }
            convertStateTransitions(i);
            for (Action action : problem.getActions()) {
                convertAction(action, i);
            }
        }
        convertInitGoal(false);
        convertInitGoal(true);
    }

    public int getID(Object obj, int step) {
        int id = System.identityHashCode(obj) * (step + 1);
        if(!ids.containsKey(id)) {
            ids.put(id, lastID);
            lastID++;
        }
        return ids.get(id);
    }

    public String getPlan() {
        try {
            if(solver.isSatisfiable()) {
                StringBuilder builder = new StringBuilder();

                List<Action> actions = problem.getActions();
                int[] model = solver.model();
                for(int step = 0; step < this.maxSteps; step++) {
                    Iterator<Action> it = actions.iterator();
                    int j = model.length;
                    Action action = null;
                    while(it.hasNext() && j == model.length) {
                        j = 0;
                        action = it.next();
                        while(j < model.length && (model[j] < 0 || Math.abs(model[j]) != getID(action, step))) {
                            j++;
                        }
                    }

                    if(j < model.length) {
                        builder.append(actionToString(action, step)).append("\n");
                    }
                }

                return builder.toString();
            }
        } catch (TimeoutException ignored) {
        }
        return "";
    }

    public void solve() {
        try {
            solver.isSatisfiable();
        } catch (TimeoutException ignored) {
        }
    }

    private void convertInitGoal(boolean goal) {
        final int nb_fluents = problem.getFluents().size();
        final BitVector predicates = goal ? problem.getGoal().getPositiveFluents() : problem.getInitialState().getPositiveFluents();
        final int step = goal ? this.maxSteps : 0;
        for (int i = 0; i < nb_fluents; i++) {
            if(predicates.get(i) || !goal) {
                int[] clause = new int[1];
                clause[0] = (predicates.get(i) ? 1 : -1) * getID(problem.getFluents().get(i), step);
                addClause(clause);
            }
        }
    }

    private void convertAction(Action action, int step) {
        final int nb_fluents = problem.getFluents().size();
        final int actionID = getID(action, step);

        final BitVector precond = action.getPrecondition().getPositiveFluents();
        final BitVector positive = action.getUnconditionalEffect().getPositiveFluents();
        final BitVector negative = action.getUnconditionalEffect().getNegativeFluents();

        for (int i = 0; i < nb_fluents; i++) {
            int[] a = new int[2];
            a[0] = -actionID;
            if (precond.get(i)) {
                a[1] = getID(problem.getFluents().get(i), step);
                try {
                    solver.addClause(new VecInt(a));
                } catch (ContradictionException ignored) {
                }
            }
            if (positive.get(i)) {
                a[1] = getID(problem.getFluents().get(i), step + 1);
                try {
                    solver.addClause(new VecInt(a));
                } catch (ContradictionException ignored) {
                }
            }
            if (negative.get(i)) {
                a[1] = -1 * getID(problem.getFluents().get(i), step + 1);
                try {
                    solver.addClause(new VecInt(a));
                } catch (ContradictionException ignored) {
                }
            }

        }
    }

    private void convertActionDisjunction(int step) {
        int nb_actions = problem.getActions().size();
        for(int i = 0; i < nb_actions; i++) {
            for(int j = i + 1; j < nb_actions; j++) {
                try {
                    int[] a = new int[2];
                    a[0] = -getID(problem.getActions().get(i), step);
                    a[1] = -getID(problem.getActions().get(j), step);
                    solver.addClause(new VecInt(a));
                } catch (ContradictionException ignored) {
                }
            }
        }
    }

    private void convertStateTransitions(int step) {
        for (final Fluent fluent : this.fluentsEffects.keySet()) {
            Action[] actions = fluentsEffects.get(fluent);
            int fi = getID(fluent, step);
            int fi1 = getID(fluent, step + 1);

            try {
                int[] positiveClause = new int[actions.length + 2];
                positiveClause[0] = fi;
                positiveClause[1] = -fi1;
                for (int j = 2; j < positiveClause.length; j++) {
                    positiveClause[j] = getID(actions[j - 2], step);
                }
                solver.addClause(new VecInt(positiveClause));
            } catch (ContradictionException ignored) {
            }

            try {
                int[] negativeClause = new int[actions.length + 2];
                negativeClause[0] = -fi;
                negativeClause[1] = fi1;
                for (int j = 2; j < negativeClause.length; j++) {
                    negativeClause[j] = getID(actions[j - 2], step);
                }
                solver.addClause(new VecInt(negativeClause));
            } catch (ContradictionException ignored) {
            }
        }
    }

    private void addClause(int[] clause) {
        try {
            solver.addClause(new VecInt(clause));
        } catch (ContradictionException ignored) {
        }
    }

    private String actionToString(Action a, int step) {
        List<String> symbols = problem.getConstantSymbols();
        StringBuilder builder = new StringBuilder();

        builder.append(a.getName().toUpperCase()).append("(");
        for (int i = 0; i < a.getInstantiations().length; i++) {
            builder.append(symbols.get(a.getInstantiations()[i]));
            if (i + 1 < a.getInstantiations().length) {
                builder.append(", ");
            }
        }
        builder.append(", ").append(step).append(")");
        return builder.toString();
    }

    public static void main(String[] args) {
        // Checks the number of arguments from the command line
        if (args.length < 2) {
            System.out.println("Invalid command line");
            return;
        }

        try {
            // Creates an instance of the PDDL parser
            final Parser parser = new Parser();
            parser.setLogLevel(LogLevel.OFF);
            // Parses the domain and the problem files.
            final DefaultParsedProblem parsedProblem = parser.parse(args[0], args[1]);
            // Gets the error manager of the parser
            final ErrorManager errorManager = parser.getErrorManager();
            // Checks if the error manager contains errors
            if (!errorManager.isEmpty()) {
                // Prints the errors
                for (Message m : errorManager.getMessages()) {
                    System.out.println(m.toString());
                }
            } else {
                // Prints that the domain and the problem were successfully parsed
                System.out.print("\nparsing domain file \"" + args[0] + "\" done successfully");
                System.out.print("\nparsing problem file \"" + args[1] + "\" done successfully\n\n");
                // Create a problem
                final Problem problem = new DefaultProblem(parsedProblem);
                // Instantiate the planning problem
                problem.instantiate();

                ASP planner = new ASP();
                planner.setLogLevel(LogLevel.OFF);
                Plan plan = planner.solve(problem);

                SATEncoding encoding = new SATEncoding(problem, plan.actions().size());
                System.out.println(encoding.getPlan());
            }
            // This exception could happen if the domain or the problem does not exist
        } catch (FileNotFoundException ignored) {
        }
    }
}
