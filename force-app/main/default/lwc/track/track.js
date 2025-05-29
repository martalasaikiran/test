import { LightningElement ,track} from 'lwc';

export default class Track extends LightningElement {
 @track   myList=[];
    newitem ;
    
    handleChange(event){
        this.newitem=event.target.value;

}
 addItemToList(){
    this.myList.push(this.newitem);
 }
}