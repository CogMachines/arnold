// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.

// MacOS
import Foundation

class ServerSettings {
        
	class var sharedInstance : ServerSettings {
		struct Static {
			static let instance : ServerSettings = ServerSettings()
		}
		return Static.instance
	}
	
	var server: String {
		get {
            //var returnValue: String? = UserDefaults.standard.object(forKey: "rasa") as? String
			//if returnValue == nil {
				return "http://localhost:5000/version"
			//}
			//return returnValue!
		}
        
		set (newValue) {
            UserDefaults.standard.set(newValue, forKey: "rasa")
            UserDefaults.standard.synchronize()
		}
	}
}

// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.
