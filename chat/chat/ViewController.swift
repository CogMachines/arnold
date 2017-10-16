//
//  ViewController.swift
//  ChatClient
//
//  Created by Simon Strandgaard on 09-01-15.
//  Copyright (c) 2015 Simon Strandgaard. All rights reserved.
//

// MacOs
import Cocoa

// Frameworks
import Alamofire

class ViewController: NSViewController {
	@IBOutlet var serverTextField: NSTextField!
	@IBOutlet var historyTextView: NSTextView!
	@IBOutlet var messageTextField: NSTextField!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		serverTextField.placeholderString = "https://localhost:8334/graph/123/command"
		serverTextField.target = self
		serverTextField.action = #selector(serverTextFieldAction)
		
		if ServerSettings.sharedInstance.server.isEmpty {
			ServerSettings.sharedInstance.server = "https://localhost:8334/graph/123/command"
		}
		let server = ServerSettings.sharedInstance.server
		if !server.isEmpty {
			serverTextField.stringValue = server
		}

		messageTextField.target = self
        messageTextField.action = #selector(messageTextFieldAction)
	}
	
	override func viewDidAppear() {
		super.viewDidAppear()
		messageTextField.becomeFirstResponder()
	}

    @objc func serverTextFieldAction() {
		let text = serverTextField.stringValue
		print("server: \(text)")
		ServerSettings.sharedInstance.server = text
	}
	
	@objc func messageTextFieldAction() {
		let text = messageTextField.stringValue
		if text.isEmpty {
			return
		}
		print("request:  \(text)")
		
		let appendText = "\(text)\n"
        historyTextView.appendBold(string: appendText)
		
		weak var weakSelf = self
        DispatchQueue.main.async() {
			if let s = weakSelf {
                s.sendText(text: text)
			}
		}
	}
	
	func showReply(replyText: String) {
		let appendText = "\(replyText)\n\n"
        historyTextView.append(string: appendText)
	}

	func sendText(text: String) {
		var dict = Dictionary<String, AnyObject>()
        dict["command"] = text as AnyObject
		
		// convert dictionary to json data
        let data = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
		
		// create a POST request
		let server = ServerSettings.sharedInstance.server
		let url: URL! = URL(string: server)
		if url == nil {
			print("error invalid url \(url)")
            showReply(replyText: "error invalid url \(url)")
			return
		}
        
        Alamofire.request(server).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
//        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15)
//        request.httpMethod = "POST"
//        request.httpBody = data
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        // execute the POST request
//        NetworkManager.sharedInstance.execute(request: request) { (result: NetworkManagerResult) -> Void in
//            switch result {
//            case let .Success(data):
//                self.showSuccessData(data: data)
//            case let .Failure(error):
//                self.showFailure(error: error)
//            }
//        }
	}

	func showSuccessData(data: Data) {
		let responseTextOrNil: String? = String(data: data, encoding: .utf8)
		if responseTextOrNil == nil {
			print("error response data is not utf8")
            showReply(replyText: "error response data is not utf8")
			return
		}
		
		let responseText: String = responseTextOrNil!
		print("response: \(responseText)")
        showReply(replyText: responseText)
	}

	func showFailure(error: Error) {
		let responseText: String = error.localizedDescription
		print("response: \(responseText)")
        showReply(replyText: responseText)
	}

}

