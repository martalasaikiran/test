public with sharing class accountDataTableRecords {
    @AuraEnabled(cacheable=true)
    public static List<Account> getaccountDataTableRecords() {
        return [SELECT Id, Name, Industry, AnnualRevenue FROM Account];
    }
}