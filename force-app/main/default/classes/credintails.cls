public with sharing class credintails {

    @AuraEnabled(cacheable=false)
    public static Boolean validateLoginDetails(String username, String password) {
        // Debugging the username and password
        System.debug('Username: ' + username);
        System.debug('Password: ' + password);
        try{
            List<Credential__c> credentials = [
                SELECT Id 
                FROM Credential__c 
                WHERE UserName__c = :username 
                AND Passwords__c = :password 
                LIMIT 1
            ];
    
            
            return credentials.size() > 0;

        }
        catch (Exception e) {
           
            System.debug('Error occurred: ' + e.getMessage()+'at line number '+e.getLinenumber());
            return null; 
        }

        // Query to check if the username and password exist in the Credential__c object
       
    }

    @AuraEnabled(cacheable=true)
    public static String userEmail(String username, String password) {
        try {
            // Query to get the email associated with the given username and password
            List<Credential__c> credentials = [
                SELECT useremail__c
                FROM Credential__c
                WHERE UserName__c = :username 
                AND Passwords__c = :password 
                LIMIT 1
            ];

           
            if (!credentials.isEmpty()) {
                System.debug('User email: ' + credentials[0].useremail__c);
                return credentials[0].useremail__c;
               
            } else {
                
                return null;
            }
        } catch (Exception e) {
           
            System.debug('Error occurred: ' + e.getMessage()+'at line number '+e.getLinenumber());
            return null; 
        }
    }
}