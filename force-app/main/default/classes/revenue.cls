public with sharing class revenue {
    @AuraEnabled(cacheable=true)
    public static List<Account> Revenue() {
        // Query the top 5 accounts by Annual Revenue
        List<Account> revenueBucket = [SELECT Id, Name, AnnualRevenue FROM Account ORDER BY AnnualRevenue DESC LIMIT 5];
        
        return revenueBucket;  // Return the list of accounts
    }
}