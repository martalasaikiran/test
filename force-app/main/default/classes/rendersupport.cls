public with sharing  class rendersupport {
    
    @AuraEnabled(cacheable=true)
   
    public static List<Account>  rendersupportmethod() {
       


        try{
            List<Account> accRecords = [Select Name from  Account ];
            
             return accRecords;
            

        }
        catch( Exception e){
            return new List<Account>();

        }
    }
}