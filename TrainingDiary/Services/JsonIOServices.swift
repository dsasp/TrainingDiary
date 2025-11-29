//
//  JsonIOServices.swift
//  TrainingDiary
//
//  Created by Dieter on 29.11.25.
//

import Foundation
import Combine
import os

// Logger instance for this file
let jsonIOLog = Logger(subsystem: logSubSystem,category: fileNameOf(#file))

/// Load instance of generic type T from JSON file in main bundle (DEPRECATED, use loadSave() instead)
///  Data loaded using this func is critical for app to work.  Stop app with fatal error if load fails!!!
///
///  Type T must conform to Encodable protocol and match JSON file content structure.
/// - Parameter filename: JSON file
/// - Returns: instance of T, fatal error on failure
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    jsonIOLog.notice("load(): -> try loading \(filename,privacy: .public) as \(T.self,privacy: .public)")
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        jsonIOLog.fault("load(): Error, file \(filename,privacy: .public) not found in main bundle.")
        fatalError("Error, file \(filename) not found in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        jsonIOLog.fault("load(): Error loading \(filename,privacy: .public) from main bundle:\n\(error,privacy: .public)")
        fatalError("Error loading \(filename) from main bundle:\n\(error)")
    }

    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        jsonIOLog.error("load(): Error parsing \(filename) as \(T.self):\(error)")
        fatalError("Error parsing \(filename) as \(T.self):\n\(error)")
    }
}


/// Load instance of generic type T from JSON file in main bundle.
///  Data loaded using this func is critical for app to work.
///
///  Type T must conform to Encodable protocol and match JSON file content structure.
/// - Parameter filename: JSON file
/// - Returns: instance of T, nil on failure
func loadSave<T: Decodable>(_ filename: String) -> T? {
    var data: Data

    jsonIOLog.notice("loadSave(): -> try loading \(filename,privacy: .public) as \(T.self,privacy: .public)")
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        jsonIOLog.error("loadSave(): <- error, file \(filename,privacy: .public) not found in main bundle.")
        return nil
    }
    
    do {
        data = try Data(contentsOf: file)
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        jsonIOLog.error("loadSave(): <- Error parsing \(filename) as \(T.self):\(error)")
    }

    return nil
}



/// Load instance of generic type T from JSON file specified by URL.
///  Type T must conform to Decodable protocol and match JSON file's content structure.
///
///  Func returns nil on failure (file does not exist, decoding failure,...). Ensure to handle nil when using func.
/// - Parameter url: JSON file URL
/// - Returns: instance of T on success, nil otherwise
func loadFromURL<T: Decodable>(_ url: URL) -> T? {
    var data: Data
    var t: T
    let filename = url.lastPathComponent

    jsonIOLog.notice("loadFromURL(): -> try loading \(String(describing:url),privacy: .private(mask: .hash)) as \(T.self,privacy: .public)")

    do {
        data = try Data(contentsOf: url)
    } catch {
        jsonIOLog.error("loadFromURL(): <- nil, Error loading \(filename,privacy: .public) as \(T.self),failure loading data: \(error,privacy: .public)")
        return nil
    }
    
    do {
        t = try JSONDecoder().decode(T.self, from: data)
    } catch {
        jsonIOLog.error("loadFromURL(): <- nil, Error parsing \(filename,privacy: .public) as \(T.self,privacy: .public): \(error,privacy: .public)")
        return nil
    }
    
    jsonIOLog.notice("loadFromURL(): <- successfully loaded \(filename,privacy: .public) as \(T.self,privacy: .public)")
    return t
}

/// Load instance of generic type T from JSON file in application support directory.
///  Type T must conform to Decodable protocol and match JSON file's content structure.
///
///  Func returns nil on failure (file does not exist, decoding failure,...). Ensure to handle nil when using func.
/// - Parameter filename: JSON file
/// - Returns: instance of T on success, nil otherwise
func loadFromAppSupportDir<T: Decodable>(_ filename: String) -> T? {
    var data: Data
    var fileURL: URL
    var t: T

    jsonIOLog.notice("loadFromAppSupportDir(): -> try loading \(filename,privacy: .public) as \(T.self,privacy: .public)")
    
    do {
        fileURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(filename)
        //print("open \(fileURL)") // command to open/view file
    } catch {
        jsonIOLog.error("loadFromAppSupportDir(): <- nil, Error loading \(filename,privacy: .public) as \(T.self,privacy: .public),cannot get URL: \(error,privacy: .public)")
        return nil
    }

    do {
        data = try Data(contentsOf: fileURL)
    } catch {
        jsonIOLog.error("loadFromAppSupportDir(): <- nil, Error loading \(filename,privacy: .public) as \(T.self),failure loading data: \(error,privacy: .public)")
        return nil
    }
    
    do {
        t = try JSONDecoder().decode(T.self, from: data)
    } catch {
        jsonIOLog.error("loadFromAppSupportDir(): <- nil, Error parsing \(filename,privacy: .public) as \(T.self,privacy: .public): \(error,privacy: .public)")
        return nil
    }
    
    jsonIOLog.notice("loadFromAppSupportDir(): <- successfully loaded \(filename,privacy: .public) as \(T.self,privacy: .public)")
    return t
}

/// Save instance of generic type T to given URL.  Type T must conform to Encodable protocol.
/// - Parameters:
///   - fileURL: target file URL
///   - data: data (of generic type T) to be written to json file
/// - Returns: true if success, false otherwise
func saveToURL<T: Encodable>(fileURL: URL, data: T) -> Bool {
    do {
        jsonIOLog.notice("saveToURL(): -> try saving \(T.self,privacy: .public) to \(fileURL,privacy: .public)")
        try JSONEncoder()
            .encode(data)
            .write(to: fileURL)
        
        //print("open \(fileURL)") // command to open/view file
        jsonIOLog.notice("saveToURL(): <- successfully saved \(T.self,privacy: .public) to \(fileURL,privacy: .public)")
        return true
        
    } catch {
        jsonIOLog.error("saveToURL(): error saving \(T.self) to \(fileURL,privacy: .public): \(error,privacy: .public)")
    }
    return false
}


/// Save instance of generic type T to JSON file in application support directory.
///  Type T must conform to Encodable protocol.
/// - Parameters:
///   - filename: filename
///   - data: data (of generic type T) to be written to json file
func saveToAppSupportDir<T: Encodable>(filename: String, data: T) -> Void {
    do {
        jsonIOLog.notice("saveToAppSupportDir(): -> try saving \(T.self,privacy: .public) to \(filename,privacy: .public)")
        let fileURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(filename)
        
        try JSONEncoder()
            .encode(data)
            .write(to: fileURL)
        
        //print("open \(fileURL)") // command to open/view file
        jsonIOLog.notice("saveToAppSupportDir(): <- successfully saved \(T.self,privacy: .public) to \(filename,privacy: .public)")
        
    } catch {
        jsonIOLog.error("saveToAppSupportDir(): error saving \(T.self) to \(filename,privacy: .public): \(error,privacy: .public)")
    }
}

/// Save instance of generic type T to JSON file in app document directory.
///  Type T must conform to Encodable protocol.
/// - Parameters:
///   - filename: filename
///   - data: data (of generic type T) to be written to json file
/// - Returns: file URL if success,  nil otherwise
func saveToAppDocDir<T: Encodable>(filename: String, data: T) -> URL? {
    do {
        jsonIOLog.notice("saveToAppDocDir(): -> try saving \(T.self,privacy: .public) to \(filename,privacy: .public)")
        let fileURL = try FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(filename)
        
        try JSONEncoder()
            .encode(data)
            .write(to: fileURL)
        
        //print("open \(fileURL)") // command to open/view file
        jsonIOLog.notice("saveToAppDocDir(): <- successfully saved \(T.self,privacy: .public) to \(filename,privacy: .public)")
        return fileURL
        
    } catch {
        jsonIOLog.error("saveToAppDocDir(): error saving \(T.self) to \(filename,privacy: .public): \(error,privacy: .public)")
    }
    return nil
}

/// Save instance of generic type T to JSON file in app dir given on call.
///  Type T must conform to Encodable protocol.
/// - Parameters:
///   - filename: filename
///   - data: data (of generic type T) to be written to json file
///   - dirPath: target app directory
/// - Returns: file url on success, nil on failure
func saveToAppDir<T: Encodable>(dirPath: FileManager.SearchPathDirectory,filename: String, data: T) -> URL? {
    do {
        jsonIOLog.notice("saveToAppDir(): -> try saving \(T.self,privacy: .public) to \(filename,privacy: .public), in \(String(describing:dirPath))")
        let fileURL = try FileManager.default
            .url(for: dirPath, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(filename)
        
        try JSONEncoder()
            .encode(data)
            .write(to: fileURL)
        
        //print("open \(fileURL)") // command to open/view file
        jsonIOLog.notice("saveToAppDir(): <- successfully saved \(T.self,privacy: .public) to \(filename,privacy: .public)")
        return fileURL
        
    } catch {
        jsonIOLog.error("saveToAppDir(): error saving \(T.self) to \(filename,privacy: .public): \(error,privacy: .public)")
    }
    return nil
}

/// Remove file from Application Support directory.
/// - Parameter filename: file to remove from app support dir
func removeFileFromAppSupportDir(filename: String) {
    jsonIOLog.notice("removeFileFromAppSupportDir(): -> \(filename,privacy: .public)")
    do {
        let fileURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(filename)
        try FileManager.default.removeItem(at: fileURL )
        
    } catch {
        jsonIOLog.error("removeFileFromAppSupportDir(): cannot delete \(filename,privacy: .public), error:\(error,privacy: .public)")
    }
    jsonIOLog.notice("removeFileFromAppSupportDir(): <-")
}

/// Test if given file exists in Application Support directory.
/// - Parameter filename: file to remove from app support dir
/// - Returns: true if file exists, false otherwise
func fileExists(filename: String) -> Bool {
    var exists = false
    jsonIOLog.notice("fileExists(): -> \(filename)")
    do {
        let fileURL = try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(filename)
        let path = fileURL.path
        exists = FileManager.default.fileExists(atPath: path)
    } catch {
        jsonIOLog.error("fileExists(): error testing file \(filename,privacy: .public) exists, error:\(error,privacy: .public)")
    }
    jsonIOLog.notice("fileExists(): <- \(filename,privacy: .public) \(exists,privacy: .public)")
    return exists
}

