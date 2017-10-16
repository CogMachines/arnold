//
//  ServerSettings.swift
//  ChatClient
//
//  Created by Simon Strandgaard on 10-01-15.
//  Copyright (c) 2015 Simon Strandgaard. All rights reserved.
//

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
            var returnValue: String? = UserDefaults.standard.object(forKey: "the-server") as? String
			if returnValue == nil {
				returnValue = "https://localhost:8334/graph/123/command"
			}
			return returnValue!
		}
		set (newValue) {
            UserDefaults.standard.set(newValue, forKey: "the-server")
            UserDefaults.standard.synchronize()
		}
	}
}
