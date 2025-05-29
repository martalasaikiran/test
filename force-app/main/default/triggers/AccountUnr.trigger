trigger AccountUnr on Account (after Undelete){
    if(Trigger.IsAfter  && Trigger.IsUnDelete){ 
        for(Account acc: Trigger.New){
            if(acc.Name=='sai' || acc.Name=='vasavi'){
           acc.addError('You are not allowed to restore the ' + acc.Name + ' account record.');
               }
            }
        
    }
}