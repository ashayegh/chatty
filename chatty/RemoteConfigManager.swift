//
//  RemoteConfigManager.swift
//  chatty
//
//  Created by Amir Shayegh on 2017-03-31.
//  Copyright © 2017 ca.shayegh. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig

class RemoteConfigManager: NSObject {

    static let interval: TimeInterval = 12
    static var remoteConfigValues:[String:String] = [:]
    static var controlsToUpdate:[String:NSObject] = [:]
    
    static func remoteConfigInit(firstControl:UIButton){
        RemoteConfigManager.controlsToUpdate["loginButton"] = firstControl
        
        let remoteValues = FIRRemoteConfig.remoteConfig()
        RemoteConfigManager.remoteConfigValues["loginButton"] = remoteValues["loginButton"].stringValue
        RemoteConfigManager.remoteConfigValues["PhotoButtonUpdate"] = remoteValues["PhotoButtonUpdate"].stringValue
        
        let remoteConfigDefaults:[String:NSObject] = [
            "loginButton":"login" as NSObject,
            "PhotoButtonUpdate":"update" as NSObject
        ]
        FIRRemoteConfig.remoteConfig().setDefaults(remoteConfigDefaults)
        
        //43200 = 12 hours
        Timer.scheduledTimer(timeInterval: RemoteConfigManager.interval, target: self, selector: #selector(RemoteConfigManager.startFetching(firstControl:)), userInfo: nil, repeats: true)
        
        remoteConfigDebugMode()
        startFetching(firstControl: firstControl)
        
        
    }
    
    static func startFetching(firstControl:UIButton){
        let remoteValues = FIRRemoteConfig.remoteConfig()
        RemoteConfigManager.remoteConfigValues["loginButton"] = remoteValues["loginButton"].stringValue
        RemoteConfigManager.remoteConfigValues["PhotoButtonUpdate"] = remoteValues["PhotoButtonUpdate"].stringValue
        
        FIRRemoteConfig.remoteConfig().fetch(withExpirationDuration: RemoteConfigManager.interval){
            (status, error) in
            guard error == nil else {
                print("Error fetching remote config values \(error)")
                return
            }
            
            FIRRemoteConfig.remoteConfig().activateFetched()
            let fc = RemoteConfigManager.controlsToUpdate["loginButton"] as! UIButton
            print("loginButton value: \(RemoteConfigManager.remoteConfigValues["loginButton"])")
            fc.setTitle(RemoteConfigManager.remoteConfigValues["loginButton"], for: UIControlState.normal)
        }
    }
    
    static func remoteConfigDebugMode() {
        let debugSettings = FIRRemoteConfigSettings(developerModeEnabled: true)
        FIRRemoteConfig.remoteConfig().configSettings = debugSettings!
    }
 
}
