trigger Exercise3 on Lead (before insert,before update) {
    for(Lead ld:Trigger.new){
        if(ld.Email!=null){
            String EmailOfCurrentRecord=ld.Email;
            if(EmailOfCurrentRecord.length()<20){
                EmailOfCurrentRecord=EmailOfCurrentRecord+'z';
                ld.Email=EmailOfCurrentRecord;
                System.debug(ld.Email);                
            }    
            
        } 
    }
}