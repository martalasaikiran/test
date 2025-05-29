import { LightningElement } from 'lwc';

export default class ParentHook extends LightningElement {
   displaychild = false;
    constructor(){
        super();
        console.log("ParentHook constructor");
    }
    connectedCallback(){
        console.log("ParentHook connectedCallback");
    }
    
    renderedCallback(){
        console.log("ParentHook renderedCallback");
    }
    errorCallback(error,stack){
        console.log("Parent ErrorCallback");
    }
   
   
   }