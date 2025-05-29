trigger triggertask3 on Account (after insert, after update) { 

     

    if (Trigger.isAfter && Trigger.isInsert) { 

        AccountHelper5.createRelatedContacts(Trigger.new); 

    } 

     

    if (Trigger.isAfter && Trigger.isUpdate) { 

        AccountHelper5.createRelatedContacts(Trigger.new); 

    } 

}