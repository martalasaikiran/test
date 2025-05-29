trigger AccountTrigger on Account (before insert) {
    if(Trigger.isInsert && Trigger.isBefore){
        for(Account accRecord:Trigger.New){
            if(accRecord.Rating==Null || accRecord.Rating==''){
                accRecord.AddError('Please fill the Rating ');
            }
            else if(accRecord.Industry==Null || accRecord.Industry==''){
                accRecord.industry.AddError('Pleade fill the Industry');
            }
        }
        
    }

}