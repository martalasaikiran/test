public class AccountHelper {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountRecords(){
        List<Account> accList=[Select id, Name  from Account where AnnualRevenue !=null];
        system.debug('Account Helper Initiated ');
        return accList;
        
    }

}