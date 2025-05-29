//requirement industry=Banking  in lead record Phone fax, Email, and Annual revenue is required 
trigger LeadTrigger on Lead (before insert) {
    if(Trigger.Isinsert && Trigger.IsBefore){
        for(Lead ld: Trigger.New){
            if(ld.Industry == 'Banking'){
                if(ld.Phone==Null || ld.Phone==''){
                    ld.AddError('Please , fill the Phone Field');
                }
                else if(ld.Email==Null ||ld.email==''){
                    ld.AddError('Please fill the email field');
                }
                else if (ld.AnnualRevenue==Null ){
                    ld.AddError('Hello, Fill the Annual Revenue Field ');
                }
            }
        }
    }

}