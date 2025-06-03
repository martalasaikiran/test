public with sharing class demobranchclass {
    public static void demomethod(){
        List<Account> acc =[Select Name ,Industry,AnnualRevenue from Account ];
        List<Contact> con = [Select FirstName From Contact];
        
    }
}