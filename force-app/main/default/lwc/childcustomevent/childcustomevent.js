import { LightningElement } from 'lwc';

export default class Childcustomevent extends LightningElement {
    handle(){
      let custmevent  =new CustomEvent("childevent")
      this.dispatchEvent(custmevent);
    }
}