import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import getContactsByAccountId from '@salesforce/apex/lightingDataTable.getContactsByAccountId';




const COLUMNS = [
    { label: 'Id', fieldName: 'Id' },
   
    { label: 'FirstName', fieldName: 'FirstName' },
   
    { label: 'Email', fieldName: 'Email', type: 'Email' }
];


export default class ContactsByAccount extends LightningElement {
    columns = COLUMNS;
    accountId;
    contacts = [];



    connectedCallback(){

    }

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
            this.accountId = currentPageReference.state?.id;
            if (this.accountId) {
                this.loadContacts();
            }
        }
    }


    @wire(getContactsByAccountId, { accountId: '$accountId' })
    wiredContacts({ error, data }) {
        if (data) {
            this.contacts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.contacts = undefined;
            console.error('Error loading contacts:', error);
        }
    }
    /*
    @wire(getContactsByAccountId)
        getContactsByAccountId({ accountId: this.accountId })
            .then(result => {
                this.contacts = result;
            })
            .catch(error => {
                console.error('Error loading contacts', error);
            });

    */

}
