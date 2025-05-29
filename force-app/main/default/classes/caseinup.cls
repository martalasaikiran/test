public class caseinup {
    public static void caseRecordsinup(){
        List<Case> lt= [select Id,Status,Priority from Case where status ='New'];
        for(Case cs:lt){
            cs.Priority='High';
        }
        Case c=new Case();
       c.Priority='Low';
        c.Type='Working';
        c.Reason='performance';
        lt.add(c);
        upsert lt;
    }

}