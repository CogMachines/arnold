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

        // Set up DialogFlow (api.ai)
        self.apiAI = ApiAI()
        let configuration = AIDefaultConfiguration()
        configuration.clientAccessToken = "5777b2dede834b2ab509e29b450c429d"
        self.apiAI.configuration = configuration;
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
}

