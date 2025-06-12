import { LightningElement } from 'lwc';
import rendersupport from '@salesforce/apex/rendersupport.rendersupportmethod';

export default class Renderpratice extends LightningElement {
    accountNames = [];

    handleClick() {
        console.log('Button clicked');
        rendersupport()
            .then(data => {
                this.accountNames = data.map(item => {
                    const lower = item.Name.toLowerCase();
                    const upper = lower.toUpperCase();
                    return { name: upper };
                });
                console.log(this.accountNames);
            })
            .catch(error => {
                console.error('Error fetching account data:', error);
            });
    }
}
