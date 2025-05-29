public class opportunityclass {
    public static void getRecords(List<Opportunity> opprecords){
        System.debug('records from the trigger'+ opprecords);
        
       // Set<Id> sIds = new Set<Id>();
        
        
        
        List<HighValueOpportunityLog__c> listhvo= new List<HighValueOpportunityLog__c>();
        List<Account> accRecords=new List<Account>();
      //  List<>
        for(Opportunity opp:opprecords){
            if(opp.Amount >500000){
               // Account account = opp.AccountId;  
               // sIds.add(opp.AccountId);
                if(opp.AccountId!=null){
               Account acc = new Account(Id = opp.AccountId);
                acc.HighValueCustomer__c='True';
                accRecords.add(acc);
                HighValueOpportunityLog__c hvRecord= new HighValueOpportunityLog__c();
                hvRecord.OpportunityId__c= opp.Id ;
                hvRecord.Amount__c = opp.Amount;
                hvRecord.Account__c=opp.AccountId;
                hvRecord.TimeStamp__c=System.now();
                hvRecord.Name = opp.Name;
                
                listhvo.add(hvRecord);
                }
                       
                

                
            }
           
            
        }
          
        
       //updating the accounts  
        if(!listhvo.isEmpty()){
            insert(listhvo); 
            
            }
    //updating the accounts records HighValueCustomer__c field 
        if(!accRecords.isEmpty()){
            update(accRecords);    
            }
    }
}