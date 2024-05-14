# Shipment Status Component

This Lightning Web Component (LWC) provides a simple interface to check the status of a shipment using a tracking number.

## Features
- Input field to enter the tracking number.
- Button to trigger the status retrieval.
- Display of the shipment status once retrieved.

## Usage
1. Place the `shipmentStatus` component in Lightning App Builder page.
2. Enter the tracking number of the shipment in the provided input field.
3. Click on the "Get Status" button to retrieve the shipment status.

## Apex Class
The `ShippingDetailsController` Apex class handles the backend logic for retrieving the shipment status. The `getShippingStatus` method sends a GET request to an external API endpoint to retrieve the shipment status based on the provided tracking number. It returns a ShippingStatusResponse object containing the status, error code, and error message.