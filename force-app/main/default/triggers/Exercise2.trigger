trigger Exercise2 on Lead (before insert,before update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
    	LeadController.DomainName(Trigger.new);
    }
}