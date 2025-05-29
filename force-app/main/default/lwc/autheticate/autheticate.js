import { LightningElement ,api,wire} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

import geturl from '@salesforce/apex/Authhandle.geturl';

export default class Autheticate extends  NavigationMixin(LightningElement) {
    @api recordId;
    url
   
   
   
handleClickAuthenticate(){
             //imperative call 
             console.log('clicked authenticate button ');
             geturl({recordId:this.recordId}).then((result)=>
                {
                     this.url=result;
                     console.log('url is :'+this.url);
                     window.open(this.url);
                     //console.log('url is :'+this.url);
                    
                     
                }).catch(error)
             

        }
        
    }