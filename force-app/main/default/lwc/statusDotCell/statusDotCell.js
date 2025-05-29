import { LightningElement, api } from 'lwc';

export default class StatusDotCell extends LightningElement {
    @api value;

    get statusClass() {
        return this.value === 'Login' ? 'dot-green' : 'dot-gray';
    }
}