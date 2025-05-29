global class quable1 implements Queueable{
   public void execute(QueueableContext context) {
       try{
          List<Account> acclist=[select Id,Name , 	SLA__c  from Account where 	Rating='Hot' ]; 
              System.enqueueJob(new queable2(acclist));
       }catch(Exception e){
           System.debug('Error is '+e.getMessage()+' at '+ e.getLineNumber());
       }
                   
    }
}