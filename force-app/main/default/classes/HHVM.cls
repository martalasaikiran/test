public with sharing class HHVM {
    private String unusedField; // Unused variable violation

    public static final Id HARDCODED_ID = '001xx000003DGb1AAG'; // Hardcoded ID violation

    public HHVM() {
        System.debug('Debugging'); // Excessive debug violation
    }

    public static void doSomething() {
        try {
            Integer x = 10 / 0;
        } catch (Exception e) {
            // Empty catch block violation
        }
    }
}