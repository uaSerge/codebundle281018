trigger MerchQuan on Merchandise__c (after update) {
    List<Merchandise__c> merchList = new List<Merchandise__c>();

    for (Merchandise__c merch : [SELECT Id, Quantity__c FROM Merchandise__c WHERE Id IN:Trigger.New]) {
        if (merch.Quantity__c < 3) {
            merch.Quantity__c += 5;
            merchList.add(merch);
        }
        if (merchList.size() > 0) {
            update merchList;
            Email email = new Email();
            String body = 'Delivery of 5 item of each required merchandise success';
            email.sendMail('uaserge2@gmail.com', 'Delivery', body);
        }
    }
}