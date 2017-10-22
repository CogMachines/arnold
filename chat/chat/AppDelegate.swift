// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.

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

// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.
