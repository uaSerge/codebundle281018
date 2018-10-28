/**
 * Created by Serhii on 24.10.2018.
 */
({
    cancel: function (component, event, helper) {
        var item = component.get("v.item");
   //     item.set("v.item",[]);
        console.log("contr item :"+ item)
        helper.delItem(component, item);
    },
    changeSum: function (component, event, helper) {
        var item = component.get("v.item");
        helper.editItem(component, item);
    },
})