public class futureMethod1praticce {
    @future()
    public static void futuremethod1(Id conid){
        Contact con =[select FirstName,LastName from Contact where Id=:conid];
        System.debug(con);
    }
}