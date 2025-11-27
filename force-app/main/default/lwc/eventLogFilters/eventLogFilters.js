import { LightningElement, track } from 'lwc';
//import fetchEventLogs from '@salesforce/apex/EventLogFileBrowserController.fetchEventLogs';

export default class EventLogFilters extends LightningElement {

    @track selectedStartDate='';
    @track selectedEndDate='';

    handleStartChange(event){
        this.selectedStartDate = event.target.value;
        console.log('output start date:  ' + this.selectedStartDate);
    }
     handleEndChange(event){
         this.selectedEndDate = event.target.value;
         console.log('output end date : ' + this.selectedEndDate);
     }

}