trigger Exercise16 on Task (after insert,after update) {
    set<Id> oppIds=new Set<Id>();
    for(Task t:Trigger.new){
        
        if(t.Subject=='1stAppointment' && t.Status=='Completed'){
            System.debug(t.WhatId);
            oppIds.add(t.WhatId);
        }
    }
    List<Opportunity> oppList=new List<Opportunity>();
    if(!oppIds.isEmpty()){
        for(Opportunity op:[select id,StageName,CloseDate,Name from Opportunity where id IN :oppIds]){
            System.debug('oppList1 '+op.Name);
            op.StageName='Negotiation/Review';
            oppList.add(op);
            System.debug('oppList '+oppList);
        }
    }
    if(!oppList.isEmpty()){
        update oppList;
    }
}