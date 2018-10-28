/**
 * Created by Serhii on 25.10.2018.
 */
({
    delItem: function (component, item) {
        var createEvent = component.getEvent("dellItemCart");
        createEvent.setParams({"item": item});
        console.log("item helper :"+ item)
        createEvent.fire();
    },
    editItem: function (component, item) {
        var createEvent = component.getEvent("editItemCart");
        createEvent.setParams({"item": item});
        createEvent.fire();
    },
})