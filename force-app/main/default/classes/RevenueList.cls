public class RevenueList {
    public static void topRevenue(){
        List<Account> revenueBucket=[select Id, Name , AnnualRevenue from Account order by AnnualRevenue desc Limit 5 ];
    }

}