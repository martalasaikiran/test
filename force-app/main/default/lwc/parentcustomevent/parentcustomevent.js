import { LightningElement } from 'lwc';

export default class Parentcustomevent extends LightningElement {
    display=false;

    handlechildevent(){
        this.display=true;
   }
}
