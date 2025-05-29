import { LightningElement,wire } from 'lwc';
import Revenue from '@salesforce/apex/revenue.Revenue';
export default class HighRevenue extends LightningElement {
    accountsToDisplay=[];
   // @wire(Revenue)
    
    @wire(Revenue)
    wiredAccounts({ error, data }) {
        if (error) {
            console.error('Error fetching accounts:', error);
        } else if (data) {
            this.accountsToDisplay = data; 
    }
}
}