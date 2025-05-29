Global class batchapex2 implements Database.Batchable<sObject>  {
    //Aim to update the 4,00,000 Records 
   //3 methods are important start(), execute(), Finish()
    Global  Database.QueryLocator  start(Database.BatchableContext bcontext){
        System.debug('Start method initiated ');
        String query ='select Name , Industry, AnnualRevenue from Account ';
        return Database.getqueryLocator(query );
        //Database.Query Locator make the records into batches 
        //Execute method will process the batches per Batch how many records 
        //default:200 //min:1 //max:2000
        
        
    }
    Global void execute(Database.BatchableContext bcontext,List<sObject> batchRecords){
                System.debug('Start method initiated ');
        if(!batchRecords.isEmpty()){
            List<Account> bulkAccountRecords = new List<Account>();
            for(sObject sObjectRecords:batchRecords ){
                Account accRecord = (Account)sObjectRecords;
                accRecord.Industry='Biotechnology';
                bulkAccountRecords.add(accRecord);
                
            }
          Database.Update(bulkAccountRecords);  
        }
    }
    Global void finish(Database.BatchableContext bcontext){
          
    
        // now i want to send email to every account 
        // 
        System.debug('Final Method is executed ');
        System.debug('Batch is is ' + bcontext.getJobId());
        AsyncApexJob jobDetails = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
      TotalJobItems, CreatedBy.Email
      FROM AsyncApexJob WHERE Id =:bcontext.getJobId()];
        System.debug(jobDetails);
         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
              String[] toAddresses = new String[] {jobDetails.CreatedBy.Email,'martalasaikiranreddy1119@gmail.com'};
            mail.setToAddresses(toAddresses);
            mail.setSubject('Apex Sharing Recalculation ' + jobDetails.Status);
            mail.setPlainTextBody
   ('The batch Apex job processed ' + jobDetails.TotalJobItems +
   ' batches with '+ jobDetails.NumberOfErrors + ' failures.');
          Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
   
    
    }
}