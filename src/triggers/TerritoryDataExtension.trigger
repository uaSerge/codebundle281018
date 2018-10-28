/**
 * Created by Serhii on 08.10.2018.
 */

trigger TerritoryDataExtension on Account (after insert, after update, after delete, after undelete) {


    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            ActivityDataHandler.onAfterInsertDelUndel(Trigger.new);
        }
        if (Trigger.isUpdate) {
//            ActivityDataHandler.onAfterUpdate(Trigger.new, Trigger.oldMap);
            ActivityDataHandler.onAfterUpdate(Trigger.new,Trigger.oldMap);
        }
        if (Trigger.isDelete) {
//            ActivityDataHandler.onAfterDelete(Trigger.old);
            ActivityDataHandler.onAfterInsertDelUndel(Trigger.old);
        }
        if (Trigger.isUndelete) {
//            ActivityDataHandler.onAfterUndelete(Trigger.new);
            ActivityDataHandler.onAfterInsertDelUndel(Trigger.new);
        }
    }
}