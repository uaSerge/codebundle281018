/**
 * Created by Serhii on 24.10.2018.
 */
({
    doInit: function (component, event, helper) {
        helper.doInit2(component, "c.getMerchandises", "v.merchs");
        var sumCartField = component.find("categoryName");
        sumCartField.set("v.value", " \'ALL\' ");
    },

    changeMerchNotes: function (component, event, helper) {
        helper.doInit2(component, "c.getNotes", "v.merchs");
        var sumCartField = component.find("categoryName");
        sumCartField.set("v.value", " \'Notebooks\' ");
    },
    changeMerchMons: function (component, event, helper) {
        helper.doInit2(component, "c.getMons", "v.merchs");
        var sumCartField = component.find("categoryName");
        sumCartField.set("v.value", " \'Monitors\' ");
    },
    changeMerchKes: function (component, event, helper) {
        helper.doInit2(component, "c.getKes", "v.merchs");
        var sumCartField = component.find("categoryName");
        sumCartField.set("v.value", " \'Keyboards\' ");
    },
    changeMerchMouses: function (component, event, helper) {
        helper.doInit2(component, "c.getMouses", "v.merchs");
        var sumCartField = component.find("categoryName");
        sumCartField.set("v.value", " \'Mouses\' ");
    },

    addCart: function (component, event, helper) {
        var newItem = event.getParam("item");
        console.log(newItem);
        var newItems = component.get("v.merchsBuy");
        console.log("Buy1 " + newItems);

        for (var i = 0; i < newItems.length; i++) {
            var obj = newItems[i];
            if (newItem["Id"] == obj["Id"]) {
                newItems.splice(i, 1);
                i--;
            }
        }
        newItems.push(newItem);
        component.set("v.merchsBuy", newItems);
        console.log("Buy1 " + newItems);
        var sum = helper.sumFunction(component);
        var sumCartField = component.find("sumCart");
        sumCartField.set("v.value", sum);
    },

    editCart: function (component, event, helper) {
        var sum = helper.sumFunction(component);
        var sumCartField = component.find("sumCart");
        sumCartField.set("v.value", sum);
    },

    dellCart: function (component, event, helper) {
        var delItem = event.getParam("item");

        console.log("dellCart " + JSON.stringify(delItem));

        var newItems = component.get("v.merchsBuy");

        console.log("Dell newItems" + newItems);
        console.log('delItem["id"] ' + delItem["Id"]);

        var removeIndex = newItems.map(function (item) {
            return item["Id"];
        }).indexOf(delItem["Id"]);
        newItems.splice(removeIndex, 1);

        console.log("removeIndex " + removeIndex);
        component.set("v.merchsBuy", newItems);
        var sum = helper.sumFunction(component);
        var sumCartField = component.find("sumCart");
        sumCartField.set("v.value", sum);
    },

    clear: function (component, event, helper) {
        var newItems = component.set("v.merchsBuy", []);
        var sum = helper.sumFunction(component);
        var sumCartField = component.find("sumCart");
        sumCartField.set("v.value", sum);
    },

    submit: function (component, event, helper) {
        var action = component.get("c.createInvoice");
        action.setParams({
            "merchandises": component.get("v.merchsBuy")
        });

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.merchsBuy", []);
                console.log("state: " + response.getState());
                var sum = helper.sumFunction(component);
                var sumCartField = component.find("sumCart");
                sumCartField.set("v.value", sum);
            }
            else {
                alert("Enter correct amount of products.");
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
})