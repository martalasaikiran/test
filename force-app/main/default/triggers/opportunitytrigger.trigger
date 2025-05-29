trigger opportunitytrigger on Opportunity (after insert ,after update) {
    if(Trigger.isAfter ){
        if(Trigger.isInsert || Trigger.isUpdate){
        
           // opportunityclass.getRecords(Trigger.new);
           System.enqueueJob(new taskTwooppqueable(Trigger.new));
        }

        
    }
}