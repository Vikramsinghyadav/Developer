public with sharing class FieldSetController {
    @AuraEnabled(cacheable=true)
    public static List<String> getFieldSetFields(String objectName, String fieldSetName) {
        System.debug('object '+objectName);
        List<String> fieldList = new List<String>();
        Schema.FieldSet fieldSetObj = Schema.getGlobalDescribe().get(objectName).getDescribe().fieldSets.getMap().get(fieldSetName);
        
        if (fieldSetObj != null) {
            for (Schema.FieldSetMember f : fieldSetObj.getFields()) {
                fieldList.add(f.getFieldPath());
            }
        }
        System.debug(fieldList);
        return fieldList;
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getFieldSetData( String fieldSetName) {
        return [select Feedback_Rating_Count__c from Contact where Feedback_Rating_Count__c != 0];
    }
    
}