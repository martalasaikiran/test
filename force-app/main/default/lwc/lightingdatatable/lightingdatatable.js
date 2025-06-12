
import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getAccountList from '@salesforce/apex/lightingDataTable.getaccountDataTableRecords';
import getContactsByAccountId from '@salesforce/apex/lightingDataTable.getContactsByAccountId';
const COLUMNS = [
  
    { label: 'Account Name',fieldName: 'navigateId',
        type: 'button',
        typeAttributes: {
            label: { fieldName: 'Name' },
            name: 'view_contacts',
            variant: 'base'
        } }  /*
            { label: 'Account Name',
                typeAttributes: {
                label: { fieldName: 'Name' },
                name: 'view_contacts',
                variant: 'base'
            } }*/
            , {
            label: 'Id',
            fieldName: 'Id',
            
        },
    
       
    { label: 'Industry', fieldName: 'Industry' },
    { label: 'Annual Revenue', fieldName: 'AnnualRevenue', type: 'currency' }
];
const contactCOLUMNS = [
   
         
    {
        label: 'FirstName',
        type: 'button',
        fieldName: 'FirstName',
        typeAttributes: {
            label: { fieldName: 'FirstName' },
            name: 'open_contact',
            variant: 'base'
        }
    }
    , { label: 'Id', fieldName: 'Id' },
        
   /*
    { label: 'FirstName', fieldName: 'FirstName' },*/
   
    { label: 'Email', fieldName: 'Email', type: 'Email' }
];
export default class Lightingdatatable extends NavigationMixin(LightningElement) {
    showModal = false; 
    columns = COLUMNS;
   
    accounts = [];

    contactcolumns = contactCOLUMNS;
    contacts = [];
    accountId;
    accountUrl;
    Name;

    connectedCallback() {
        console.log('connected call back is initiated---');
        getAccountList()
            .then(result => {
               
                this.accounts = result
            })
            .catch(error => { 
                console.error('Error:', error);
            });
    }

    handleRowAction(event) {
        const accountId = event.detail.row.Id;
        const Name=event.detail.row.Name;
        this.Name=Name;
        this.accountId=accountId
        console.log('acccount id is---->'+accountId )
        console.log('acccount name is---->'+Name )
        getContactsByAccountId({ accountId: accountId })

        .then(result => {
            //this.contacts = result;
            this.contacts = result
            console.log(Name+' related contacts are '+this.contacts )
             this.showModal = true;
             this.accountUrl=`https://abcd634-dev-ed.develop.lightning.force.com/lightning/r/Account/${accountId}/view`

        })
               
        
        .catch(error => {
            console.error('Error loading contacts:', error);
        });

       
        
    
    }

   


    
handleContactRowAction(event) {
    const actionName = event.detail.action.name;
    const contactId = event.detail.row.Id;

   
        const url = `https://abcd634-dev-ed.develop.lightning.force.com/lightning/r/Contact/${contactId}/view?tab=details`;
        window.open(url, '_blank');
    
}
/*
handleContactRowAction(event) {
    const contactId = event.detail.row.Id;
    this[NavigationMixin.GenerateUrl]({
        type: 'standard__recordPage',
        attributes: {
            recordId: contactId,
            //objectApiName: 'Contact',
            actionName: 'view'
        }
    }).then(url => {
        window.open(url, '_blank');
    });
}
*/

    closeModal(){
        console.log('modal pop-up closed ')
        this.showModal = false;
        this.contacts = [];
        console.log('contacts array be :' ,this.contacts)
    }
}
