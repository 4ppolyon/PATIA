package sokoban;

import java.io.*;
import java.util.Scanner;
import java.util.regex.Pattern;

public class Agent {
    public static void main(String[] args) throws Exception {
        final String FILE_PATH = "plans/plan" + SokobanMain.getLevel() + ".txt";
        File file = new File(FILE_PATH);
        Scanner plan = new Scanner(file);
        while (plan.hasNextLine()) {
            String line = plan.nextLine();
            System.out.println(line.charAt(0));
        }
    }
}
