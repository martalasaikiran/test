public class soqlInjectionMisliniousAttakProcess1 {
    public static void getRecord(String userparam){
        String queryy='select Name,AnnualRevenue,Industry from Account ';
        userparam=String.escapeSingleQuotes(userparam);// sanitizing the input it remove the staring sinle Queote 
        String whereclause = ' where Name= \'' +userparam+'\'';  
        //=================================|escape character|===========
        //================================== '\' or AnnualRevenue>0 or Rating=\''================
        //previous escape single queote Name= '' or AnnualRevenue>0 or Rating ='' so user get all records 
        //after sanitize Name =' ' user wont get any data 
        queryy=queryy+whereclause;
        List<Account> accRecords =Database.query(queryy);
        for(Account acc:accRecords){
            System.debug(acc);
        }
        
        
    }
}