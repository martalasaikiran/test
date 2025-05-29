import { LightningElement, track } from 'lwc';
import createUser from '@salesforce/apex/SignupController.createUser';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
 
export default class SignupPage extends NavigationMixin(LightningElement) {
    @track name = '';
    @track username = '';
    @track password = '';
    @track email = '';
    @track role = '';
    @track age = '';
    @track birthday = '';
    @track joiningDate = '';
    @track isManager = false; // ✅ Added manager checkbox tracking
 
    handleChange(event) {
        const field = event.target.dataset.id;
        const value = event.target.type === 'checkbox' ? event.target.checked : event.target.value;
        this[field] = value;
    }
 
    handleSubmit() {
        createUser({
            name: this.name,
            username: this.username,
            password: this.password,
            email: this.email,
            role: this.role,
            age: parseInt(this.age),
            birthday: this.birthday,
            joiningDate: this.joiningDate,
            isManager: this.isManager
        })
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Account created successfully. You can now login!',
                    variant: 'success'
                })
            );
            this.clearForm();
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });
    }
 
    clearForm() {
        this.name = '';
        this.username = '';
        this.password = '';
        this.email = '';
        this.role = '';
        this.age = '';
        this.birthday = '';
        this.joiningDate = '';
        this.isManager = false; // ✅ Reset checkbox
    }
 
    navigateToLogin() {
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'User_Login'
            }
        });
    }
}