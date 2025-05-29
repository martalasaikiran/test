public class topFiveAnnualRevenueRecord {
    public static void topFiveRevenueRecord(){
        List<Account> topfiverevenuerecordslist = [select Name,AnnualRevenue,Industry from Account order by AnnualRevenue desc nulls last Limit 5 ];
           system.debug('Topfive revenue accounts is created'); 
        if(!topfiverevenuerecordslist.isEmpty()){
            System.debug('top five revenue accounts are '+topfiverevenuerecordslist );
        }
    }

 }