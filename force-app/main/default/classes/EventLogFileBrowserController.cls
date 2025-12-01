/**
 * @author - Gokul
 * this class is responsible for fetching the logs
 */

public with sharing class EventLogFileBrowserController {

    /**
     * @author Gokul
     * @description - this will fetch all the events logs filter by start date, end date and eventtype
     */
    @AuraEnabled
    public static List<EventLogFile> fetchEventLogs(Datetime startDate, Datetime endDate, String eventType, String interval){

       if(startDate != null){
           Date sd = startDate.date();
           startDate = Datetime.newInstanceGmt(sd.year(), sd.month(), sd.day(), 0,0,0);
       } 
       if(endDate != null){
           Date ed = endDate.date();
           endDate = Datetime.newInstanceGmt(ed.year(), ed.month(), ed.day(), 23, 59,59);
       }
      
        String basequery =  'SELECT Id, LogFile, EventType, CreatedDate, LogDate' +
                             ' FROM EventLogFile WHERE EventType = :eventType' +
                             ' AND LogDate >= :startDate AND LogDate <= :endDate' ;

         if(interval == 'All'){
            basequery += ' AND Interval In (\'Daily\', \'Hourly\')';
         }                    
         if(interval == 'Daily'){
            basequery += ' AND Interval = \'Daily\'';
         }
         if(interval == 'Hourly'){
            basequery += ' AND Interval = \'Hourly\'';
         }

         return Database.query(basequery);
    }

    /**
     * @description this method is use to pass the list of event type to the picklist
     */
    @AuraEnabled(cacheable=true)
    public static List<EventLogFile> getEventTypes(){
      List<EventLogFile> eventTypes = [Select EventType From EventLogFile];
        return eventTypes;
    }

    

        
}

/*SELECT Id, LogFile, EventType, CreatedDate, LogDate
FROM EventLogFile
WHERE EventType =:interval
AND LogDate >=:startDate
AND LogDate <=:endDate AND Interval In ('Daily', 'Hourly') */


//SELECT Id, LogFile, EventType, CreatedDate, LogDate FROM EventLogFile Where EventType = 'Login'

//to get the log file under the csv
/**
 * EventLogFile elf = [
    SELECT Id, LogFile, EventType, LogDate
    FROM EventLogFile
    WHERE Id = '0ATWU00000DqMn04AF'
];

Blob csvBlob = elf.LogFile;
String csvString = csvBlob.toString();

System.debug(csvString);

 */