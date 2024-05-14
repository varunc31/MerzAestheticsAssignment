// shipmentStatusDisplay.js
import { LightningElement, track } from 'lwc';
import getShippingStatus from '@salesforce/apex/ShippingDetailsController.getShippingStatus';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class ShipmentStatusDisplay extends LightningElement {
    @track trackingNumber;
    @track shipmentStatus;

    handleTrackingNumberChange(event) {
        this.trackingNumber = event.target.value;
    }

    handleSubmit() {
        this.getShipmentStatus();
    }

    getShipmentStatus() {
        getShippingStatus({ trackingNumber: this.trackingNumber })
            .then(result => {
                if(result.errorCode == null) {
                    this.shipmentStatus = result.shippingStatus;
                } else {
                    this.showNotification('Error !', result.errorMessage, 'error');
                }
            })
            .catch(error => {
                this.showNotification('Error !', Json.stringify(error.message), 'error');
            });
    }

    showNotification(titleText, messageText, variant) {
        const evt = new ShowToastEvent({
          title: titleText,
          message: messageText,
          variant: variant,
        });
        this.dispatchEvent(evt);
    }
}
