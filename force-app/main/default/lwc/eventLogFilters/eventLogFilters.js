import { LightningElement, track, wire } from 'lwc';
import getEventTypes from  '@salesforce/apex/EventLogFileBrowserController.getEventTypes';

export default class EventLogFilters extends LightningElement {

    options =[];
    selectedEventType ='';
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
    
     @wire(getEventTypes)
     wiredEventTypes({data, error}){
        if(data){
            this.options = data.map(item => ({
                label:item.EventType,
                value: item.EventType
            }));
        } else if(error){
            console.error(error);
        }
     }

     handleEventTypeChange(event){
        this.selectedEventType = event.target.value;
        console.log('Selected the Event type : ' + this.selectedEventType);
     }
}