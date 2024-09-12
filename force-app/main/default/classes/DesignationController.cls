public with sharing class DesignationController {
    @AuraEnabled(cacheable=true)
    public static Id getParent(Id recordid){
        List<Designation__c> desList = [SELECT Contact__c FROM Designation__c WHERE Id = :recordid LIMIT 1];
        Id contactId=desList[0].Contact__c;
        return contactId;
    }

    @AuraEnabled(cacheable=true)
    public static List<MyWrapperClass> getContribution(Id recordid){

        Map<Integer,List<Contribution__c>> conMapWithYear = new Map<Integer,List<Contribution__c>>();

        List<Contribution__c> conList = [SELECT id,name,Date__c FROM Contribution__c WHERE Contact__c = :recordid ];

        List<String> conIds=new List<String>();

        for(Contribution__c con:conList){
            Integer yearValue = con.Date__c.year();
            if(conMapWithYear.containsKey(yearValue)){
                conMapWithYear.get(yearValue).add(con);
                
            }else{
                conMapWithYear.put(yearValue,new List<Contribution__c>{con});
            }
        }
        List<MyWrapperClass> wrapperList = new List<MyWrapperClass>();

        for(Integer i:conMapWithYear.keySet()){

            MyWrapperClass obj = new MyWrapperClass();
            obj.year = ''+i+'('+conMapWithYear.get(i).size()+')';
            obj.contributions = conMapWithYear.get(i);
            wrapperList.add(obj);
        }
        return wrapperList;
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsFromDesignation(Id recordId) {
        // Query to get the Contact__c field from the Designation__c record
        List<Designation__c> desList = [SELECT Contact__c FROM Designation__c WHERE Id = :recordId LIMIT 1];
        
        if (desList != null && !desList.isEmpty()) {
            // Extract Contact__c Id from the Designation__c record
            Id contactId = desList[0].Contact__c;
            
            // Query to get Contact records based on Contact__c Id
            List<Contact> contactList = [SELECT Feedback_Rating_Count__c, MVP_Count__c, No_Dreamforce_Attended__c, Nomination_Count__c FROM Contact WHERE Id = :contactId];
            
            
            return contactList;
        } else {
            return new List<Contact>();
        }
    }
    class MyWrapperClass {
        @auraEnabled
        public String year { get; set; }
        @auraEnabled
        public List<Contribution__c> Contributions { get; set; }
    }
    //Aura methods
    @AuraEnabled(cacheable=true)
    public static Decimal getContactData( String recordid) {
        Designation__c des=[select id,Contact__c from Designation__c where id = :recordid LIMIT 1];
        Contact con=[select Feedback_Rating_Count__c from Contact where id=:des.contact__c LIMIT 1];
        Decimal rating=con.Feedback_Rating_Count__c;
        return rating;
    }
    @AuraEnabled(cacheable=true)
    public static List<String> getFieldSet(String objectName, String fieldSetName) {

        List<String> fieldList = new List<String>();
        Schema.FieldSet fieldSetObj = Schema.getGlobalDescribe().get(objectName).getDescribe().fieldSets.getMap().get(fieldSetName);
        
        if (fieldSetObj != null) {

            for (Schema.FieldSetMember f : fieldSetObj.getFields()) {
                fieldList.add(f.getFieldPath());
            }
        }
        return fieldList;
    }
}