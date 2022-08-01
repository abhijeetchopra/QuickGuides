import java.util.Scanner;

public class Animal {

    // variables
    private String name;
    private int age;
    private float height;
    private int weight;
    private int legs;
    private boolean hasOwner = false;

    protected static int numberOfAnimals = 0;

    static Scanner userInput = new Scanner(System.in);

    // getter and setter functions
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public float getHeight() {
        return height;
    }

    public void setHeight(float height) {
        this.height = height;
    }

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }

    public int getLegs() {
        return legs;
    }

    public void setLegs(int legs) {
        this.legs = legs;
    }

    public boolean getHasOwner() {
        return hasOwner;
    }

    public void setHasOwner(boolean hasOwner) {
        this.hasOwner = hasOwner;
    }

    public int getNumberOfAnimals() {
        return numberOfAnimals;
    }

    // constructor function
    public Animal() {

        System.out.print("Enter Name: ");
        if(userInput.hasNextLine()) {
            this.setName(userInput.nextLine());
        }

        System.out.print("Enter Age: ");
        if(userInput.hasNextInt()) {
            this.setAge(userInput.nextInt());
        }

        System.out.print("Enter Height: ");
        if(userInput.hasNextFloat()) {
            this.setHeight(userInput.nextFloat());
        }

        System.out.print("Enter Weight: ");
        if(userInput.hasNextInt()) {
            this.setWeight(userInput.nextInt());
        }

        System.out.print("Enter Legs: ");
        if(userInput.hasNextInt()) {
            this.setLegs(userInput.nextInt());
        }

        numberOfAnimals++;
    }

    // function to print object
    public void printObject() {
        System.out.println(" ");
        System.out.println("Printing object details:");
        System.out.println("Name   : " + this.getName() );
        System.out.println("Age    : " + this.getAge() );
        System.out.println("Height : " + this.getHeight() );
        System.out.println("Weight : " + this.getWeight() );
        System.out.println("Legs   : " + this.getLegs() );
        System.out.println("Owner  : " + this.getHasOwner() );
        System.out.println("Total  : " + this.getNumberOfAnimals() );

    }

    // main function
    public static void main(String[] args) {

        // create an instance of class
        Animal theAnimal = new Animal();

        // call class function
        theAnimal.printObject();
    }

}
