import { LightningElement } from 'lwc';
import validateUserEmail from '@salesforce/apex/passwordValidate.passwordValidateRecord';
import changlepasswordRecord from '@salesforce/apex/passwordValidate.changlepassword';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Passwordpage extends NavigationMixin(LightningElement){
    
    ispasswordpage=false;
    useremail='';
    newpassword='';
    emailchange(event){ 
        this.useremail=event.target.value;//giving value to the lobal useremail which iam getting from the ui 
    }
    handlecancelnavtologinpage(){
        this.username='';
        this.navigatetologinpage();
            }
    
    onsubmit(){
        // i need to check the user email in the credintail object if there need to display created password 
        validateUserEmail({ useremail:this.useremail })
                .then((isValid) => {
                    if (isValid) {
                        
                        
                     
                          this.ispasswordpage = true; // goes to password creation page 
                    } else {
                        // If email not found 
                        this.showToast('Error', 'Invalid useremail', 'error');
                    }
                })
                .catch((error) => {
                    // If an error occurs while calling Apex
                    this.showToast('Error', 'Error validating credentials: ' + error.body.message, 'error');
                });
                //
                
    }
    newpasswordhandle(event){
        this.newpassword=event.target.value;
        
    } 
    handlecancel(){

        this.ispasswordpage=false;
        this.useremail='';
    }
    changepassword(){
        
        changlepasswordRecord({useremail:this.useremail ,newpassword:this.newpassword}) .then((result) => {
           //making the user name and newpassword null for next term 
            this.useremail='';
           this.newpassword='';
           this.showToast('PasswordUpdate', 'NewPasswordCreated', 'success');
         
           this.navigatetologinpage();
     
            
        })
        .catch((error) => {
            console.error('Error creating record:', error.body ? error.body.message : JSON.stringify(error));
        });

   }
   navigatetologinpage() {
    this[NavigationMixin.Navigate]({
        type: 'standard__navItemPage',
        attributes: {
            apiName: 'login'
        }
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