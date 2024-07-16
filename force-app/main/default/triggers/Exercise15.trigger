trigger Exercise15 on User (after insert,after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        UserController.AddIntoQueue(Trigger.new);
    }
}