import { LightningElement, track, wire } from 'lwc';
import getEventTypes from  '@salesforce/apex/EventLogFileBrowserController.getEventTypes';
import fetchEventLogs from '@salesforce/apex/EventLogFileBrowserController.fetchEventLogs';

export default class EventLogFilters extends LightningElement {

    eventOptions =[];
    intervalOptions = [
        {label : 'All', value: 'All'},
        {label : 'Daily', value: 'Daily'},
        {label : 'Hourly', value: 'Hourly'}
    ];

    selectedEventType ='';
    selectedInterval = '';
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
      
    handleEventTypeChange(event){
        this.selectedEventType = event.target.value;
        console.log('Selected the Event type : ' + this.selectedEventType);
     }
     handleIntervalChange(event){
        this.selectedInterval = event.target.value;
        console.log("Selected the Interval: " + this.selectedInterval);
     }


     fetchLogs(){
        fetchEventLogs({
            startDate: this.selectedStartDate ? new Date(this.selectedStartDate).toISOString : null ,
            endDate: this.selectedEndDate ? new Date(this.selectedEndDate).toISOString : null ,
            eventType: this.selectedEventType, 
            interval: this.selectedInterval
        }).then(result => {
            console.log('all: ' + result);
        }).catch(error => {
            console.error(error);
        })
     }


    
     @wire(getEventTypes)
     wiredEventTypes({data, error}){
        if(data){
            this.eventOptions = data.map(item => ({
                label:item.EventType,
                value: item.EventType
            }));
        } else if(error){
            console.error(error);
        }
     }

   
}