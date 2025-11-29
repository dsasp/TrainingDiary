//
//  Logging.swift
//  TrainingDiary
//
//  Created by Dieter on 29.11.25.
//

import Foundation

// common subsystem name for logging
let logSubSystem = "TDiary"

/*
 
 Logging conventions:
 
 Filename as log category:

    // suitable for most scenarios
    //   put line below after import statements in swift file (outside of any view/func)
    //   logger consts 'xxLog' must use unique names
 
    let xxLog = Logger(subsystem: logSubSystem,category: fileNameOf(#file))
 
      2023-01-10 08:16:49.413392+0100 ProjectName[16726:567078] [MyView] log entry looks like this
 
 Function name as log category:
 
    // used if function name should be visible in log
    //   put line below at beginning of function
 
    let log = Logger(subsystem: logSubSystem,category: #function)
 
      2023-01-10 08:16:49.413455+0100 ProjectName[16726:567078] [myFunc()] this is a log entry

 
  Log levels used:
 
    Debug    // development
    Notice   // production, logs - support debugging if needed
    Error    // production, error - app can recover and continue to run
    Fault    // production, critical unrecoverable issue - app needs to terminate
 
  Retrieve logs from iPhone:
 
    - attach iPhone to Mac via cable
    - sudo log collect --device-name "iPhone Dieter" --last 1h --output mylogarchive1.logarchive
    - sudo log collect --device-name "iPhone Dieter" --start '2023-04-02 16:00:00' --output mylogarchive2.logarchive
    - double-click on logarchive, console.app will open
    - enter search criteria, e.g. 'e3ds' as subsystem
 
*/


/// Extracts filename of swift #file literal passed as input. Used to set log category.
/// - Parameter file: swift #file literal
/// - Returns: filename extracted from input, or empty string if parsing failed
func fileNameOf(_ file: String) -> String {
    let pathc = file.components(separatedBy: "/")
    if let nameext = pathc.last {
        let fnc = nameext.components(separatedBy: ".")
        if let filename = fnc.first {
            return filename
        }
        return nameext
    }
    return ""
}
