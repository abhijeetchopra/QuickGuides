import java.util.Scanner;

class Main {

    public static void main(String[] args) {

        System.out.print("Numbers 0-10:\n");

        for (int i = 0; i <= 10; i++) {
            String s = Integer.toString(i);
            System.out.println(s);
        }

        System.out.print("\nColors:\n");

        String[] colors = {"Red", "Blue", "Green"};

        for (String i: colors) {
            System.out.println(i);
        }

        System.out.print("\nNumbers 10-0:\n");
        int i = 10;
        while (i>=0) {
            String s = Integer.toString(i);
            System.out.println(i);
            i--;
        }

        // create a scanner object
        Scanner userInput = new Scanner(System.in);
        System.out.println("\nChoose a number from 0,1,2:\n");

        int e = userInput.nextInt();
        userInput.close();

        switch(e) {
            case 0:
                System.out.print("\nYou entered zero.\n");
                break;
            case 1:
                System.out.print("\nYou entered one.\n");
                break;
            case 2:
                System.out.print("\nYou entered two.\n");
                break;
            default:
                System.out.print("\nInvalid choice.\n");
        }

    }
}
