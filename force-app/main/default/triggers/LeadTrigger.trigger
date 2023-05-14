trigger LeadTrigger on Lead__c (after insert,after update) {
	switch on Trigger.operationType {
        
            when AFTER_INSERT {
                LeadTriggerHandler.afterInsert(Trigger.New);
                //create related records
            }
            when AFTER_UPDATE {
                LeadTriggerHandler.afterUpdate(Trigger.New,Trigger.oldMap);
                //set value on record create
            }
            when else {
                //do nothing for AFTER_UNDELETE, BEFORE_DELETE, or BEFORE_UPDATE
            }
        }
}