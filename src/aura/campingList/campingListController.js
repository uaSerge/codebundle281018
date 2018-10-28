({
    doInit: function(component, event, helper) {
        // Create the action
        var action = component.get("c.getItems");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.items", response.getReturnValue());
                console.log("OK, " + response.getReturnValue());
                console.log("v.items "+ component.get("v.items"));
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    
    handleAddItem : function(component, event, helper) {
    var newItem = event.getParam("item");
        helper.createItem(component, newItem);
    },
    
})