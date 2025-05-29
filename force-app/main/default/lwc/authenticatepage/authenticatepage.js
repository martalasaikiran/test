import { LightningElement,wire } from 'lwc';
//import { CurrentPageReference } from 'lightning/navigation';
//import getAccessTokenFromCode from '@salesforce/apex/Authhandle.getAccessTokenFromCode';
import getToken  from '@salesforce/apex/Authhandle.getAccessTokenFromCode';

export default class Authenticatepage extends LightningElement {
    connectedCallback() { 
  
    console.log('connectedCallback method initiated ');
    const urlParams = new URLSearchParams(window.location.search);
    const code = urlParams.get('c__authCode');
    const recordId = urlParams.get('c__recordId');

    console.log('OAuth Code:', code);
    
    console.log('record id is ', recordId);
   // console.log('OAuth State:', state);
   // console.log('current url is ', window.location.search);
   // console.log('current url params ',urlParams);
    if (code) {
        // Calling the apex class 
        getToken({code:code,recordId:recordId})

    }



   }
}
/*
connectedCallback() {   
    console.log('connectedCallback method initiated ');
    const currentUrl = window.location.href;
    const urlParams = new URL(currentUrl).searchParams;
    const code = urlParams.get('code');
    if (code) {
        sessionStorage.setItem('authCode', code);
    } else {
        const savedCode = sessionStorage.getItem('authCode');
        if (savedCode) {
            console.log('Recovered auth code:', savedCode);
        }
    }
}*/
    /*
    authCode;
    stateParam
    @wire(CurrentPageReference)
getStateParameters(currentPageReference) {
    if (currentPageReference) {
        this.authCode = currentPageReference.state?.c__code;
        this.stateParam = currentPageReference.state?.c__state;

        console.log('Auth Code:', this.authCode);
        console.log('State:', this.stateParam);

        
    }
}*/
/*
connectedCallback() {
    console.log('connectedCallback');
    const urlParams = new URLSearchParams(window.location.search);
    const code = urlParams.get('code');
    const state = urlParams.get('state');

    console.log('OAuth Code:', code);
    console.log('OAuth State:', state);
    console.log('current url is ', window.location.search);
    console.log('current url params ',urlParams);

    if (code) {
        // Call Apex to exchange code for access_token
        this.exchangeCodeForToken(code);
    } else {
        console.error('OAuth code missing in URL.');
    }
     
  }
}
*/
/*
    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
            this.authCode = currentPageReference.state?.c__authCode;
            this.stateParam = currentPageReference.state?.c__state;
    
            console.log('Auth__Code:', this.authCode);
            console.log('State__:', this.stateParam);
    
            
        }
    }
   
   */
   
   

   
   
    /* connectedCallback() {   
        console.log('connectedCallback method initiated ');
        const currentUrl = window.location.href;
        const urlParams = new URL(currentUrl).searchParams;
        const code = urlParams.get('code');
        if (code) {
            sessionStorage.setItem('authCode', code);
        } else {
            const savedCode = sessionStorage.getItem('authCode');
            if (savedCode) {
                console.log('Recovered auth code:', savedCode);
            }
        }
    }
} */
   /*
authCode;
stateParam;

@wire(CurrentPageReference)
getStateParameters(currentPageReference) {
    if (currentPageReference) {
        this.authCode = currentPageReference.state?.c__Code;
        this.stateParam = currentPageReference.state?.c__state;

        console.log('Auth Code:', this.authCode);
        console.log('State:', this.stateParam);

        
    }
}
   */
    

   /*
    connectedCallback() {
          console.log('connected call back is initiated ');
        
        const url = window.location.href;
        const urlParams = new URLSearchParams(window.location.search);
        const code = urlParams.get('code');
        const state = urlParams.get('state');

        if (code) {
            console.log('Auth Code:', code);
            console.log('State:', state);

           
            sessionStorage.setItem('auth_code', code);
            sessionStorage.setItem('state', state);

           
            this.exchangeCodeForToken(code);
        } else {
            console.warn('No auth code found in URL.');
        }
    }

    exchangeCodeForToken(code) {
            console.log('authcode is ',code);
           
    }*/
            
    




   
   
    /*
    connectedCallback() {
        console.log('connectedCallback');
        const urlParams = new URLSearchParams(window.location.search);
        const code = urlParams.get('code');
        const state = urlParams.get('state');

        console.log('OAuth Code:', code);
        console.log('OAuth State:', state);

        if (code) {
            // Call Apex to exchange code for access_token
            this.exchangeCodeForToken(code);
        } else {
            console.error('OAuth code missing in URL.');
        }
    }  */
   /*
    connectedCallback(){
        const urlParams = new URLSearchParams(window.location.search);
        const code = urlParams.get('code');
        console.log('code in 2nd lwc --- ' + code);
        /*if (code) {
            // Call Apex method to process the code
            captureCode({ code })
                .then(result => {
                    console.log('Code captured and processed:', result);
                    // Optionally redirect or show success message
                })
                .catch(error => {
                    console.error('Error capturing code:', error);
                });
        } else {
            console.warn('No code parameter found in URL.');
        }
    }
   
   */
   
   
    /*


    timeoutDuration = 60000;
    connectedCallback() {
        console.log('connectedCallback is initiated ');
        this.startTimeout();
    }


    startTimeout() {
        setTimeout(() => {
        }, this.timeoutDuration);
    }
    /*
   constructor(){
    super();
    console.log('constructor is initiated ');
    window.setTimeout(() => {
        this.handleTimeout();
    }, 10000); 
   }
   
    connectedCallback() {
        window.console.log('connected app initiated ');
        setTimeout(() => {
            this.handleTimeout();
        }, 10000); 
    }
    
  /*

    //recordId;
    @wire(CurrentPageReference)
    currentPageReference;
/*
   
    renderedCallback(){
        console.log(`current page referaence =JSON.parse(${this.currentPageReference})`);
        console.log(`c__myParam = ${this.currentPageReference.state.c__myParam}`); 
    }
        */
    
   /* 
    @wire(CurrentPageReference)
    currentPageReference({data,error}){
        if(data){
            console.log(`code = ${this.currentPageReference.state.code}`); 
        }
    }

*/
    
    /*
    authorizationCode = '';

        connectedCallback() {
            const params = new URLSearchParams(window.location.search);
            this.authorizationCode = params.get('code');

            if (this.authorizationCode) {

                console.log('Authorization Code:', this.authorizationCode);
            } else {
                
                console.error('Authorization code not found in URL.');
            }
        }
    
  
    @wire(CurrentPageReference)
    currentPageReference({data,error}){
        if(data){
            console.log(`code = ${this.currentPageReference.state.code}`); 
        }
    }

    connectedCallback() {      
        console.log(`c__myParam = ${this.currentPageReference.state.code}`); 
    }

    /*@wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference && currentPageReference.state) {
            this.authCode = currentPageReference.state.c__code;
            this.recordId = currentPageReference.state.state;

            console.log('Authorization Code:', this.authCode);
           // console.log('Record ID:', this.recordId);
         /*
            if (this.authCode && this.recordId) {
                // Apex call to exchange auth code for access token
                getAccessTokenFromCode({
                    code: this.authCode
                    
                    
                    clientId: '3MVG9k02hQhyUgQDyFbANomPFNyfWwhCKLbS4oHi3LU7a6KflixCqcpddeacUY.PMx01K3kxySRveHqLj4Pcw',
                    clientSecret: '2809F64E5317B22BACB3FD7E45E661130F07C0057EEED04DC2618339DBF9480E',
                    redirectUri: 'https://abcd634-dev-ed.develop.my.salesforce.com/lightning/cmp/c__authenticatepage'
        
                })
               
            }
                
        }
    }

  

/*
connectedCallback() {
    const urlParams = new URLSearchParams(window.location.search);
    this.authCode = urlParams.get('code');
    console.log('Auth Code:', this.authCode);

    } */
