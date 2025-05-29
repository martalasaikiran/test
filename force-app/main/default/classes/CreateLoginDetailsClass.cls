public class CreateLoginDetailsClass {
    public static void createLoginCreds(List<Credential__c> credRecords) {
        List<LoginDetails__c> loginRecordsToInsert = new List<LoginDetails__c>();

        for (Credential__c cred : credRecords) {
            LoginDetails__c loginRecord = new LoginDetails__c();
            loginRecord.Name = cred.UserName__c;
            loginRecord.UserEmai__c = cred.useremail__c; 
            loginRecordsToInsert.add(loginRecord);
        }

        try {
            if (!loginRecordsToInsert.isEmpty()) {
                insert loginRecordsToInsert;
                System.debug(loginRecordsToInsert);
            }
        } catch (Exception e) {
            System.debug('Error occurred: ' + e.getMessage() + ' at line number ' + e.getLineNumber());
        }
    }
    public static void updateLoginCreds(List<Credential__c> credRecords) {
        
       /*        
        
            
        
        try {
            if (!loginRecordsToUpdate.isEmpty()) {
                update loginRecordsToUpdate ;
                System.debug(loginRecordsToUpdate);
            }
        } catch (Exception e) {
            System.debug('Error occurred: ' + e.getMessage() + ' at line number ' + e.getLineNumber());
        }*/
    }
}