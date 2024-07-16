trigger Exercise17 on Lead (before insert,before update) {
    for(Lead ld:Trigger.new){
        if(ld.Status=='Unqualified'){
            if(ld.Reason__c==null){
                ld.Reason__c.addError('if status is Unqualified this field should be populated');
            }
        }
    }
}