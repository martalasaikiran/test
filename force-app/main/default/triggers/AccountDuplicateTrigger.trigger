trigger AccountDuplicateTrigger on Account (before insert) {
    if(Trigger.IsBefore && Trigger.IsInsert){
        for(Account acc : Trigger.New){
            Integer count=[select count() from Account where Name =: acc.Name];
            if(count>1){
                acc.AddError('This Account Name Already Existed ');
            }
        }
    }
}