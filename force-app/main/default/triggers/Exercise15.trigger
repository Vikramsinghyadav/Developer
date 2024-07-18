trigger UserTrigger on User (after insert,after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        UserController.addIntoQueue(Trigger.new);
    }
}