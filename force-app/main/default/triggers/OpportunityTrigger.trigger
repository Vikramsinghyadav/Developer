trigger OpportunityTrigger on Opportunity (before insert,before update,after insert, after update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
    	OpportunityTriggerHandler.populateNextStep(Trigger.new,Trigger.oldMap);
        OpportunityTriggerHandler.closeDateCheck(Trigger.new);
    }
     if(Trigger.isAfter && ( Trigger.isUpdate)){
    	OpportunityTriggerHandler.createContract(Trigger.new);
    }
}