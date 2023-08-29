public class NPSIntegration {
    @InvocableMethod(label='Send fulfilled orders to NPS'
                     description='Sends fulfilled orders to external system'
                     category='Order')
    public static void sendOrderBill(List<Id> orderIds) {

        List<Order> orders = [SELECT Id, BillToContact.Email, OrderNumber, Description FROM Order WHERE Id IN :orderIds];
        List<OrderData> orderData = new List<OrderData>();

        for(Order o : orders){
            orderData.add(new OrderData(o.Id, o.OrderNumber, o.BillToContact.Email));
        }
        
        //System.debug(orderData);
        //System.debug(JSON.serialize(orderData));
        String url = 'https://salesforce-coding-challenge.herokuapp.com/orders';
        String username = 'tmondo';
        String password = 'Noy84LRpYvMZuETB';
        //TO DO: Handle credentials apropiately
                
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('POST');

        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        req.setHeader('Content-Type', 'application/json');
        req.setBody(JSON.serialize(orderData));
    
        HttpResponse res = h.send(req);
        //System.debug(res.getStatusCode());
        //System.debug(res.getBody());
        //TO DO: handle errors
        
    }
    class OrderData {
        private String sfId;
        private String orderNumber;
        private String customerEmail;

        public OrderData(String sfId, String orderNumber, String customerEmail){
            this.sfId = sfId;
            this.orderNumber = orderNumber;
            this.customerEmail = customerEmail;
        }
    }
}