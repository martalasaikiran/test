import { LightningElement,api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import { createRecord } from 'lightning/uiRecordApi';
import CRObject from '@salesforce/schema/Credential__c'; 
import CR_Name from '@salesforce/schema/Credential__c.Name__c';
import CR_Age from '@salesforce/schema/Credential__c.Age__c';
import CR_JoiningDate from '@salesforce/schema/Credential__c.JoiningDate__c';
import CR_Birthday from '@salesforce/schema/Credential__c.Birthday__c';
import CR_Role from '@salesforce/schema/Credential__c.Role__c';
import CR_UserName from '@salesforce/schema/Credential__c.UserName__c';
import CR_Password from '@salesforce/schema/Credential__c.Passwords__c';
import CR_Email from '@salesforce/schema/Credential__c.useremail__c';
//import validateLoginDetails from '@salesforce/apex/credintails.validateLoginDetails';
import validateLoginDetails from '@salesforce/apex/credintails.validateLoginDetails';
import { NavigationMixin } from 'lightning/navigation'; 
//import createUser from '@salesforce/apex/userRecordCreation.createUser';
//import createlogincredintails from '@salesforce/apex/userLogINCredentials.userLoginCredentialsUpdateRecord';
import userEmail from '@salesforce/apex/credintails.userEmail';
//import logINUpdateLoginTimeINLoginDetails from'@salesforce/apex/logInloginDetailsObjUpdate.logInloginDetailsObjUpdateRecord';
import logINUpdateLoginTimeINLoginDetails from '@salesforce/apex/logInloginDetailsObjUpdate.logintimeupdate';
//import logindetails from '@salesforce/apex/';
import loginuptime from '@salesforce/apex/logindobju.voidlogindobjuRecord';
import logoutupdate from '@salesforce/apex/logInloginDetailsObjUpdate.logoutimeupdate';
import getActiveUserCount from '@salesforce/apex/LoginStatusController.getActiveUserCount';




import loginemailsender from '@salesforce/apex/LoginEmailService.sendLoginEmail';
import logoutemail from '@salesforce/apex/LogoutEmailService.sendLogoutEmail';

export default class Loginpage extends NavigationMixin(LightningElement) {
    
    issingupdisplay = false;// by this sinup template will come in future
    isLoggedIn = false; // switch the template to child after login 


   //giving the values to this variables which are getting from ui and available for when the record is creating 
    name = '';
    age = '';
    joiningdate = '';
    birthday = '';
    role = '';
    username = '';
    password = '';
    useremail='';
    senduseremailtoobj='';
    
    


    
    handlesinup() {
        this.issingupdisplay = true;
    }

    
   

    //Updating the values which we are getting from the ui to this global varible which help ful to create the record 

    namechange(event) {
        this.name = event.target.value;
    }

    agechange(event) {
        this.age = event.target.value;
    }

    joiningdatechange(event) {
        this.joiningdate = event.target.value;
    }

    birthdaychange(event) {
        this.birthday = event.target.value;
    }

    rolechange(event) {
        this.role = event.target.value;
    }

    usernamechange(event) {
        this.username = event.target.value;
    }

    passwordchange(event) {
        this.password = event.target.value;
    }
    emailchange(event){
        this.useremail=event.target.value;
    }
    //from login page change the 
    loginusernamechange(event){
        this.username=event.target.value;
    }
    loginpasswordchange(event){
        this.password=event.target.value;
    }
    // Save details and create record in Salesforce credential object 
    onsavedetails() {
        if ( !this.username || !this.password) {
            this.showToast('Error', 'Please fill in all required fields.', 'error');
            return;
        }
        // checking the duplicate user name is their or not 
             




        let inputfields = {};
        inputfields[CR_Name.fieldApiName] = this.name;
        inputfields[CR_Age.fieldApiName] = this.age;
       inputfields[CR_JoiningDate.fieldApiName] = this.joiningdate;
      inputfields[CR_Birthday.fieldApiName] = this.birthday;
        inputfields[CR_Role.fieldApiName] = this.role;
        inputfields[CR_UserName.fieldApiName] = this.username;
        inputfields[CR_Password.fieldApiName] = this.password;
        inputfields[CR_Email.fieldApiName]=this.useremail;

        console.log("Input Fields being passed to create record:", inputfields);
        // creating the user in the user object because in case 2 i need to send email to the user and his manager 
      /*  createUser({
            username: this.username,
            email: this.useremail,
            password: this.password,
            roleName: this.role
                    })
            .then(() => {
                this.showToast('Success', 'User created successfully in Salesforce.', 'success');
                
            })
            .catch((error) => {
                console.error('Error creating user:', error.body ? error.body.message : JSON.stringify(error));
                this.showToast('Error', 'Failed to create user: ' + error.body.message, 'error');
            });
         */
        const recordinput = {
            apiName: CRObject.objectApiName,
            fields: inputfields
        };

        // Create the record
        createRecord(recordinput)
            .then((result) => {
                console.log('Record created successfully. Id:', result.id);
                this.showToast('Success', 'Detail saved', 'success');
                this.issingupdisplay = false; 
                
            })
            .catch((error) => {
                console.error('Error creating record:', error.body ? error.body.message : JSON.stringify(error));
            });
           
            

       this.name='';
       this.age='';
       this.joiningdate='';
       this.birthday='';
       this.role='';
       this.username='';
       this.useremail='';
       this.password='';
       
    }
    oncancelbuttom(){
        this.issingupdisplay = false;
    }
    


    //user after hit the login aim to check the user name and password with the credential object 
    handlelogin() {
       
        validateLoginDetails({ username:this.username, password: this.password })
        .then((isValid) => {
            if (isValid) {
                console.log('calling logincount method');
                
                
                
                console.log('called logincount method');
                this.showToast('Success', 'Login successful!', 'success');
                  // If  valid, navigate to the Account page
                  this.isLoggedIn = true; // after login it will navigate to the accoundatatable template 
            } else {
                // If credentials are invalid, show error message
                this.showToast('Error', 'Invalid credentials, please try again.', 'error');
            }
        })
        .catch((error) => {
            // If an error occurs while calling Apex
            this.showToast('Error', 'Error validating credentials: ' + error.body.message, 'error');
        });
        userEmail({ username: this.username, password: this.password })
            .then((email) => {
                if (email) {
                   
                    // here while login you will get the user name but you will not get the users email based on that only in am going to update login time in the login details table bzs i need to show userlogin datatable to my manager  
                    this.senduseremailtoobj = email;
                    console.log('User email: ' + this.senduseremailtoobj);
                    console.log('Before calling loginemailclass, username:', this.username, 'useremail:', this.senduseremailtoobj);
                    
                    loginuptime({username:this.username, useremail:this.senduseremailtoobj})
                    loginemailsender({username:this.username, useremail:this.senduseremailtoobj})
                    
                    console.log('No matching user found');
                }
            })
            .catch((error) => {
                console.error('Error occurred: ', error.body.message);
            });
            
            /*
        createlogincredintails({
            username: this.username,
            email:this.useremail
            
                    })
            .then(() => {
                this.showToast('Success', 'User created successfully in Salesforce.', 'success');
                
            })
            .catch((error) => {
                console.error('Error creating user:', error.body ? error.body.message : JSON.stringify(error));
                this.showToast('Error', 'Failed to create user: ' + error.body.message, 'error');
            });
    
       */
              
        /*     
            logINUpdateLoginTimeINLoginDetails({username: this.username,useremail:this.senduseremailtoobj}).then(() => {
                this.showToast('Success', 'logintimeupdated', 'success');
                
            }) .catch((error) => {
                
                console.error('Error occurred while updating login time:', error);
                this.showToast('Error', 'Error updating login time: ' + (error.body ? error.body.message : error), 'error');
            });
 
        */

            getActiveUserCount()
            .then((count) => {
                console.log('Active users:', count);
                if (count > 2) {
                    alert('The page is under heavy traffic, please be cautious when initiating any long running job.');
                } 
                
            })
            .catch((error) => {
                console.error('Error checking active user count:', error);
            });
            console.log('Before calling Apex method, username:', this.username, 'useremail:', this.senduseremailtoobj);
            logINUpdateLoginTimeINLoginDetails({username:this.username, useremail:this.senduseremailtoobj})
    
        }


   
showToast(title, message, variant) {
    const event = new ShowToastEvent({
        title: title,
        message: message,
        variant: variant
    });
    this.dispatchEvent(event);
}

handlelogout() {
    this.isLoggedIn = false;
    console.log('User email: ' + this.senduseremailtoobj);
    console.log('Before calling logout emaillogout , username:', this.username, 'useremail:', this.senduseremailtoobj);
    // i need to update logout time in the logindetails object 
    logoutupdate({username:this.username, useremail:this.senduseremailtoobj})
    logoutemail({username:this.username, useremail:this.senduseremailtoobj})

    // after login i am making all null
    this.username = '';
    this.password = '';
    this.useremail = '';
    this.role = '';
    this.name = '';
    this.age = '';
    this.joiningdate = '';
    this.birthday = '';
    

    this.showToast('Success', 'You have been logged out.', 'success');
}
navigateToForgotPassword(){
    this[NavigationMixin.Navigate]({
        type: 'standard__navItemPage',
        attributes: {
             apiName:'passwordpage'
           
        },
    });


   
}
}