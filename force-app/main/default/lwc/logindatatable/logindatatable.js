import { LightningElement, wire } from 'lwc';
import getLoginDetails from '@salesforce/apex/loginDetailsController.getLoginDetails';
import statusDotCell from 'c/statusDotCell';

const COLUMNS = [
    { label: 'User Name', fieldName: 'Name' },
    { label: 'Login Time', fieldName: 'LoginTime__c', type: 'datetime' },
    { label: 'Logout Time', fieldName: 'LogoutTIme__c', type: 'datetime' },
    {
        label: 'Status',
        fieldName: 'Status__c',
        type: 'customStatus',
        typeAttributes: {
            value: { fieldName: 'Status__c' }
        }
    },
    { label: 'Spent Time (hrs.min)', fieldName: 'SpentTime__c', type: 'number' },
];

export default class LoginDetailsTable extends LightningElement {
    columns = COLUMNS;
    loginDetails = [];

    customTypes = {
        customStatus: {
            template: statusDotCell,
            typeAttributes: ['value']
        }
    };

    @wire(getLoginDetails)
    wiredLoginDetails({ data, error }) {
        if (data) {
            this.loginDetails = data;
        } else if (error) {
            console.error('Error fetching login details:', error);
        }
    }
}