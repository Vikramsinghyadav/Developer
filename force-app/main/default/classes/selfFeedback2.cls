public class selfFeedback2 {
	 @AuraEnabled(cacheable=true)
    public static List<MyWrapperClass> getRecordFeedback(String recordTypeName){
        List<RecordType> recTypeList = [SELECT Id, DeveloperName FROM RecordType WHERE SObjectType = 'Feedback__c' AND DeveloperName = :recordTypeName
        ];
        List<Feedback__c> FeedbackList=new List<Feedback__c>();
        Map<Integer,List<Feedback__c>> conMapWithYear = new Map<Integer,List<Feedback__c>>();

        FeedbackList=[select id,Date__c,Nominator__c,Nominator__r.Email,Generosity__c,Leadership__c,Expertise__c,Advocacy__c,Name,RecordTypeId from Feedback__c where RecordTypeId = :recTypeList[0].Id];
        
        for(Feedback__c con:FeedbackList){
            Integer yearValue = con.Date__c?.year();
            if(conMapWithYear.containsKey(yearValue)){
                List<Feedback__c> conList2 = conMapWithYear.get(yearValue);
                conList2.add(con);
                conMapWithYear.put(yearValue,conList2);
                
            }else{
                List<Feedback__c> conList2 = new List<Feedback__c>();
                conList2.add(con);
                conMapWithYear.put(yearValue,conList2);
            }
        }
         List<MyWrapperClass> wrapperList = new List<MyWrapperClass>();
        for(Integer i:conMapWithYear.keySet()){
            MyWrapperClass obj = new MyWrapperClass();
            obj.year = ''+i+'('+conMapWithYear.get(i).size()+')';
            obj.Feedback = conMapWithYear.get(i);
            wrapperList.add(obj);
        }
        return wrapperList;
    }
    class MyWrapperClass {
        @auraEnabled
        public String year { get; set; }
        @auraEnabled
        public List<Feedback__c> Feedback { get; set; }
    }
     @AuraEnabled(cacheable=true)
    public static List<String> getFieldSetFields(String objectName, String fieldSetName) {
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