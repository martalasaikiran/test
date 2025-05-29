public with sharing class logindobju {
    @AuraEnabled(cacheable=false)
    public static void voidlogindobjuRecord(String username, String useremail) {
        try {
            System.debug('username is in logindobju' + username);
            System.debug('useremail is ' + useremail);

            
            LoginDetails__c logRecord = [SELECT Name, LoginTime__c ,	Status__c
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
    }