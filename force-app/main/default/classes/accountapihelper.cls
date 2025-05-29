@RestResource(URLMapping='/Accountservice/*')
global with sharing class accountapihelper {

    @HttpGet()
    global static List<Account> getAccounts() {
        try {
            System.debug('Account Service web server ');
            List<Account> lstaccounts = [SELECT Name, Industry FROM Account];
            return lstaccounts;
        } catch (Exception e) {
            System.debug(e.getMessage() + ' at line ' + e.getLineNumber());
            return new List<Account>(); 
           }
   }
    @HttpDelete()
    Global static String deleteRecord(){
        Map<String,String> inputDatafFromtarget= RestContext.request.params;
        System.debug(inputDatafFromtarget.get('params are'+'accName'));
        try{
        Account acc = [Select Name , Industry from Account where 	Name=: inputDatafFromtarget.get('accName') limit 1];
        if(acc!=Null){
            delete acc;
           
            }
             return 'recorddeleted';
        }catch(Exception e){
            System.debug('Error occurs at '+ e.getMessage()+ 'at '+e.getlineNumber());
            return 'record  not deleted';
        }
        
    }
 //update the Record in source from the target    
    @HttpPut()
    Global static String updateRecord(String IndustryName){
        
      //  Map<String,String> inputdata= RestContext.request.params;
        try{
            List<Account> accupdate= new List<Account>();
        List<account> acclist =[Select Name,Industry from Account where Industry =: IndustryName];
            for(Account accRecord:acclist){
                accRecord.Industry='Banking';
                accupdate.add(accRecord);
            }
            if(!accupdate.isEmpty()){
                update accupdate;
            }
            System.debug('updated Records:' + accupdate);
          return 'Records updated';  
        }
        catch(Exception e){
            System.debug('Error is '+e.getMessage()+'at '+e.getlineNumber());
            return 'record not updated';
        }
        
        }
        
        @HttpPost()
        Global  static String insertRecord(){
            // getting input json need to change json to object type deserialization 
            //json to string and next string to object type(desrialization )
            String jsontostring =RestContext.request.requestbody.ToString();
            try{
           List<Account> lstacc = (List<Account>)(System.Json.deserialize(jsontostring , List<Account>.class));
                if(!lstacc.isEmpty()){
                    insert lstacc;
                }
                return 'records inserted';
            }catch(Exception e){
                System.debug(' Error is :'+e.getMessage() +' at'+e.getlineNumber());
                return 'records not created';
            }
            
        }
        
    
}