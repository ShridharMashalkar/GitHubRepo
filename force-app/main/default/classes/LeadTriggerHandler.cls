public class LeadTriggerHandler {
    public static void afterInsert(List<Lead__c> LeadList){
        
        if(LeadList.size()>0 && !LeadList.isEmpty()){
            LeadHelper.createTATRecord(LeadList);
        }
    }
    
    public static void afterUpdate(List<Lead__c> LeadList,Map<Id,Lead__c> LeadOldMap){
		List<Lead__c> LeadListTAT = new List<Lead__c>();
        Map<Id,Lead__c> LeadOldMapTAT = new Map<Id,Lead__c>();
		for(Lead__c leadObj:LeadList){
            if(leadObj.Stage__c != null && (LeadOldMap.get(leadObj.Id).Stage__c != leadObj.Stage__c)){
                LeadListTAT.add(leadObj);
                LeadOldMapTAT.put(leadObj.Id,LeadOldMap.get(leadObj.Id));
            }           
        }        
        if(LeadListTAT.size()>0 && !LeadListTAT.isEmpty()){
            LeadHelper.stageChangeTATRecord(LeadListTAT,LeadOldMapTAT);
        }
    }
}