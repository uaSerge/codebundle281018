/**
 * Created by Serhii on 24.10.2018.
 */
({

    doInit: function (component, event, helper) {
        var item = component.get("v.item");
        var quantityReal = component.find("quantityReal");
        var quantityRealNew = item["Quantity__c"]
        quantityReal.set("v.value", quantityRealNew);
    },

    toCart: function (component, event, helper) {
        var newQuan = component.find("quantityBuy");
        console.log("v.quantityBuy " + newQuan.get("v.value"));
        var newItem = component.get("v.item");
        var quantityReal_2 = component.find("quantityReal").get("v.value");
        if ((newQuan.get("v.value") >= 1) && (newQuan.get("v.value") <= quantityReal_2)) {
            var newQuanValue = newQuan.get("v.value");
            newItem["Quantity__c"] = newQuanValue;
            console.log("Create item: " + JSON.stringify(newItem));
            helper.createItem(component, newItem);
        } else alert("Enter correct amount of products.");
    },
})