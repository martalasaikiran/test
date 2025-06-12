public with sharing class lightingDataTable {
    @AuraEnabled(cacheable=true)
    public static List<Account> getaccountDataTableRecords() {
        System.debug('getaccountTableRecords initiated');
        return [SELECT Id, Name, Industry, AnnualRevenue FROM Account];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsByAccountId( Id accountId ) {
        System.debug('getaccountTableRecords initiated');
        return [SELECT Id,FirstName,Email FROM Contact WHERE AccountId = :accountId];
    }
}