import { LightningElement, track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import handleLogout from '@salesforce/apex/UserDetails.handleLogout';
import managerAuthenticated from '@salesforce/apex/UserDetails.managerAuthenticated';
import { NavigationMixin } from 'lightning/navigation';
import getActiveUserCount from '@salesforce/apex/UserDetails.getActiveUserCount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
 
export default class AccountViewer extends NavigationMixin(LightningElement) {
    @track accounts = [];
    @track selectedAccountId;
    @track isManager = false;
 
    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Industry', fieldName: 'Industry' },
        { label: 'Phone', fieldName: 'Phone' },
        {
            type: 'button',
            typeAttributes: {
                label: 'View Related',
                name: 'view_related',
                variant: 'brand'
            }
        }
    ];
 
    connectedCallback() {
        this.checkManagerStatus();
        this.checkUserLoad();
    }
 
    @wire(getAccounts)
    wiredAccounts({ error, data }) {
        if (data) {
            this.accounts = data;
        } else if (error) {
            console.error('Error fetching accounts:', error);
        }
    }
 
    handleRowAction(event) {
        const action = event.detail.action.name;
        const row = event.detail.row;
 
        if (action === 'view_related') {
            this.selectedAccountId = row.Id;
        }
    }
 
    navigateToLogin() {
        const activityId = sessionStorage.getItem('loginActivityId');
        if (activityId) {
            handleLogout({ loginActivityId: activityId })
                .then(() => {
                    sessionStorage.removeItem('loginActivityId');
                    this[NavigationMixin.Navigate]({
                        type: 'standard__navItemPage',
                        attributes: { apiName: 'User_Login' }
                    });
                })
                .catch(error => {
                    console.error('Logout error:', error);
                });
        } else {
            console.warn('No login activity ID found.');
        }
    }
 
    checkManagerStatus() {
        const activityId = sessionStorage.getItem('loginActivityId');
        if (activityId) {
            managerAuthenticated({ loginActivityId: activityId })
                .then((result) => {
                    this.isManager = result;
                })
                .catch((error) => {
                    console.error('Error checking manager status:', error);
                });
        }
    }
    checkUserLoad() {
        getActiveUserCount()
            .then(count => {
                if (count > 3) {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Heavy Traffic',
                            message: 'The page is under heavy traffic, please be cautious when initiating any long running job.',
                            variant: 'warning',
                            mode: 'sticky'
                        })
                    );
                }
            })
            .catch(error => {
                console.error('Error fetching active user count:', error);
            });
    }
}