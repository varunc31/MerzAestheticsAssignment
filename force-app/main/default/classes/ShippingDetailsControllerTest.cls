@isTest
private class ShippingDetailsControllerTest {
    @isTest
    static void testGetShippingStatusSuccess() {
        // Mock the HTTP response
        HttpCalloutMock mock = new MockHttpResponse();
        Test.setMock(HttpCalloutMock.class, mock);

        // Call the method to test
        ShippingDetailsController.ShippingStatusResponse response = ShippingDetailsController.getShippingStatus('123456789');

        // Verify the response
        System.assertEquals('Shipped', response.shippingStatus);
    }

    @isTest
    static void testGetShippingStatusError() {
        // Mock the HTTP response with error
        HttpCalloutMock mock = new MockHttpErrorResponse();
        Test.setMock(HttpCalloutMock.class, mock);

        // Call the method to test
        ShippingDetailsController.ShippingStatusResponse response = ShippingDetailsController.getShippingStatus('123456789');

        // Verify the error response
        System.assertEquals('API_ERROR', response.errorCode);
        System.assertNotEquals(null, response.errorMessage);
    }

    // Inner classes to mock HTTP responses
    private class MockHttpResponse implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatus('OK');
            res.setStatusCode(200);
            res.setBody('{"shippingStatus":"Shipped"}');
            return res;
        }
    }

    private class MockHttpErrorResponse implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatus('Internal Server Error');
            res.setStatusCode(500);
            res.setBody('{"error":"An error occurred"}');
            return res;
        }
    }
}