public  class logInloginDetailsObjUpdate{
    @AuraEnabled(cacheable=false)
    public static void logintimeupdate(String username, String useremail) {
        try {
            System.debug('username is in logindetailclass ' + username);
            System.debug('useremail is ' + useremail);

            
            LoginDetails__c logRecord = [SELECT Name,Status__c, LoginTime__c 
                                         FROM LoginDetails__c 
                                         WHERE UserEmai__c = :useremail AND Name = :username 
                                         LIMIT 1];

            if (logRecord != null) {
                logRecord.LoginTime__c = System.now();
                logRecord.Status__c='Login';
                update logRecord;
                System.debug(logRecord);
            } else {
                System.debug('No matching record found.');
            }
        } catch (Exception e) {
            System.debug('Error occurred: ' + e.getMessage() + ' at line number ' + e.getLineNumber());
        }
    }
    @AuraEnabled(cacheable=false)
    public static void logoutimeupdate(String username, String useremail) {
        try {
            System.debug('username is in logindetailclass logoutimeupdatemethod ' + username);
            System.debug('useremail is  logindetailclass logoutimeupdatemethod' + useremail);

            
            LoginDetails__c logRecord = [SELECT Name, Status__c,LogoutTIme__c
                                         FROM LoginDetails__c 
                                         WHERE UserEmai__c = :useremail AND Name = :username 
                                         LIMIT 1];

            if (logRecord != null) {
                logRecord.LogoutTIme__c = System.now();
                logRecord.Status__c='Logout';
                update logRecord;
                System.debug(logRecord);
            } else {
                System.debug('No matching record found.');
            }
        } catch (Exception e) {
            System.debug('Error occurred: ' + e.getMessage() + ' at line number ' + e.getLineNumber());
        }
    }
}