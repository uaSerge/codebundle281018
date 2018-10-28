@isTest
public class MerchControllerTest {
    @isTest
    static void newMerch(){
        List<Merchandise__c> merchList = new List<Merchandise__c>(4);
        String[] categ = new String[4]; 
        categ[0]='Keyboards';
        categ[0]='Monitors';
        categ[0]='Mouses';
        categ[0]='Notebooks';
        for (Integer i=0; i<4; i++){
            merchList[i] = new Merchandise__c(Category__c=categ[i], Name ='TestMerch'+i);
        }
        System.debug(merchList[0].Category__c);
       // insert merchList;
    }
    
    @isTest static void TestGetMerchandises() {
        newMerch();
        Merchandise__c[] merchList = MerchController.getMerchandises();
        System.debug(merchList.isEmpty());        
    }
    
    
    @isTest static void TestGetNotes() {
        
        Merchandise__c[] merchList = MerchController.getMerchandises();
        System.debug(merchList[0]);
        //System.assertEquals(merchList.isEmpty(),false);         
     }
}