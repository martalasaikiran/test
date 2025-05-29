trigger triggerFroFutureContactMethod on Contact (after insert) {
    if(Trigger.IsAfter && Trigger.IsInsert){
        for(Contact con:Trigger.New){
           futureMethod1praticce.futuremethod1(con.Id);
        }
    }
}