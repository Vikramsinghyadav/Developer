trigger LeadTrigger on Lead (before insert,before update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
    	LeadController.country(Trigger.new);
        LeadController.domainName(Trigger.new);
        LeadController.appendZ(Trigger.new);
        LeadController.cannotContainA(Trigger.new);
        LeadController.statusUnqualified(Trigger.new);
    }
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
    	LeadController.createCampaignmember(Trigger.new);
    }
}