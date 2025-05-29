global class queable2 implements Queueable {
      
    List<Account> acrecord=new List<Account>();
    public queable2(List<Account> acc){
        if(!acc.isEmpty()){
            for(Account ac1:acc){
            acrecord.add(ac1);
          }
        }
        
    }
         
    public void execute(QueueableContext context) {
        List<Account> updatelist=new List<Account>();  
        for(Account accupdate:acrecord){
            accupdate.SLA__c='Gold';
            updatelist.add(accupdate);
        }
        update updatelist;
    }    
}