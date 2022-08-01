import javax.sql.StatementEventListener;

class Main {

    static void myFunction() {
        System.out.println("myFunction called!");
    }

    public static void main(String[] args) {
        System.out.println("main function called!");
        myFunction();
    }
}
