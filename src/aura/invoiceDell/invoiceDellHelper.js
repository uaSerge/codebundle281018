({
    doInit2: function(component, category, variable){
        var action = component.get(category);

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set(variable, response.getReturnValue());
                console.log("Invoices: " + response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
})