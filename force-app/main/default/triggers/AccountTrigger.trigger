trigger AccountTrigger on Account (before insert,before update,after insert,after update) {
     if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
    	AccountTriggerHandler.startsWith5(Trigger.new);
    }
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
    	AccountTriggerHandler.startsWith7(Trigger.new);
    }
}