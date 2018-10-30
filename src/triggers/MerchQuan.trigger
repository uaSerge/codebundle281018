trigger MerchQuan on Merchandise__c (after update) {
    List<Merchandise__c> merchList = new List<Merchandise__c>();

    for (Merchandise__c merch : [SELECT Id, Quantity__c, Name, Category__c  FROM Merchandise__c WHERE Id IN:Trigger.New]) {
        if (merch.Quantity__c < 3) {
            merch.Quantity__c += 5;
            merchList.add(merch);
        }
    }
    if (merchList.size() > 0) {
        update merchList;
        Email email = new Email();
        String merchDelivered = '';
        for (Merchandise__c merch : merchList){
            merchDelivered += merch.Name + ' ('+ merch.Category__c + '); ';
        }
        String body = 'Delivered 5 item of ' + merchDelivered;
        email.sendMail(UserInfo.getUserEmail(), 'Delivery', body);
    }
}
