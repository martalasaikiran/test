public with sharing class contactController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        List<Contact> conlist = [select id, 	Phone,	FirstName , 	LastName,	Email ,PhotoUrl from Contact ];
       return conlist;
        
    }
}