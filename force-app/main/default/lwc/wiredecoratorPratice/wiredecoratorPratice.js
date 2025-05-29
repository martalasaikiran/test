import { LightningElement ,wire } from 'lwc';
import getRecords from '@salesforce/apex/praticeClass.getRecords';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry' },
    { label: 'Rating', fieldName: 'Rating'}
];

export default class WiredecoratorPratice extends LightningElement {
    @wire(getRecords) recordsdata
    columns=columns;
}