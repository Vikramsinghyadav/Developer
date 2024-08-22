trigger LeadTrigger on Lead (before insert,before update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
    	LeadTriggerHandler.CheckCountryPhoneLength(Trigger.new);
        LeadTriggerHandler.domainName(Trigger.new);
        LeadTriggerHandler.appendZ(Trigger.new,Trigger.oldMap);
        LeadTriggerHandler.cannotContainA(Trigger.new,Trigger.oldMap);
        LeadTriggerHandler.statusUnqualified(Trigger.new,Trigger.oldMap);
    }
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
    	LeadTriggerHandler.createCampaignmember(Trigger.new);
    }
}