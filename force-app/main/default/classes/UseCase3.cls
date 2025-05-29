public class UseCase3 {
    Public static Id m1( Id inputid){
        
        Account currentRecord= [SELECT Id,ParentId FROM Account WHERE Id= :inputid LIMIT 1]; 
        
         while (currentRecord.ParentId != null) { 
        currentRecord = [SELECT Id, ParentId FROM Account  WHERE Id = :currentRecord.ParentId LIMIT 1]; 
    } 
      return currentRecord.Id;
 
    }
 
}