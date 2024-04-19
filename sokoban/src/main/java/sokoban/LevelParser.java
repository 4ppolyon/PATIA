package sokoban;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;   

import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class LevelParser {

    private final String GAUCHE = "L";
    private final String DROITE = "R";
    private final String HAUT = "U";
    private final String BAS = "D";
    private final String resultFilePath;
    private final int nbRows;
    private final int nbCols;
    private final CASE_TYPE[][] cases;
    private final int nbButsCaisses;
    public LevelParser(String problemPath, String filePath) throws Exception {
        this.resultFilePath = filePath;

        // Ouverture du fichier JSON du niveau
        JSONObject json = (JSONObject) new JSONParser().parse(new FileReader(problemPath));
        // Récupération de la chaîne de caractères décrivant le niveau
        String level = (String) json.get("testIn");

        // Calcul du nombre de lignes et de colonnes du niveau
        {
            int nbRows = 0;
            int nbCols = 0;
            int cols = 0;
            for (char c : level.toCharArray()) {
                if (c == '\n') {
                    if (cols > nbCols) {
                        nbCols = cols;
                    }
                    nbRows++;
                    cols = 0;
                } else {
                    cols++;
                }
            }
            if (cols > nbCols) {
                nbCols = cols;
            }

            nbRows++;

            this.nbRows = nbRows;
            this.nbCols = nbCols;
        }

        // Par défaut toutes les cases du niveau sont des murs
        this.cases = new CASE_TYPE[nbRows][nbCols];
        for (int r = 0; r < nbRows; r++) {
            for (int c = 0; c < nbCols; c++) {
                this.cases[r][c] = CASE_TYPE.SOL;
            }
        }

        // Définition du type de chaque case du niveau
        // Calcul du nombre de caisses/buts dans le niveau
        int nbButsCaisses = 0;
        int row = 0;
        int col = 0;
        for (char c : level.toCharArray()) {
            System.out.print(c);
            switch (c) {
                case ' ':
                    this.cases[row][col] = CASE_TYPE.SOL;
                    break;
                case '@':
                    this.cases[row][col] = CASE_TYPE.AGENT;
                    break;
                case '$':
                    this.cases[row][col] = CASE_TYPE.CAISSE;
                    nbButsCaisses++;
                    break;
                case '.':
                    this.cases[row][col] = CASE_TYPE.BUT;
                    break;
                case '*':
                    this.cases[row][col] = CASE_TYPE.CAISSE_SUR_BUT;
                    nbButsCaisses++;
                    break;
                case '+':
                    this.cases[row][col] = CASE_TYPE.AGENT_SUR_BUT;
                    break;
                case '#':
                    this.cases[row][col] = CASE_TYPE.MUR;
                    break;
            }

            if (c == '\n') {
                System.out.println();
                row++;
                col = 0;
            } else {
                col++;
            }
        }
        System.out.println();
        this.nbButsCaisses = nbButsCaisses;
    }

    public static void main(String[] args) throws Exception {
        LevelParser parser = new LevelParser(args[0], args[1]);
        parser.writeFile();
        System.out.println(parser);
    }

    public void writeFile() throws Exception {
        FileWriter fileWriter = new FileWriter(this.resultFilePath);

        fileWriter.write("(define (problem p01) (:domain Sokoban)\n");

        writeObjects(fileWriter);
        writeInitState(fileWriter);
        writeGoalState(fileWriter);

        fileWriter.write(")");
        fileWriter.close();
    }

    private String caseID(int row, int col) {
        return "c" + row + col;
    }

    private String butID(int num) {
        return "but" + num;
    }

    private String caisseID(int num) {
        return "caisse" + num;
    }

    private void writeObjects(FileWriter fileWriter) throws IOException {
        fileWriter.write("(:objects\n");

        // Directions
        fileWriter.write("\t" + HAUT + " " + BAS + " " + GAUCHE + " " + DROITE + " - direction\n\t");

        // Cases
        for (int r = 0; r < nbRows; r++) {
            for (int c = 0; c < nbCols; c++) {
                if (cases[r][c] != CASE_TYPE.MUR) {
                    fileWriter.write(caseID(r, c) + " ");
                }
            }
        }
        fileWriter.write("- case\n");

        // Agent
        fileWriter.write("\ta - agent\n");

        fileWriter.write("\t");

        // Caisses
        for (int i = 0; i < nbButsCaisses; i++) {
            fileWriter.write(caisseID(i + 1) + " ");
        }
        fileWriter.write("- caisse\n");

        fileWriter.write("\t");

        // Buts
        for (int i = 0; i < nbButsCaisses; i++) {
            fileWriter.write(butID(i + 1) + " ");
        }
        fileWriter.write("- but\n");

        fileWriter.write(")\n");
    }

    private void writeInitState(FileWriter fileWriter) throws IOException {
        fileWriter.write("(:init\n");

        // Emplacement des buts et emplacement initial des caisses et de l'agent
        int nbCaisses = this.nbButsCaisses;
        int nbButs = this.nbButsCaisses;

        for (int r = 0; r < nbRows; r++) {
            for (int c = 0; c < nbCols; c++) {
                switch (cases[r][c]) {
                    case AGENT_SUR_BUT:
                        if (nbButs > 0) {
                            fileWriter.write("\t(butSurCase " + butID(nbButs) + " " + caseID(r, c) + ")\n");
                            fileWriter.write("\t(butVide " + butID(nbButs) + ")\n");
                            nbButs--;
                        }
                    case AGENT:
                        fileWriter.write("\t(agentSur a " + caseID(r, c) + ")\n");
                        break;
                    case CAISSE:
                        if (nbCaisses > 0) {
                            fileWriter.write("\t(caisseSur " + caisseID(nbCaisses) + " " + caseID(r, c) + ")\n");
                            fileWriter.write("\t(caisseLibre " + caisseID(nbCaisses) + ")\n");
                            nbCaisses--;
                        }
                        break;
                    case CAISSE_SUR_BUT:
                        if (nbCaisses > 0) {
                            fileWriter.write("\t(caisseSur " + caisseID(nbCaisses) + " " + caseID(r, c) + ")\n");
                            fileWriter.write("\t(caisseSurBut " + caisseID(nbCaisses) + ")\n");
                            fileWriter.write("\t(butSurCase " + butID(nbButs) + " " + caseID(r, c) + ")\n");
                            nbCaisses--;
                            nbButs--;
                        }
                        break;
                    case BUT:
                        if (nbButs > 0) {
                            fileWriter.write("\t(butSurCase " + butID(nbButs) + " " + caseID(r, c) + ")\n");
                            fileWriter.write("\t(butVide " + butID(nbButs) + ")\n");
                            nbButs--;
                        }
                        break;
                }
            }
        }

        // Définition adjacence des cases
        for (int r = 0; r < nbRows; r++) {
            for (int c = 0; c < nbCols; c++) {
                if (cases[r][c] != CASE_TYPE.MUR) {
                    // Case au dessus
                    if (r > 0 && cases[r - 1][c] != CASE_TYPE.MUR) {
                        fileWriter.write("\t(adjacente " + caseID(r - 1, c) + " " + caseID(r, c) + " " + HAUT + ")\n");
                    }
                    // Case en dessous
                    if (r < nbRows - 1 && cases[r + 1][c] != CASE_TYPE.MUR) {
                        fileWriter.write("\t(adjacente " + caseID(r + 1, c) + " " + caseID(r, c) + " " + BAS + ")\n");
                    }
                    // Case à gauche
                    if (c > 0 && cases[r][c - 1] != CASE_TYPE.MUR) {
                        fileWriter.write("\t(adjacente " + caseID(r, c - 1) + " " + caseID(r, c) + " " + GAUCHE + ")\n");
                    }
                    // Case à droite
                    if (c < nbCols - 1 && cases[r][c + 1] != CASE_TYPE.MUR) {
                        fileWriter.write("\t(adjacente " + caseID(r, c + 1) + " " + caseID(r, c) + " " + DROITE + ")\n");
                    }
                }
            }
        }

        // Définition des cases vides
        for (int r = 0; r < nbRows; r++) {
            for (int c = 0; c < nbCols; c++) {
                switch (cases[r][c]) {
                    case BUT:
                    case SOL:
                        fileWriter.write("\t(empty " + caseID(r, c) + ")\n");
                        break;
                }
            }
        }


        fileWriter.write(")\n");
    }

    private void writeGoalState(FileWriter fileWriter) throws IOException {
        fileWriter.write("(:goal (and\n");

        for (int i = 1; i <= nbButsCaisses; i++) {
            fileWriter.write("\t(caisseSurBut caisse" + i + ")\n");
        }

        fileWriter.write("))\n");
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();

        for (int r = 0; r < nbRows; r++) {
            for (int c = 0; c < nbCols; c++) {
                builder.append(cases[r][c]).append("\t");
            }
            builder.append("\n");
        }

        return builder.toString();
    }

    private enum CASE_TYPE {
        SOL,
        MUR,
        AGENT,
        CAISSE,
        BUT,
        CAISSE_SUR_BUT,
        AGENT_SUR_BUT
    }
}
