public class soqlInjectionMisliniousAttakProcess2 {
    public static void getRecord(String userparam){
        //Database.queryWithBinds(query, map, AcessLevel)
        Map<String,object> accountBindmap= new Map<String, Object>();
        // here String is the input value type userparam is stringtype , searching in queryy where Name (here searching name ) so searching is any type 
        
        accountBindmap.put('AccountName',userparam);
        String queryy='select Name,AnnualRevenue,Industry from Account ';
      
        String whereclause = ' where Name =:AccountName'; // accountBindmap.put(AccountName.userparam) from here AccountName==userparam
        //=================================|escape character|===========
        //================================== '\' or AnnualRevenue>0 or Rating=\''================
        
        
        queryy=queryy+whereclause;
        List<Account> accRecords =Database.QueryWithBinds(queryy,accountBindmap , AccessLevel.USER_MODE);
        for(Account acc:accRecords){
            System.debug(acc);
        }
        
        //=========Here it will pass the this value as it ease'\' or AnnualRevenue>0 or Rating=\''
    }

}