trigger LeadConversion on Lead (after update) {
    if(Trigger.IsAfter && Trigger.IsUpdate){
        List<Database.LeadConvert> convert = new List<Database.LeadConvert>();
    }
    

}