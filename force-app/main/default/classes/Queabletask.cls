public class Queabletask  implements Queueable{
    //in this queable class i need to  send the acccounts records which has related contacts 
    List<Account> acctransfer=new List<Account>();
    public void execute(QueueableContext context) {
        try{
            List<Account> acclist=[SELECT Id, Name, AccountEmail__c, SalesHealthScore__c,(SELECT Id, Name, Email FROM Contacts), (select Name, OpportunityActivity__c from Opportunities where OpportunityActivity__c=:'open' or OpportunityActivity__c=:'close' ) FROM Account];
            for(Account accRecord:acclist){
                
                     
                    acctransfer.add(accRecord);    
                
            }
            System.debug('accounts sending from queable task to contactQueable' +acclist);
        }
        catch(Exception e){
            System.debug('Error is '+ e.getMessage()+'at'+e.getlineNumber());
        }
        // calling the contacts queable 
        System.enqueueJob(new contactsqueable(acctransfer));
                
    }
}