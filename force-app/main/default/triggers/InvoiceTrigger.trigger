trigger InvoiceTrigger on Invoice__c (before insert, before update) {
    if(Trigger.IsBefore && Trigger.IsInsert){
        InvoinTrigger.check(Trigger.New);
    }
    if(Trigger.IsBefore && Trigger.IsUpdate){
         InvoinTrigger.check(Trigger.New);
    }
}