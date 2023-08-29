@isTest
public class NPSIntegrationTest {
    @isTest static void testSendOrderBill() {

        //Test Data:
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact', Email = 'test@example.com', AccountId = testAccount.Id);
        insert testContact;
        Product2 testProduct = new Product2(Name = 'TestProd');
        insert testProduct;
        Order testOrder = new Order(AccountId = testAccount.Id, BillToContactId = testContact.Id, EffectiveDate = Date.today(), Status='Draft', Pricebook2Id=Test.getStandardPricebookId());
        insert testOrder;
        PricebookEntry testPBE = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(), Product2Id = testProduct.Id, UnitPrice = 123, IsActive = true);        
        insert testPBE;
        OrderItem testOrderItem = new OrderItem(OrderId = testOrder.Id, PricebookEntryId = testPBE.Id, UnitPrice = 123, Quantity = 2);
   		insert testOrderItem;
        
        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        testOrder.Status = 'Fulfilled';
        NPSIntegration.sendOrderBill(new List<Id>{testOrder.Id});

        Test.stopTest();
    }
    //TO DO: After handling negative responses create also tests for them
}