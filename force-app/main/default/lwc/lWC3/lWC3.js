import { LightningElement } from 'lwc';

export default class LWC3 extends LightningElement {
    myList=[];
    constructor(){
        super();
        console.log('constructor');
        }
    connectedCallback(){
        this.myList.push("Saikiran ");
        console.log('connected Call Back ');
    }
    disconnectedCallback(){
        this.myList=[];
        console.log('disconnected Call Back ');
    }
}