trigger AccountDeleteTrigger on Account (before delete) {
    if(Trigger.IsBefore && Trigger.IsDelete){
        for(Account  acc: Trigger.old){
            acc.AddError('You are not allowed to delete the record ');
        }
    }
}