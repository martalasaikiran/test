import { LightningElement, api } from 'lwc';

export default class Child1 extends LightningElement {
    @api percentage; 

    get style() {
        return `background-color: rgb(0, 255, 0); min-height:50px; width:${this.percentage}%; border:1px solid black;`;
    }
}