({
    doInit: function (component, event, helper) {
        helper.doInit2(component, "c.getInvs", "v.invs");
    },
    all: function (component, event, helper) {
        helper.doInit2(component, "c.getInvs", "v.invs");
    },

    dell: function (component, event, helper) {
        var action = component.get("c.delAll");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("All invoice are deleated.");
                $A.get("e.force:navigateToURL").setParams({
                    "url": "https://codebundle3-dev-ed.lightning.force.com/lightning/o/Invoice__c/home"
                }).fire();
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);

    },
})