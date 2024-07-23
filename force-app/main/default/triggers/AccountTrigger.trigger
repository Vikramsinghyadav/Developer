trigger AccountTrigger on Account (before insert,before update,after insert,after update) {
     if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
    	AccountHandler.startsWith5(Trigger.new);
    }
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
    	AccountHandler.startsWith7(Trigger.new);
    }
}