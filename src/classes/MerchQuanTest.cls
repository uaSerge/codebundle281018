@isTest
public class MerchQuanTest {
    @isTest static void quantityDecreased() {
        Merchandise__c merch = new Merchandise__c (Category__c = 'Mouses', Name = 'TestMerch', Quantity__c = 20);
        insert merch;
        // Perform test
        Test.startTest();
        merch.Quantity__c -= 19;
        update merch;
        Test.stopTest();
        // Verify
        merch = [SELECT Quantity__c FROM Merchandise__c WHERE Name='TestMerch' LIMIT 1];
        System.assertEquals(6, merch.Quantity__c);
    }

}