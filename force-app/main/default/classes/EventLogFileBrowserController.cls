/**
 * @author - Gokul
 * this class is responsible for fetching the logs
 */

public with sharing class EventLogFileBrowserController {
    
    public static List<EventLogFile> fetchEventLogs(Datetime startDate, Datetime endDate, String eventType, String interval){
      
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