public class TaskTriggerHandler {
    public static void changeOpportunityStage(List<Task> taskList){
        set<Id> oppIds=new Set<Id>();
    for(Task t:taskList){
        
        if (t.Subject.equals('1stAppointment') && t.Status.equals('Completed')) {
            oppIds.add(t.WhatId);
        }
    }
    List<Opportunity> oppList=new List<Opportunity>();
    if(!oppIds.isEmpty()){
        for(Opportunity op:[select id,StageName,CloseDate,Name from Opportunity where id IN :oppIds]){
            op.StageName='Negotiation/Review';
            oppList.add(op);
        }
    }
    if(!oppList.isEmpty()){
        update oppList;
    }
    }
}