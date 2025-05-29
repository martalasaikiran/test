public class pratice {
    public static void getrecord( String contactName){
        List<Contact> l1= new List<Contact>();
        l1 = [SELECT Id, AccountId, Account.Name FROM Contact WHERE Account.Name = :contactName];
        for(Contact cc:l1 ){
            if(cc.AccountId ==contactName){
                Account acc=[SELECT Id, AccountNumber, OwnerId FROM Account WHERE Id = :cc.AccountId];
                System.debug(acc);
          /*      List<Contact> 
        // Iterate through the contact list to find matching account name
        for(Contact cc : l1){
            if(cc.AccountId == AccountName){
                // Fetch the Account details based on the AccountName
                Account acc = [SELECT Name, AccountNumber, OwnerId FROM Account WHERE Name = :AccountName LIMIT 1];**/
                System.debug(acc);
            }
        }
        
    }
}