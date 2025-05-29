trigger createRecordINLogInDetails on Credential__c (after insert,after update) {
    if(Trigger.isAfter){ 
       if(Trigger.isInsert ){
        CreateLoginDetailsClass.createLoginCreds(Trigger.new);
    }
         if(Trigger.isupdate ){
        CreateLoginDetailsClass.updateLoginCreds(Trigger.new);
    }
  }
}