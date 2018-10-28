/**
 * Created by Serhii on 24.10.2018.
 */
({
    toCart: function (component, event, helper) {
        var newQuan = component.find("quantityBuy");
        console.log("v.quantityBuy " + newQuan.get("v.value"));
        var newItem = component.get("v.item");
        if ((newQuan.get("v.value") >= 1) && (newQuan.get("v.value") <= newItem["Quantity__c"])) {
            var newQuanValue = newQuan.get("v.value");
            newItem["Quantity__c"] = newQuanValue;
            console.log("Create item: " + JSON.stringify(newItem));
            helper.createItem(component, newItem);
        } else alert("Enter correct amount of products.");

    },
})