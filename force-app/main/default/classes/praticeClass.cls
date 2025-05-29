public with sharing class praticeClass {
    @AuraEnabled(cacheable=true)
    public static List<Account> getRecords() {
        try{
                List<Account> accList = [select  Name ,Industry,Rating from Account ];
                System.debug('The Account from the apex class :------'+acclist);
                return accList;
        }
        Catch(Exception e ){
              System.debug('Error is ' + e.getMessage() +'at'+ e.getLineNumber());
              return new List<Account>();
        }

    }
}