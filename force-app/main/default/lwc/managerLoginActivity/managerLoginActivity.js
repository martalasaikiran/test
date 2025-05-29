import { LightningElement, wire } from 'lwc';
import getRecentLogins from '@salesforce/apex/UserDetails.getRecentLogins';
 
export default class ManagerLoginActivity extends LightningElement {
    activities = [];
 
    @wire(getRecentLogins)
    wiredLogins({ error, data }) {
        if (data) {
            this.activities = data.map(row => ({
                ...row,
                statusIcon: row.LogoutTiming__c ? 'utility:stopwatch' : 'utility:success',
                statusColor: row.LogoutTiming__c ? 'gray' : 'green',
                screenTime: row.LogoutTiming__c? row.ActiveHours__c: 'In Progress'
            }));
        } else {
            console.error(error);
        }
    }
 
}