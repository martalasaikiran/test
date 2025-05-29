public class opportunityqueable implements Queueable {
 // Map<Id,Decimal> Contactscount = new Map<Id,Decimal>();
  List<Account> accounts= new List<Account>();
  Map<Id,Decimal> acount= new Map<Id,Decimal>();
    public opportunityqueable(List<Account> acclist,Map<Id,Decimal> accountcontactcount){
        System.debug('accounts and related contacts counts in opportunity Queable Constructor '+acclist);
        //this.Contactscount.putAll(contactcount);
         for(Account acc:acclist){
           this.accounts.add(acc); 
       }
        this.acount.putAll(accountcontactcount);  
        
    }
         
         
    public void execute(QueueableContext context) { 
    // here i want to count the opportunities based on the getting id 
     System.debug('opportunityQueable account relatedcontact globalList'+ this.accounts);
        List<Account> acctopplist = new List<Account>();
        for(Account accRecord:this.accounts){
                Integer count =accRecord.Opportunities.Size();
                if(count>0){
                    acctopplist.add(accRecord);
                }
            }
        System.debug('accounts which has one or more opportunities : '+acctopplist);
    
        
        // account related opp count
        Map<Id, Decimal> accountOppCount = new Map<Id,Decimal>();
            List<Account> accUpdates= new List<Account>(); 
           
            for (Account acc : acctopplist) {
                if (acc.Opportunities != null) {
                    accountOppCount.put(acc.Id, acc.Opportunities.size()*2);
                } 
            }
        System.debug('Account related Opportunity count : ' +accountOppCount);
              System.enqueueJob(new queableAccountUpdate(this.acount,accountOppCount));
    }
    

}