import { LightningElement, api } from 'lwc';

export default class StatusCellRenderer extends LightningElement {
    @api value;

    get statusClass() {
        return this.value === 'Login' ? 'dot dot-green' : 'dot dot-gray';
    }
}