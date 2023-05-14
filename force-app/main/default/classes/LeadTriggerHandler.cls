public class LeadTriggerHandler {
    public static void afterInsert(List<Lead__c> LeadList){
        
        if(LeadList.size()>0 && !LeadList.isEmpty()){
            LeadHelper.createTATRecord(LeadList);
        }
    }
}