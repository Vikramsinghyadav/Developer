public class MVPNomineeBasicInfo2 {
    @AuraEnabled(cacheable=true)
    public static List<String> getFieldSet(String objectName, String fieldSetName) {
        System.debug('object '+objectName);
        List<String> fieldList = new List<String>();
        Schema.FieldSet fieldSetObj = Schema.getGlobalDescribe().get(objectName).getDescribe().fieldSets.getMap().get(fieldSetName);
        
        if (fieldSetObj != null) {
            for (Schema.FieldSetMember f : fieldSetObj.getFields()) {
                fieldList.add(f.getFieldPath());
            }
        }
        System.debug('aura fieldssets '+fieldList);
        return fieldList;
    }
    @AuraEnabled(cacheable=true)
    public static String getParent(String recordid) {
        System.debug('recordid Of AURA component '+recordid);
         List<Designation__c> desList = [SELECT Contact__c FROM Designation__c WHERE Id = :recordid LIMIT 1];
        Id contactId=desList[0].Contact__c;
        System.debug('contactId of AURA '+contactId);
        return contactId;
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getFieldSetData() {
        System.debug('fieldSetName data method call ');
        List<Contact> conlist=[select Feedback_Rating_Count__c from Contact where Feedback_Rating_Count__c != 0];
        System.debug('conlist '+conlist);
        return conlist;
    }
}