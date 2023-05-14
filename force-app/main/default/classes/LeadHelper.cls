public class LeadHelper {
	public static void createTATRecord(List<Lead__c> LeadList){
        List<Turn_Around_Time__c> TATList = new List<Turn_Around_Time__c>();
        for(Lead__c leadObj:LeadList){
            Turn_Around_Time__c curTAT = new Turn_Around_Time__c();
			curTAT.Lead__c = leadObj.Id;  
			curTAT.Start_Date__c = System.Now();
			curTAT.Current_Stage__c = 'New';
			TATList.add(curTAT);            
        }
        
        if(TATList.size()>0 && !TATList.isEmpty()){
            Database.insert(TATList,false);
        }
    }
}