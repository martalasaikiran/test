public class createContact {
    public static void createContactrc(){
        Contact conRecord= new Contact();
        conRecord.Salutation='Mr.';
        conRecord.LastName='Martala';
        conRecord.Email='sai@gmail.com';
        insert conRecord;
    }
}