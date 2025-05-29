public class future {
    
    //aim is the Queable class also avoiding the Mixed DmL Exception
    
    
    public static void usermethod(){
             try{
                User userinfo =[select  ID,FirstName,LastName, 	IsActive from User where 	Username =:'mr4758@srmist.edu.in' ];
                 if(userinfo!=null){
                     userinfo.IsActive=false;
                 }
                 update userinfo;
                   future.futuremethod();
         }
          catch(Exception e){
            System.debug('Error Message '+e.getMessage()+ 'at  '+e.getlineNumber());
         }
        Account acc = new Account();
        acc.Name = 'test';
      
        
   }
   // @future()
    public static void futuremethod(){
        try{
      Account acc = new Account();
        acc.Name='futurerecord';
            if(acc!=null){
                insert acc;
            }
        }
        catch(Exception e ){
            System.debug('Error is  '+e.getMessage() +'at '+e.getlineNumber());
        }
        
        
    }
}