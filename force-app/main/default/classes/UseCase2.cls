public class UseCase2 {
    public static String m1(String input){
        Integer len=input.length();
        String result='';
        Integer string_need_to_create;
            if(len/60==0){
                string_need_to_create=len/60;
                
            }
        else if(len<60){
            string_need_to_create=1;
        }
        else{
            string_need_to_create=len/60 + 1;
        }
        for(Integer i=0;i<string_need_to_create;i++){
            Integer Start=i*60;
            Integer Ennd=Math.min((i + 1) * 60, len);  
            result += input.substring(start, Ennd);
        }
        System.debug('Length of the input String is  '+len+' Created strings are '+string_need_to_create);
        return result ;
    }
}