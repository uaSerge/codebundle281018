({
	clickCreateItem : function(component, event, helper) {
        var validItem = component.find('itemform').reduce(function (validSoFar, inputCmp) {
            // Displays error messages for invalid fields
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        // If we pass error checking, do some real work
        if(validItem){
            // Create the new item
            var newItem = component.get("v.newItem");
            console.log("Create item: " + JSON.stringify(newItem));
            
            helper.createItem(component,newItem);
        }
    },
})