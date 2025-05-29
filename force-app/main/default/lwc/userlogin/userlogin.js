import { LightningElement, track } from 'lwc';
import validateLoginDetails from '@salesforce/apex/UserDetails.validateLoginDetails';
import { NavigationMixin } from 'lightning/navigation';


export default class Userlogin extends NavigationMixin(LightningElement) {
    @track username = '';
    @track password = '';
    @track error = '';
 
    handleUsernameChange(event) {
        this.username = event.target.value;
    }
 
    handlePasswordChange(event) {
        this.password = event.target.value;
    }
 
   
 
    handleLogin() {
    this.error = '';
    validateLoginDetails({ username: this.username, password: this.password })
        .then(loginActivityId => {
            if (loginActivityId) {
                // Store activity ID in session for logout use
                sessionStorage.setItem('loginActivityId', loginActivityId);
 
                this[NavigationMixin.Navigate]({
                    type: 'standard__navItemPage',
                    attributes: { apiName:'accountViewer' }
                });
            } else {
                this.error = 'Invalid credentials.';
            }
        })
        .catch(error => {
            this.error = 'Error: ' + error.body.message;
        });
} 
    
    
        navigateToSignup() {
            const navigationData = {
                type: 'standard__navItemPage',
                attributes: {
                    apiName: 'Sinup_Page'
                }
            };
        
            // Log the navigation object to the console
            console.log("Navigation Data:", JSON.stringify(navigationData));
        
            try {
                // Proceed with the navigation using the NavigationMixin
                this[NavigationMixin.Navigate](navigationData);
        
                console.log("Navigation initiated to SignupPage.");
            } catch (error) {
                console.error("Navigation failed:", error);
            }
        }
    
 
    navigateToForgotPassword() {
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'forgotpassword'
            }
        });
    }
}