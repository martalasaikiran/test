import { LightningElement,api,wire } from 'lwc';
import {getRecord, getFieldDisplayValue} from 'lightning/uiRecordApi';
import Name_Field from '@salesforce/schema/Account.Name';
import Industry_Field from '@salesforce/schema/Account.Industry';
export default class Wireadapter extends LightningElement {

    //fields_Names=[Name_Field,Industry_Field];

    
        @api recordId;
        @wire(getRecord, { recordId: '$recordId', fields: [Name_Field, Industry_Field] })
        record;

        get name() {
            return this.record.data ? getFieldDisplayValue(this.record.data, Name_Field) : null;
        }
        get industry(){
            return this.record.data ? getFieldDisplayValue(this.record.data, Industry_Field) : null;
        }
     
}
