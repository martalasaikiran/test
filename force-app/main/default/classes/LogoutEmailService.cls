public class LogoutEmailService {
     @AuraEnabled(cacheable=false)
    public static void sendLogoutEmail(String username, String useremail) {
        System.debug('username for logout email class '+username);
        System.debug('useremail for logout email class :'+useremail);
        
         try {
            
            Credential__c currentUser = [SELECT Useremail__c, Manager__c, UserName__c 
                                         FROM Credential__c 
                                         WHERE UserName__c = :username 
                                         AND Useremail__c = :useremail 
                                         LIMIT 1];
            
            
            if (currentUser.Manager__c != null) {
                
                Manager__c managerRecord = [SELECT ManagerEmail__c 
                                           FROM Manager__c 
                                           WHERE Id = :currentUser.Manager__c 
                                           LIMIT 1];
                
               
                LoginDetails__c loginDetails = [SELECT LoginTime__c  
                                                 FROM LoginDetails__c 
                                                 WHERE Name = :username 
                                                 AND UserEmai__c = :useremail
                                                 LIMIT 1];
                
                
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setSubject('Login Activity Report');
                email.setPlainTextBody('The ' + currentUser.UserName__c + ' Login Time is: ' + loginDetails.LoginTime__c+'logout time is :'+ loginDetails.LogoutTIme__c);
                email.setToAddresses(new String[] { currentUser.Useremail__c, managerRecord.ManagerEmail__c });
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
                System.debug('Email send to both user and manager  ');
            } else {
                
                LoginDetails__c loginDetails = [SELECT LoginTime__c ,LogoutTIme__c,SpentTime__c 
                                                 FROM LoginDetails__c 
                                                 WHERE Name = :username 
                                                 AND UserEmai__c = :useremail
                                                 LIMIT 1];
                
                
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setSubject('Login Activity Report');
                email.setPlainTextBody('The ' + currentUser.UserName__c + ' Login Time is: ' + loginDetails.LoginTime__c+'logout time is :'+ loginDetails.LogoutTIme__c   +'spent time is : '+loginDetails.SpentTime__c);   
                email.setToAddresses(new String[] { currentUser.Useremail__c });
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
                System.debug('Email send to only to the user ');
            }
        } catch(Exception e) {
            System.debug('Error at ' + e.getMessage() + ' at line number ' + e.getLineNumber());
        }
    }
}