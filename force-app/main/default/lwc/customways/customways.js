import { LightningElement ,wire,api} from 'lwc';
import getAccountRecords from '@salesforce/apex/AccountHelper.getAccountRecords';
import { createRecord, getFieldValue, getRecord } from 'lightning/uiRecordApi';
import { updateRecord } from 'lightning/uiRecordApi';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Account_Object from'@salesforce/schema/Account';
import Account_Name from '@salesforce/schema/Account.Name';
import Account_ID from '@salesforce/schema/Account.Id';
import Phone from '@salesforce/schema/Account.Phone';
//import Email from '@salesforce/schema/Account.AccountEmail__c';
import Parent_Acccount from '@salesforce/schema/Account.ParentId';
import Industry from '@salesforce/schema/Account.Industry';
import { NavigationMixin } from 'lightning/navigation';
const feildsToDisplay = [
    Parent_Acccount,
    Industry,
    Account_Name,
    Phone,
    ];
export default class Customways extends  NavigationMixin(LightningElement) {
    optionsparent=[];
    selparent="";
    accName='';
    accPhone='';
    //accEmail='';
    @api recordId;
    
    @wire(getRecord, { recordId: '$recordId',fields: feildsToDisplay }) accountRecord({data,error}){
        if(data){
             this.selparent=getFieldValue(data,Parent_Acccount);
            this.industryvalue=getFieldValue(data,Industry);
            this.accName=getFieldValue(data,Account_Name);
            this.accphone=getFieldValue(data,Phone);
            
            console.log('the data is '+data); 
        }
        else if(error){
            console.log('the Error is '+error)
        }
    }
   
 @wire(getAccountRecords) accRecord({ data, error}){
   
    if(data){
        this.optionsparent=data.map((currentitem)=>({
            label:currentitem.Name,
             value:currentitem.Id
        }));

    }
    else if(error){
        console.log('the Error is '+error)
        }
  } 
    handleChange(event){
        this.selparent=event.detail.value
    }


//for industry 
industryvalue = '';

    get industry() {
        return [
            { label: 'Agriculture', value: 'Agriculture' },
            { label: 'Biotechnology', value: 'Biotechnology' },
            { label: '	Banking', value: 'Banking' },
        ];
    }
   

    industryhandlechange(event) {
        this.industryvalue = event.detail.value;
    }
    accnamehandle(event){
        this.accName=event.detail.value;
    }
    accphonehandle(event){
        this.accPhone=event.detail.value;
    }
   
    handleSave(event){
        let inputfields={};
        inputfields[Account_Name.fieldApiName ]=this.accName;
        inputfields[Phone.fieldApiName ]=this.accPhone;
     //   inputfields[Email.fieldApiName ]=this.accEmail;
        inputfields[Parent_Acccount.fieldApiName ]=this. selparent;
        inputfields[Industry.fieldApiName ]=this.Industryvalue;
    if(this.recordId){
        //updating the record 
        inputfields[Account_ID.fieldApiName]=this.recordId;

        const recordInput = { fields: inputfields };
       
        updateRecord(recordInput)
        .then((result) => {
            console.log('record updated ');
            this.showToast();
        })
        .catch((error) => {
            console.log('error is '+error);
        });

    }
    else{ 
        
            //creating the record 
        
           
         const   recordinput={
                apiName:Account_Object.objectApiName,
                fields:inputfields
            };
            createRecord(recordinput)
            .then((result) => {
                console.log('Record created successfully. Id:', result.id);
                let refRecord = {
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: result.id,
                        objectApiName: 'Account',
                        actionName: 'view'
                    }
                };
                this[NavigationMixin.Navigate](refRecord);
                
            })
    .catch((error) => {
        console.log('Error creating record:', error.body ? error.body.message : JSON.stringify(error));
    });
    
        
    }
}
   
   
    get formtitle(){
        if(this.recordId){
            return 'Edit Account';
        }
        else{
            return 'Create Account';
    }
}
showToast() {
    const event = new ShowToastEvent({
        title: 'success',
        message:
            'Record Updated Successfully',
            variant: 'success'
  
    });
    this.dispatchEvent(event);
}
get deletebuttonpresence(){
    if(this.recordId){
        return true;
    }
    else{
        return false;
    }
}

deletehandler(){
    deleteRecord(this.recordId).then(()=>{
        let refRecord = {
            type: 'standard__ObjectPage',
            attributes: {
                //recordId: result.id,
                objectApiName: 'Account',
                actionName: 'view'
            
            }
        };
        this[NavigationMixin.Navigate](refRecord);
         console.log('record deleted successfully');
        }).catch((error)=>{
            console.log('error for deleting record ');
           
            console.log(JSON.stringify(error));
        })
   
 }
}