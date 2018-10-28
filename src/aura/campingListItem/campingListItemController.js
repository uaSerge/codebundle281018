({
	packItem : function(component, event, helper) {
		var btnClicked = event.getSource();         // the button
        btnClicked.set("v.disabled", true);
        component.set("v.item.Packed__c", true);     // update our message
	
    }
})