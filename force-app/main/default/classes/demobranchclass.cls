public with sharing class demobranchclass {
    public static void demomethod(){
        //method invoked
        Integer x;
        List<Account> acc =[Select Name ,Industry,AnnualRevenue from Account ];
        List<Contact> con = [Select FirstName From Contact];
        for(Integer i=0; i<200; i++){
           Account acc = new Account();
           acc.Name='saiki';
           insert acc;
        }
        
    }
}