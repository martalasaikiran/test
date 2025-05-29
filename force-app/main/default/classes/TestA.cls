public class TestA {
    public static void getAl(){
        List<Account> l1= [select Name,Rating,Phone from Account  order by Name asc Limit 2];
        System.debug(l1.size());
        for(Account acc:l1){
            System.debug(acc);
        }
    }
    
    //method 2
    public static void updAc(){
        List<Account> ac= [select Id, Name , Industry,AnnualRevenue from Account where Industry =: 'Insurance'];
        List<Account> ac1= new list<Account>();
        if(!ac.isEmpty()){
            for(Account act:ac){
                act.Industry = 'Biotechnology';
                ac1.add(act);
            } 
        }
        update ac1;
        System.debug('Updated Successfully ');
        
    }
    //method 3 usecase for the offset clause   
    public static void ofSet(){
        List<Account> ac= [select Id, Name , Industry,AnnualRevenue from Account order by AnnualRevenue desc limit 1 OFFSET 1];
           if(! ac.isEmpty()){
               for(Account ac2:ac){
                   System.debug(ac2);
            //System.debug(ac);
               }
            
        }
    } 
 
}