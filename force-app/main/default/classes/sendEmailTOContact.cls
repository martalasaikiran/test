public with sharing class sendEmailTOContact {
    public static void getconrecords(){
        //List<Case>=[SELECT ContactId FROM Case WHERE Status IN ('New','Working'ss) AND ContactId != null GROUP BY ContactId HAVING COUNT(Id) > 3];
List<Contact> conRecords  = [ SELECT  Email,(SELECT Id FROM Cases WHERE Status IN ('New', 'Working')  AND CreatedDate <= :System.today().addDays(-3)) FROM Contact WHERE Email != null with SECURITY_ENFORCED ];
        // System.debug('The contacts which has 3 casses :'+conRecords);

        List<Messaging.SingleEmailMessage> emailsToSend = new List<Messaging.SingleEmailMessage>();
             
        for (Contact con : conRecords) {
            List<Case> openCases = con.Cases;
 
            if (openCases != null && openCases.size() > 3) {
                
                System.debug('Start Email');
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new String[] { con.Email });
                email.SetReplyTo('martalasaikiranreddy1119@gmail.com');
                //email.setBCCAdresses('sai@gmail.com');
                email.setSubject('About Your Cases');
                email.setPlainTextBody('You have more than 3 open cases');
                emailsToSend.add(email);
                System.debug('Sending Email');
            }
        }
 
        if (!emailsToSend.isEmpty()) {
            Messaging.sendEmail(emailsToSend);
        }
        
        
    }
}