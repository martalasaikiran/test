trigger ContactCountTrigger on Contact (after insert,after update,after delete,after undelete) {
      if (Trigger.isAfter){
        if (Trigger.isInsert){
            AccCountRecord.countRecord(Trigger.new,null);
        }else if(Trigger.isUndelete){
             AccCountRecord.countRecord(Trigger.new,null);
        }else if(Trigger.isUpdate){
            AccCountRecord.countRecord(Trigger.new,Trigger.oldMap);
        }else if(Trigger.isDelete){
            AccCountRecord.countRecord(null,Trigger.oldMap);
        }
    }
 
}