public class LeadHelper {
	public static void createTATRecord(List<Lead__c> LeadList){
        List<Turn_Around_Time__c> TATList = new List<Turn_Around_Time__c>();
        for(Lead__c leadObj:LeadList){
            Turn_Around_Time__c curTAT = new Turn_Around_Time__c();
			curTAT.Lead__c = leadObj.Id;  
			curTAT.Start_Date__c = System.Now();
			curTAT.Current_Stage__c = 'New';
            curTAT.Unique_String__c = 'New'+'-'+leadObj.Id;
			TATList.add(curTAT);            
        }
        
        if(TATList.size()>0 && !TATList.isEmpty()){
            Database.insert(TATList,false);
        }
    }
    
    public static void stageChangeTATRecord(List<Lead__c> LeadList,Map<Id,Lead__c> LeadOldMap){
        List<Turn_Around_Time__c> TATList = new List<Turn_Around_Time__c>();
        Set<String> TATUpdateRecords = new Set<String>();
        for(Id leadId:LeadOldMap.keyset()){
            Lead__c oldLead = LeadOldMap.get(leadId);
            String curTATString = oldLead.Stage__c+'-'+leadId;
            TATUpdateRecords.add(curTATString);
        }
        List<Turn_Around_Time__c> updateTATList = new List<Turn_Around_Time__c>();
        updateTATList = [Select id,Unique_String__c,End_Date__c from Turn_Around_Time__c 
						 where Unique_String__c in:TATUpdateRecords];
        if(updateTATList.size()>0 && !updateTATList.isEmpty()){
            for(Turn_Around_Time__c currentTATRecord:updateTATList){
                currentTATRecord.End_Date__c = System.Now();
                TATList.add(currentTATRecord);
            }
        }
        Set<Id> leadIds = new Map<Id,Lead__c>(LeadOldMap).keyset();
        for(Lead__c leadObj:LeadList){
            Turn_Around_Time__c curTAT = new Turn_Around_Time__c();
			curTAT.Lead__c = leadObj.Id;  
			curTAT.Start_Date__c = System.Now();
			curTAT.Current_Stage__c = LeadObj.Stage__c;
            curTAT.Previous_Stage__c = LeadOldMap.get(leadObj.Id).Stage__c;
            curTAT.Unique_String__c = LeadObj.Stage__c+'-'+leadObj.Id;
			TATList.add(curTAT);            
        }
        
        if(TATList.size()>0 && !TATList.isEmpty()){
            Database.upsert(TATList,false);
        }
    }
}