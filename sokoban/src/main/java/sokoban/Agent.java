package sokoban;

import java.io.*;
import java.util.Scanner;
import java.util.regex.Pattern;

public class Agent {

    public static void main(String[] args) throws Exception {
        Scanner config = new Scanner(new File("config.txt"));
        int level = Integer.parseInt(config.nextLine());
        config.close();


        final String FILE_PATH = "plans/plan" + level + ".txt";
        File file = new File(FILE_PATH);
        Scanner plan = new Scanner(file);
        while (plan.hasNextLine()) {
            String line = plan.nextLine();
            System.out.println(line.charAt(0));
        }
    }
}
