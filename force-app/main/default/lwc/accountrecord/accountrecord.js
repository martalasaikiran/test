import { LightningElement } from 'lwc';
import Name from '@salesforce/schema/Account.Name';
import Industry from '@salesforce/schema/Accoutn.Indutry';

export default class Accountrecord extends LightningElement {
    Name ;
    Industry;
    OnNameChange(event){
        this.Name=event.target.value;
    }
    OnIndustryChange(){
          this.Industry=event.target.value;
    }
    handleClickButton(){
        let inputfields = {};
                inputfields[Name.fieldApiName] = this.Name;
                inputfields[Industry.fieldApiName] = this.Industry;
                  const recordinput = {
                            apiName: Account.objectApiName,
                            fields: inputfields
                        };
        createRecord(recordinput)
                   .then((result) => {
                       console.log('Record created successfully. Id:', result.id);
                       this.showToast('Success', 'Account Record Created', 'success');
                       
                       
                   })
                   .catch((error) => {
                       console.error('Error creating record:', error.body ? error.body.message : JSON.stringify(error));
                   });
        
                  
    }
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}