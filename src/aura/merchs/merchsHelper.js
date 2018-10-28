/**
 * Created by Serhii on 24.10.2018.
 */
({
    doInit2: function(component, category, variable){
        var action = component.get(category);

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set(variable, response.getReturnValue());
                console.log("Merchandises: " + response.getReturnValue());
                var sum = this.sumFunctionQuantity(component);
                var sumCartField = component.find("sumQuantity");
                sumCartField.set("v.value",sum);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },

    sumFunction: function (component, event) {
        var newItems = component.get("v.merchsBuy");
        //     var sum = newItems.reduce(function(p,c){return p["Price__c"]+c["Price__c"];});

        var sum = 0;
        for (var i = 0; i < newItems.length;  i++) {
            sum += newItems[i]["Price__c"] * newItems[i]["Quantity__c"];
        }
        console.log("SUM = " + sum)
        return sum;
    },

    sumFunctionQuantity: function (component) {
        var newItems = component.get("v.merchs");
        //     var sum = newItems.reduce(function(p,c){return p["Price__c"]+c["Price__c"];});

        var sum = 0;
        for (var i = 0; i < newItems.length;  i++) {
            sum += newItems[i]["Quantity__c"];
        }
        console.log("SUM = " + sum)
        return sum;
    },
})