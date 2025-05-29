public class batchtask  implements Database.Batchable<sObject>{
public  List< Sub__c>  start(Database.BatchableContext bcontext){
        System.debug(' batch task Start method initiated ');
         List<Sub__c> subRecords= [SELECT Status__c,Sales_Review__c,RenewedManually__c,
                                          OverUsage__c,	NextRenewal__c,	EndDate__c,	Discount__c,
                                         (SELECT Id,	UsageAmount__c,	UsageMonth__c FROM Usage__r) from Sub__c
                                          where Status__c= 'Active' and 	EndDate__c <= :System.Today().addDays(60)];
             System.debug('start method returning the records  :');
        return subRecords ;
   
    }
 public void execute(Database.BatchableContext bcontext,List<Sub__c> batchRecords){
         
        
         
         
         
             System.debug('batch records are '+batchRecords);
        List<Sub__c> subupdates= new List<Sub__c>();
         
         
         
         Set<Id> sIds = new Set<Id>();
        for (Sub__c sub :batchRecords){
            sIds.add(sub.Id);
        }
        Map<Id, CustomerStatisfaction__c> subsaving = new Map<Id, CustomerStatisfaction__c>();
    	for (CustomerStatisfaction__c csrecord : [SELECT Id, Subscription__c, CustomerStatisfactionScore__c FROM CustomerStatisfaction__c WHERE Subscription__c IN :sIds]) {
        	subsaving.put(csrecord.Subscription__c, csrecord);
    	}         
  
         
        for(Sub__c sub :batchRecords){
           
            Decimal total = 0;// totalling the each usage ammount
            Integer count = 0;
            Decimal avg = 0;
            Decimal purchasedLimit = 100;
           
            for(Usage__c usage : sub.Usage__r){
                System.debug('Usage Record is '+ usage);
                
                if (usage.UsageMonth__c != null && usage.UsageMonth__c >= Date.today().addMonths(-6)) {
                   
                    total+= usage.UsageAmount__c;
                    count++;
                }
            }
            //finding average 
            if (count > 0) { 
                
                avg = total / count;
                System.debug('avg is '+ avg);
            }
             Boolean overUsage = (avg > 1.2 * purchasedLimit);
          
            if(overUsage){
                sub.OverUsage__c='True';
               CustomerStatisfaction__c relcus = subsaving.get(sub.Id);
                System.debug('customerrecord'+relcus);
              
            	if (relcus.CustomerStatisfactionScore__c >= 95) {
                    System.debug('Updating the discount');
                	sub.Discount__c = sub.Discount__c + 5;
                    System.debug('Discount is updated ');
            	}    
            }
            System.debug('for renewead manually ');
            if(sub.RenewedManually__c=='Yes'){
                sub.Sales_Review__c='true';
                System.debug('salesreview is updated ');
                
                
            }
            if (sub.EndDate__c != null) {
                    sub.NextRenewal__c = sub.EndDate__c.addMonths(12);
                }
            System.debug('upadtedrecords'+sub);
             subupdates.add(sub);
        }
        
        if (!subupdates.isEmpty()) {
            update subupdates;
        }

           
            
            
            
        
     
        
     
        
}  
        
      
 
            
        
    
public void finish(Database.BatchableContext bcontext){
         system.debug('Finish Method ie executed ');
         
          List<Sub__c> subsToEmail = [
        SELECT Id,Sales_Review__c,Name
        FROM Sub__c
        WHERE Sales_Review__c =: 'true' ];

    List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

    for (Sub__c sub : subsToEmail) {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        email.setToAddresses(new String[] { 'martalasaikiranreddy1119@gmail.com' });
        email.setSubject('Sales Review ' + sub.Name);
        email.setPlainTextBody('salesreview ');

        emails.add(email);
    }

    if (!emails.isEmpty()) {
        Messaging.sendEmail(emails);
    }
     
    
    AsyncApexJob jobDetails = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
      TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:bcontext.getJobId()];
        System.debug(jobDetails);
        try{
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
              String[] toAddresses = new String[] {jobDetails.CreatedBy.Email,'martalasaikiranreddy1119@gmail.com'};
            mail.setToAddresses(toAddresses);
            mail.setSubject('Apex Sharing Recalculation ' + jobDetails.Status);
            mail.setPlainTextBody
   ('The batch Apex job processed ' + jobDetails.TotalJobItems +
   ' batches with '+ jobDetails.NumberOfErrors + ' failures.');
          Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
   
        }
        catch(Exception e){
            System.debug('error in Batchapex1'+ e.getMessage()+e.getlineNumber());   
            
        }
   }

}