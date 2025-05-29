public class AccountTask2 {
    public static void separationRecordsManagerNotNullValues(List<Account> accRecords) {
           System.debug('Trigger is intiates ');
        Set<Id> accIds = new Set<Id>();
        for (Account acc : accRecords) {
            accIds.add(acc.Id);
        }
        System.debug('account ids are collected ');

        List<Messaging.SingleEmailMessage> emailsToSendNotNullSalesManager = new List<Messaging.SingleEmailMessage>();

       //for SalesManager Not null records 
        List<Opportunity> salesManagerNotNullRecords = [
            SELECT Id, Name, Amount, StageName, SalesManager__c, CreatedBy.Email
            FROM Opportunity
            WHERE AccountId IN :accIds
                AND Amount > 100000
                AND StageName = 'Negotiation/Review'
                AND SalesManager__c != null
        ];
        System.debug('SalesManager field not null query is executed');
        //System.debug('SalesManager field not null query is executed																																	');
        //sending email to that oppurtunity owner
        //
        if(!salesManagerNotNullRecords.isEmpty()){
        for (Opportunity opp : salesManagerNotNullRecords) {
            if (opp.CreatedBy.Email != null) {
                System.debug('Preparing Email for: ' + opp.CreatedBy.Email);

                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new String[] { opp.CreatedBy.Email });
                email.setReplyTo('martalasaikiranreddy1119@gmail.com');
                email.setSubject('Please Review the Quotation');
                email.setPlainTextBody(
                    'Hi,\n\n' +
                    'Please review the quotation given by our sales team for the opportunity "' + opp.Name + '".\n' +
                    'We’re expecting to hear from you soon.\n\n' +
                    'Regards,\nSales Team'
                );

                emailsToSendNotNullSalesManager.add(email);
            }
        }
            if (!emailsToSendNotNullSalesManager.isEmpty()) {
            Messaging.sendEmail(emailsToSendNotNullSalesManager);
           
        }
            System.debug('Email  is Sended ');
        }
         

                
        separationRecordsManagerNullValues(accRecords);
        
        
    }   
        
    public static void separationRecordsManagerNullValues(List<Account> accRecords) {

        Set<Id> accIds = new Set<Id>();
        for (Account acc : accRecords) {
            accIds.add(acc.Id);
        }   
        
        
         List<Messaging.SingleEmailMessage> emailsToSendSalesManagerNullValues = new List<Messaging.SingleEmailMessage>();
        //(Select CreatedBy.Email from Account)
        List<Opportunity> salesManagerNullRecords = [
            SELECT 	AccountId, Name, Amount, StageName, SalesManager__c, Account.CreatedBy.Email, CreatedById
            FROM Opportunity
            WHERE AccountId IN :accIds
                AND Amount > 100000
                AND StageName = 'Negotiation/Review'
                AND SalesManager__c = null
        ];
        //log object bulkification
        List<Log__c> logsToInsert = new List<Log__c>();

       for (Opportunity oppRecord : salesManagerNullRecords) {
           
                  Log__c log = new Log__c();
                 log.AccountId__c     = oppRecord.AccountId;
                 log.OpportunityId__c = oppRecord.Id;  
               log.User__c = oppRecord.CreatedById; 

              logsToInsert.add(log);
            if (oppRecord.Account.CreatedBy.Email != null) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] { oppRecord.Account.CreatedBy.Email });
            email.setSubject('Action Required: Please Review Quotation');
            email.setPlainTextBody(
                'Dear Account Holder,\n\n' +
                'Please review the quotation given by our sales team ');
            emailsToSendSalesManagerNullValues.add(email);
        }

           
           }  
  
// Bulk insert the logs
 if (!logsToInsert.isEmpty()) {
    insert logsToInsert;
     System.debug('log Record is Created ');
 }

    // Send all emails in one go
    if (!emailsToSendSalesManagerNullValues.isEmpty()) {
        Messaging.sendEmail(emailsToSendSalesManagerNullValues);
        System.debug('Email is sended ');
    }
}
     

       
        
    }