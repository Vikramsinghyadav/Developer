trigger LeadTrigger on Lead (before insert,before update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
    	LeadController.CheckCountryPhoneLength(Trigger.new);
        LeadController.domainName(Trigger.new);
        LeadController.appendZ(Trigger.new,Trigger.oldMap);
        LeadController.cannotContainA(Trigger.new,Trigger.oldMap);
        LeadController.statusUnqualified(Trigger.new,Trigger.oldMap);
    }
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
    	LeadController.createCampaignmember(Trigger.new);
    }
}