import { LightningElement ,api} from 'lwc';

export default class ChildContact extends LightningElement {
    mouseover=false;
    @api contact;
     Phone;
     Email;

    mouse(){
        this.mouseover=true;
     this.Phone=this.contact.Phone;
     this.Email=this.contact.Email;
        }
}