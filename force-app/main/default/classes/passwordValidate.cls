public with sharing class passwordValidate {
    @AuraEnabled(cacheable=false)
    public static Boolean passwordValidateRecord( String useremail) {
            try{
                   System.debug(useremail);
                List<Credential__c> ccRecord =[select UserName__c from Credential__c where useremail__c =:useremail limit 1];
                
                     return ccRecord.size()>0;
                 
            }
            catch(Exception e){
            System.debug('Error occurred: ' + e.getMessage()+'at line number '+e.getLinenumber());
            return null;
            }
    }

    @AuraEnabled(cacheable=false)
    public static void changlepassword( String useremail,String newpassword) {
        try{
            System.debug('useremailis'+useremail);
            System.debug('newpasswoordis'+newpassword);
            Credential__c ccRecord =[select 	Passwords__c from Credential__c where useremail__c =:useremail limit 1];
            if (ccRecord!=null){
                System.debug('recordfound');
                ccRecord.Passwords__c = newpassword;
              
                update ccRecord;
                System.debug(ccRecord.Passwords__c);
            }
        }
        catch(Exception e){
            System.debug('Error occurred: ' + e.getMessage()+'at line number '+e.getLinenumber());
        }
   }      
}