trigger ContactsValidateTrigger on Contact (before insert) {
    if(Trigger.IsInsert && Trigger.IsBefore){
        for(Contact con:Trigger.New){
            if(con.MobilePhone !=Null){
                if(con.Email==Null || con.Email==' '){
                    con.Email.AddError('Please Enter the Email ');
                } 
            }
        }
    }
}