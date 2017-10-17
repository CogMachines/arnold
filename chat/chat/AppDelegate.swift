//
//  AppDelegate.swift
//  chat
//
//  Created by Gene on 10/16/17.
//  Copyright © 2017 Semitone, Inc. All rights reserved.
//

import Cocoa

import ApiAI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    public var apiAI : ApiAI!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {

        self.apiAI = ApiAI()
        
        let configuration = AIDefaultConfiguration()
        configuration.clientAccessToken = "5d52450340134aac84e5476af5d00264"
        self.apiAI.configuration = configuration;
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
}

