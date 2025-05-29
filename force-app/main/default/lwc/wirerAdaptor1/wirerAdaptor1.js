import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import Name_Field from '@salesforce/schema/Account.Name';
import Phone_Field from '@salesforce/schema/Account.Phone';

export default class WirerAdaptor1 extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: '$recordId', fields: [Name_Field, Phone_Field] })
    record;

    get name() {
        return this.record.data ? getFieldValue(this.record.data, Name_Field) : null;
    }

    get phone() {
        return this.record.data ? getFieldValue(this.record.data, Phone_Field) : null;
    }
}