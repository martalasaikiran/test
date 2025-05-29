public class contactsqueable implements Queueable{
    List<Account> accountswithcontacts= new List<Account>();
   public contactsqueable(List<Account> accountsinputs){
        System.debug('accounts related contacts records input from contacsqueableConstructor'+accountsinputs); 
       for(Account acc:accountsinputs){
           this.accountswithcontacts.add(acc);
       }
    }
    
              
    public void execute(QueueableContext context) { 
     // I want to Count how many contacts for each account  
     
        try {
             System.debug('acccountsrelated contacts regarded list in contactsqueable globalLIST '+ this.accountswithcontacts);
            List<Account> accountcontacts= new List<Account>();
            for(Account accRecord:this.accountswithcontacts){
                Integer count =accRecord.Contacts.Size();
                if(count>0){
                    accountcontacts.add(accRecord);
                }
            }
        System.debug('accounts which has one or moreContacts : '+accountcontacts);
           
           
            Map<Id, Decimal> accountContactCount = new Map<Id,Decimal>();
          
           
            for (Account acc : accountcontacts) {
                if (acc.Contacts != null) {
                    accountContactCount.put(acc.Id, acc.Contacts.size()*1.5);
                } 
            }
            

            
            System.debug('Contact Count Per Account: ' + accountContactCount);

            // need to send my accounts and accountContactCount to the opportunity queable 
                 System.enqueueJob(new opportunityqueable(accountswithcontacts,accountContactCount));
        
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage() + ' at line: ' + e.getLineNumber());
        }
        
          
        

        
        
        
        
        
    
    }
}