public with sharing class HHVM {
    
 
    private String unusedVariable;

    public static final Id HARDCODED_ID = '001xx000003DGb1AAG';

    public static void doSomething() {
        try {
            Integer x = 10 / 0; 
        } catch (Exception e) {
           
        }
    }

    public HHVM() {
        System.debug('HHMV COnstructor ');
        System.debug('HHVM  constructoooorr Invokedinvoked');
    }
}
