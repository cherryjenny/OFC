trigger TotalOpptyAmountTrigger on Opportunity (after insert, after update, after delete, after undelete) {
    if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete)) {
        TotalOpptyAmountTriggerHandler.handleTrigger(Trigger.new, Trigger.oldMap, Trigger.isInsert, Trigger.isUpdate, Trigger.isDelete, Trigger.isUndelete);
    }
}
