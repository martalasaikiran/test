public with sharing class demobranchclass {
    public static void demomethod(){
        Integer x;
        List<Account> acc =[Select Name ,Industry,AnnualRevenue from Account ];
        List<Contact> con = [Select FirstName From Contact];
        
    }
}