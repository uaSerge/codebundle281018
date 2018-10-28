({
    createItem: function(component, item) {
        var createEvent = component.getEvent("addItem");
        createEvent.setParams({ "item": item });
        createEvent.fire();
        component.set("v.newItem",{'sobjectType':'Camping_Item__c',
                'Name': '',
                'Quantity__c': 0,
                'Price__c': 0,
                'Packed__c': false});
    },
    
/*	createItem: function(component, item) {
        var action = component.get("c.saveItem");
        console.log('helper ' + item);
        action.setParams({
            "item": item
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var items = component.get("v.items");
                items.push(response.getReturnValue());
                component.set("v.items", items);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },*/
})