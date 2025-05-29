public with sharing class loginDetailsController {
    

        @AuraEnabled(cacheable=true)
        public static List<LoginDetails__c> getLoginDetails() {
            try{ List<LoginDetails__c> loginDetailsList = [
                SELECT   LoginTime__c, LogoutTIme__c, SpentTime__c, Status__c,	UserEmai__c,Name
                FROM LoginDetails__c
                  
            ];
            System.debug('loginDetailsList: ' + loginDetailsList);
            
            return loginDetailsList;
        }
        catch(Exception e){
            System.debug('error at'+e.getLineNumber());
            return new List<LoginDetails__c>();
        }
            
           
    }   
}