//
//  UserDefaultsManager.swift
//  Trials of Truth
//
//  Created by Jon Kent on 9/25/17.
//  Copyright © 2017 Relativistic. All rights reserved.
//

// Example Usage:
// UserDefaultsManager.someMessage = "Testing"
// UserDefaultsManager.someNumber = 300

import Foundation

import UIKit
import CoreLocation

class UserDefaultsManager {
    
    fileprivate static var defaults: UserDefaults {
        get {
            let tdefault = UserDefaults.standard
            return tdefault
        }
    }
    
    static let isFirstRun = launches <= 1
    
    static var launches = UserDefaultsManager.valueOrDefaultForKey("launches", defaultValue: 0) {
        didSet {
            defaults.set(launches, forKey: "launches")
            
            defaults.synchronize()
        }
    }
    
    
    static var build = UserDefaultsManager.valueOrDefaultForKey("build", defaultValue: 1) {
        didSet {
            defaults.set(build, forKey: "build")
            
            defaults.synchronize()
        }
    }
    
    static var someMessage = UserDefaultsManager.valueOrDefaultForKey("someMessage", defaultValue: "Hello World!") {
        didSet {
            defaults.set(someMessage, forKey: "someMessage")
            
            defaults.synchronize()
        }
    }
    
    static var someNumber = UserDefaultsManager.valueOrDefaultForKey("someNumber", defaultValue: 0) {
        didSet {
            defaults.set(someNumber, forKey: "someNumber")
            
            defaults.synchronize()
        }
    }
    
    fileprivate class func valueOrDefaultForKey<T>(_ key: String, defaultValue: T) -> T {
        return defaults.object(forKey: key) as? T ?? defaultValue
    }
    
    class func save (){
        // Example save
        defaults.set(someMessage, forKey: "someMessage")
        defaults.set(someNumber, forKey: "someNumber")
        
        defaults.synchronize()
    }
    
    class func load() {
        let currentBuild = Int(Bundle.main.infoDictionary!["CFBundleVersion"] as! String)!
        let previousBuild = build
        if previousBuild < currentBuild {
            build = currentBuild
            
            if previousBuild > 1 {
                // Upgrade path:
                return
            }
        }
        
        // Special loading of private variables might go here:
    }
}
