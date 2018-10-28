/**
 * Created by Serhii on 24.10.2018.
 */
({
    createItem: function (component, item) {
        var createEvent = component.getEvent("addItemCart");
        createEvent.setParams({"item": item});
        createEvent.fire();
    },
})