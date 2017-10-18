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
import ApiAI

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
		//print("server: \(text)")
		ServerSettings.sharedInstance.server = text
	}
	
	@objc func messageTextFieldAction() {
		let text = messageTextField.stringValue
		if text.isEmpty {
			return
		}
		//print("request:  \(text)")
		
		let appendText = "\(text)\n"
        historyTextView.appendBold(string: appendText)
		
		weak var weakSelf = self
        DispatchQueue.main.async() {
			if let s = weakSelf {
                s.sendText(text: text)
			}
		}
	}
	
	func showReply(_ replyText: String) {
		let appendText = "\(replyText)\n\n"
        historyTextView.append(string: appendText)
	}

	func sendText(text: String) {
        
        // Request using text (assumes that speech recognition / ASR is done using a third-party library, e.g. AT&T)
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        if let api = appDelegate.apiAI {
            
            if let request = api.textRequest() {
                
                request.query = text
            
                request.setMappedCompletionBlockSuccess({ (request, response) in
                    if let response = response as? AIResponse {
                        
                        let action = response.result.action
                        if action == "query_person" {
                            
                            // Get the parameters
                            if let parameters = response.result.parameters as? [String: AIResponseParameter] {
                                if let givenName = parameters["given-name"]!.stringValue {
                                    print(givenName)
                                }
                            }
                            
                            if let lastName = response.result.parameters["last-name"] {
                                print(lastName)
                            }
                        }
                        
                        if let messages = response.result.fulfillment.messages {
                            let message = messages[0]
                            if let text = message["speech"] as? String {
                                self.showReply(text)
                            }
                        }
                    }
                }, failure: { (request, error) in
                })
                
                api.enqueue(request)
            }
        }
        
        #if false
		// Create the request
		let server = ServerSettings.sharedInstance.server
		let url: URL! = URL(string: server)
		if url == nil {
			print("error invalid url \(url)")
            self.showReply("error invalid url \(url)")
			return
		}
        
        // Add the parameters
        let parameters: Parameters = [
            "foo": [1,2,3],
            "bar": [
                "baz": "qux"
            ]
        ]
        
        Alamofire.request(url,
                          method: .get)
            .validate()
            .responseData { response in
                debugPrint("All Response Info: \(response)")
        }
        
//        Alamofire.request(url,
//                          method: .get,
//                          parameters: parameters,
//                          encoding: JSONEncoding.default).responseString { response in
//
//            print("Request: \(String(describing: response.request))")   // original url request
//            print("Response: \(String(describing: response.response))") // http url response
//            print("Result: \(response.result)")                         // response serialization result
//
//            if let json = response.result.value {
//                print("JSON: \(json)") // serialized json response
//            }
//
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)") // original server data as UTF8 string
//            }
//        }
        #endif
	}

	func showSuccessData(data: Data) {
		let responseTextOrNil: String? = String(data: data, encoding: .utf8)
		if responseTextOrNil == nil {
			print("error response data is not utf8")
            self.showReply("error response data is not utf8")
			return
		}
		
		let responseText: String = responseTextOrNil!
		print("response: \(responseText)")
        self.showReply(responseText)
	}

	func showFailure(error: Error) {
		let responseText: String = error.localizedDescription
		print("response: \(responseText)")
        self.showReply(responseText)
	}

}

