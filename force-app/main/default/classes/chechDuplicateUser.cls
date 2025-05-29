public class chechDuplicateUser {
     @AuraEnabled(cacheable=false)
    public static Boolean checkduplicate(String username){
        try{
            List<Credential__c> ccRecord=[select  	UserName__c  from Credential__c where  useremail__c =:username ];
            return (ccRecord.size()>0);
        }
        catch(Exception e ){
            System.debug('error occurs at ' +e.getLineNumber());
            return null;
        }
    }

}