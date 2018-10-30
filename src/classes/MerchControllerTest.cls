@isTest
public class MerchControllerTest {

    static void newMerch() {
        List<Merchandise__c> merchList = new List<Merchandise__c>(4);
        String[] categ = new String[4];
        categ[0] = 'Keyboards';
        categ[1] = 'Monitors';
        categ[2] = 'Mouses';
        categ[3] = 'Notebooks';
        for (Integer i = 0; i < merchList.size(); i++) {
            merchList[i] = new Merchandise__c(Name = 'TestMerch' + i, Category__c = categ[i], Quantity__c = i+1);
        }
        insert merchList;
    }

    @isTest static void TestGetMerchandises() {
        newMerch();
        Merchandise__c[] merchList = MerchController.getMerchandises();
        System.assert(!merchList.isEmpty());
    }


    @isTest static void TestGetNotes() {
        newMerch();
        Merchandise__c[] merchList = MerchController.getNotes();
        System.assertEquals(merchList.isEmpty(), false);
        System.assertEquals('Notebooks', merchList[0].Category__c);
    }

    @isTest static void TestgetMons() {
        newMerch();
        Merchandise__c[] merchList = MerchController.getMons();
        System.assertEquals(merchList.isEmpty(), false);
        System.assertEquals('Monitors', merchList[0].Category__c);
    }

    @isTest static void TestgetKes() {
        newMerch();
        Merchandise__c[] merchList = MerchController.getKes();
        System.assertEquals(merchList.isEmpty(), false);
        System.assertEquals('Keyboards', merchList[0].Category__c);
    }

    @isTest static void TestgetMouses() {
        newMerch();
        Merchandise__c[] merchList = MerchController.getMouses();
        System.assertEquals(merchList.isEmpty(), false);
        System.assertEquals('Mouses', merchList[0].Category__c);
    }

    @isTest static void TestCreateInvoice() {
        newMerch();
        Merchandise__c[] merchList = MerchController.getMerchandises();
        MerchController.createInvoice(merchList);
        List<Invoice_Line_Item__c> ili = [SELECT Invoice__c, Merchandise__c, Quantity__c FROM Invoice_Line_Item__c ];
        for (Integer i = 0; i < 4; i++) {
            System.assertEquals(ili[i].Quantity__c, i + 1);
            System.assertEquals(ili[i].Merchandise__c, merchList[i].id);
        }
    }


}