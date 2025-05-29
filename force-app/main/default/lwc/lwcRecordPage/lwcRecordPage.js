import { LightningElement,api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import { NavigationMixin } from 'lightning/navigation';

export default class LwcRecordPage extends NavigationMixin(LightningElement) {
    @api recordId;
    @api objectApiName;
   // fileds=[ NAME_FIELD, REVENUE_FIELD, INDUSTRY_FIELD];
    fields = [NAME_FIELD, REVENUE_FIELD, INDUSTRY_FIELD];
    navigateToRecordPage(event){
        let pageref={
            type: 'standard__objectPage',
            attributes: {
                recordId:event.detail.id,
                objectApiName: this.objectApiName,
                actionName: 'view',
            }
        };
        console.log("event details ",event.details);
        this[NavigationMixin.Navigate](pageref);
    }
    showToast() {
        const event = new ShowToastEvent({
            title: 'Sucess',
            message:
                'Updated Successfully',
            
            variant: 'success',
        });
        this.dispatchEvent(event);
    }
 }