import { LightningElement } from 'lwc';

export default class ChildHook extends LightningElement {
    constructor(){
        super();
        console.log("ChildHook constructor");
    }
    connectedCallback(){
        console.log("ChildHook connectedCallback");
    }
    
    renderedCallback(){
        console.log("ChildHook renderedCallback");
    }    
    ErrorcallBack(error,stack){
        console.log("ChildHook ErrorcallBack");
    }
   
}