trigger OrderEventTrigger on Order_Event__e (after insert) {
List<Task> taskes = new List<Task>();
    
    // Get myUser Id for task owner
    User myUser = [SELECT Id FROM User WHERE Name='Serhii Rudkov' LIMIT 1];
       
    // Iterate through each notification.
    for (Order_Event__e event : Trigger.New) {
        if (event.Has_Shipped__c == true) {
            // Create Case to dispatch new team.
            Task cs = new Task();
            cs.Priority = 'Medium';
            cs.Subject = 'Follow up on shipped order ' + event.Order_Number__c;
            cs.OwnerId = myUser.Id;
            taskes.add(cs);
        }
   }
    
    // Insert all cases corresponding to events received.
    insert taskes;
}