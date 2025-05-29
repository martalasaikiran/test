public with sharing class LoginStatusController {
    @AuraEnabled(cacheable=false)
    public static Integer getActiveUserCount() {
        // Count users with Status__c = 'Logged In'
        return [SELECT COUNT() FROM LoginDetails__c WHERE Status__c = 'Login'];
    }
}