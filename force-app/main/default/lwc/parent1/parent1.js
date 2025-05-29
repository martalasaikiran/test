import { LightningElement } from 'lwc';

export default class Parent1 extends LightningElement {
    per =10; //this updated per value is goining to child 1 from parent html 
    handleonchange(event){
        this.per=event.target.value;

    }
}