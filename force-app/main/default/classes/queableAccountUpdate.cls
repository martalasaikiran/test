public class queableAccountUpdate implements Queueable{

    Map<Id,Decimal> accountContactCount= new Map<Id,Decimal>();
    Map<Id,Decimal> accountOpportunitycount= new Map<Id,Decimal>();
    public queableAccountUpdate( Map<Id,Decimal> acccon, Map<Id,Decimal> accopp){
        System.debug('accountrelated contactcount in QueableAccountUpdateConstructor'+acccon);
        System.debug('accountrelated Oppurtunities in QueableAccountUpdateConstructor'+accopp);
        this.accountContactCount.putAll(acccon); 
        this.accountOpportunitycount.putAll(accopp);
        
    }
    public void execute(QueueableContext context) {
       // for(Account ){
       System.debug('quableAccountUpdate global accountcontactcount'+this.accountContactCount);
        System.debug('quableAccountUpdate global accountopportunity'+this.accountOpportunitycount);
  
        List<Account> accToUpdate = new List<Account>();
        
        for(Id acc: this.accountContactCount.keySet()){
            for(Id acc1:this.accountOpportunitycount.keySet()){
                if(acc == acc1){
                  
                   // Account accRecord.Id=acc;
                   // acc.SalesHealthScore__c = get(acc) + get(acc1);
                  // SalesHealthScore1.add(Accounts.acc.SalesHealthScore__c=get(acc) + get(acc1));
                  Account accRecord = new Account(Id = acc);
                    accRecord.SalesHealthScore__c = this.accountContactCount.get(acc) + this.accountOpportunitycount.get(acc1);
                    accToUpdate.add(accRecord);
                   
                }
            }
            
           
        }
        //updating the account records 
         if(!accToUpdate.isEmpty()){
                update accToUpdate;
            }
        System.debug('calling email quable in the accounts update queable');
        System.enqueueJob(new emailqueable());

        
    }
}