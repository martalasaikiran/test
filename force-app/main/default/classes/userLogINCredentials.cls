public with sharing class userLogINCredentials {
    @AuraEnabled(cacheable=false)
    //when the user login son i need to updat logintime and status is login 
    public static void userLoginCredentialsUpdateRecord(String username, String email) {
        try {
                 //in my user object Lastname=username so by using it need to do update 
            LoginDetails__c loginRecord = [
                SELECT Id, UserLastName__c, UserEmai__c 
                FROM LoginDetails__c 
                WHERE UserEmai__c = :email AND UserLastName__c = :username 
                LIMIT 1
            ];

            if (loginRecord != null) {
                loginRecord.LoginTime__c = System.now();
                loginRecord.Status__c = 'Login';
                update loginRecord;
            }
        } catch(Exception e) {
            System.debug('Updating error: ' + e.getMessage() + ' at line number ' + e.getLineNumber());
        }
    }
    @AuraEnabled(cacheable=false)
    // when the user logout the i can  update the logout time and status is log out  and it is call from the child component accountdatatable 
    public static void userLoginCredentialsUpdateRecordLogOut(String username, String email) {
        try {
                 //in my user object Lastname=username so by using it need to do update 
            LoginDetails__c loginRecord = [
                SELECT Id, UserLastName__c, UserEmai__c 
                FROM LoginDetails__c 
                WHERE UserEmai__c = :email AND UserLastName__c = :username 
                LIMIT 1
            ];

            if (loginRecord != null) {
                loginRecord.LogoutTIme__c = System.now();
                loginRecord.Status__c = 'Logout';
                update loginRecord;
            }
        } catch(Exception e) {
            System.debug('Updating error: ' + e.getMessage() + ' at line number ' + e.getLineNumber());
        }
    }
}