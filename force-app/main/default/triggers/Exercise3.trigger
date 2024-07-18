trigger Exercise3 on Lead (before insert,before update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        LeadController.appendZ(Trigger.new);
    }
}