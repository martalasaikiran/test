import { LightningElement, wire, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getAccountList from '@salesforce/apex/accountDataTableRecords.getaccountDataTableRecords';
import getOpportunities from '@salesforce/apex/accountRecordRelatedController.getOpportunities';
import getContacts from '@salesforce/apex/accountRecordRelatedController.getContacts';
import getCases from '@salesforce/apex/accountRecordRelatedController.getCases';
import userLoginCredentialsUpdateRecordLogOut from '@salesforce/apex/userLogINCredentials.userLoginCredentialsUpdateRecordLogOut';

const COLUMNS = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'Account Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry' },
    { label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'currency' },
    {
        type: 'button',
        typeAttributes: {
            label: 'Related Records',
            name: 'view_details',
            variant: 'brand'
        }
    }
];

const OPPORTUNITY_COLUMNS = [
    { label: 'Opportunity Name', fieldName: 'Name' },
    { label: 'Stage', fieldName: 'StageName' },
    { label: 'Amount', fieldName: 'Amount', type: 'currency' }
];

const CONTACT_COLUMNS = [
    { label: 'Name', fieldName: 'FirstName' },
    { label: 'Email', fieldName: 'Email' },
    { label: 'Phone', fieldName: 'Phone' }
];

const CASE_COLUMNS = [
    { label: 'Reason', fieldName: 'Reason' },
    { label: 'Subject', fieldName: 'Subject' },
    { label: 'Status', fieldName: 'Status' }
];

export default class ApexDatatableExample extends LightningElement {
    columns = COLUMNS;
    opportunityColumns = OPPORTUNITY_COLUMNS;
    contactColumns = CONTACT_COLUMNS;
    caseColumns = CASE_COLUMNS;

    @api username;
    @api useremail;

    @track accounts = {};
    @track opportunities = [];
    @track contacts = [];
    @track cases = [];

    @track selectedAccountId;
    @track selectedAccountName;

    @wire(getAccountList)
    wiredAccounts(result) {
        this.accounts = result;
        if (result.error) {
            console.error('Error loading accounts:', result.error);
        }
    }

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        if (actionName === 'view_details') {
            this.selectedAccountId = row.Id;
            this.selectedAccountName = row.Name;
            this.fetchRelatedData(this.selectedAccountId);
        }
    }

    fetchRelatedData(accountId) {
        console.log('current account id is ', accountId);
    
        this.opportunities = [];
        this.contacts = [];
        this.cases = [];
    
        getOpportunities({ accountId }) 
            .then(data => {
                this.opportunities = [...data];
                console.log('Opportunities:', data);
            })
            .catch(error => console.error('Error fetching opportunities:', error));
    
        getContacts({ accountId }) 
            .then(data => {
                this.contacts = [...data];
                console.log('Contacts:', data);
            })
            .catch(error => console.error('Error fetching contacts:', error));
    
        getCases({ accountId }) 
            .then(data => {
                this.cases = [...data];
                console.log('Cases:', data);
            })
            .catch(error => console.error('Error fetching cases:', error));
    }
    

    onlogout() {
        userLoginCredentialsUpdateRecordLogOut({
            username: this.username,
            email: this.useremail
        })
        .then(() => {
            this.showToast('Success', 'Logout time updated successfully.', 'success');
            this.dispatchEvent(new CustomEvent('logout'));   
        })
        .catch((error) => {
            console.error('Logout error:', error);
            this.showToast('Error', 'Failed to update logout time.', 'error');
        });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({
            title,
            message,
            variant
        }));
    }
}