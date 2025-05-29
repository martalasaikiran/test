public class AccountHelper5 {

    public static List<Contact> contactsToInsert = new List<Contact>();
    public String developerName = 'JuniorDev';

    public AccountHelper5() {
       System.debug('Constructor is initiated ');
       
    }

    public static void createRelatedContacts(List<Account> accounts) {
       
            List<Account> accList = [SELECT Id, Name FROM Account WHERE Name LIKE '%Test%']; 
        if(!accounts.isEmpty()){  

        AccountHelper5 helper = new AccountHelper5();
        for (Account acc : accounts) { 

            helper.createContact(acc); 

        }

        System.debug('Developer: ' + helper.developerName);
    }
    }

    public void createContact(Account acc) {
        Contact c = new Contact(FirstName = acc.Name, LastName = acc.Name, AccountId = acc.Id);
        contactsToInsert.add(c);
        insert contactsToInsert;
    }
 

  
    public static void throwError() {
    Integer a = 1;
    Integer b = 0;

    if (b != 0) {
        Integer result = a / b;
        System.debug('Result: ' + result);
    } else {
        System.debug('Cannot divide by zero.');
    }
}
}