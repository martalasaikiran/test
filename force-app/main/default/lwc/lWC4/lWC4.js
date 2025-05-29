import { LightningElement } from 'lwc';

export default class MyComponent extends LightningElement {
    myList = [];

    constructor() {
        super();
        console.log('constructor');
    }

    connectedCallback() {
        // This will be called when the component is inserted into the DOM
        this.myList.push('Sai');
        console.log('connectedCallback - myList after push: ', this.myList);
    }

    handleClick() {
        // Handle the click event from the button
        alert('Button Clicked!');
    }
}