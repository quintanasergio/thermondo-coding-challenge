# Salesforce Senior Coding Challenge
### Sergio Quintana

I created an Invocable Apex action NPSIntegration that sends Order data to the NPS endpoint when called by a Flow which I also created and added here. This Flow runs the Apex code when an Order record is updated and its Status changes to "Fulfilled". I also created a test class for NPSIntegration that uses a HttpCalloutMock class MockHttpResponseGenerator to test the callout. Lastly I added the remote site settings for the endpoint needed to send request to NPS.

About my concerns/Limitations, I'm not taking into account any failures from the endpoint. 

I am also not taking into account the validity of the Order data that is being sent. For example what would happen if the Order doesn't have a BillToContact, and therefore no email to send the bill.

If these were addressed I would also need to add more test for these cases.
