import { LightningElement, api } from 'lwc';

export default class StatusIconCell extends LightningElement {
    @api value;

    get iconClass() {
        return this.value === 'Logged In' ? 'green-dot' : 'gray-dot';
    }
}