public class InvoinTrigger {
    public static void check(List<Invoice__c> lst){
      //  List<Invoice__c> lst1=new List<Invoice__c>();
        for( Invoice__c incRecord:lst){
            system.debug('New Record DueDate---->>>'+incRecord.Due_Date__c);
            system.debug('New Record Name----->>>>'+incRecord.Name);
            if(incRecord.Due_Date__c < System.Today() && incRecord.Name != 'Paid'){
                System.debug(' when date is less than today status not equals to Paid');
                incRecord.IsOverdue__c = true;
            }
            else {
                incRecord.IsOverdue__c=false;
            }
        }
    }

}