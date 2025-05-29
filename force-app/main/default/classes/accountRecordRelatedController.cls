public with sharing class accountRecordRelatedController {
    @AuraEnabled(cacheable=false)
    public static List<Opportunity> getOpportunities(Id accountId ) {
        System.debug(accountId);
        return [SELECT Id, Name, StageName, Amount FROM Opportunity WHERE AccountId = :accountId];
    }

    @AuraEnabled(cacheable=false)
    public static List<Contact> getContacts(Id accountId) {
        System.debug(accountId);
        return [SELECT Id, FirstName, Email, Phone FROM Contact WHERE AccountId = :accountId];
    }

    @AuraEnabled(cacheable=false)
    public static List<Case> getCases(Id accountId) {
        System.debug(accountId);
        return [SELECT Id, Reason, Subject, Status FROM Case WHERE AccountId = :accountId];
    }

    }