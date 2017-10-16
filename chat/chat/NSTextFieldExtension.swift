//
//  NSTextFieldExtension.swift
//  ChatClient
//
//  Created by Simon Strandgaard on 09-01-15.
//  Copyright (c) 2015 Simon Strandgaard. All rights reserved.
//

import Cocoa

extension NSTextView {
    
	func append(string: String) {
        styledAppend(string: string, bold: false)
	}
	
	func appendBold(string: String) {
        styledAppend(string: string, bold: true)
	}
	
	func styledAppend(string: String, bold: Bool) {
//        var font: NSFont
//        if bold {
//            font = NSFont.boldSystemFont(ofSize: 28)
//        } else {
//            font = NSFont.systemFont(ofSize: 28)
//        }
//
//        let attributes = [NSAttributedStringKey.font : font]
let attributedString = NSAttributedString(string: string, attributes:nil )
    
        self.textStorage?.append(attributedString)
        self.scrollToEndOfDocument(nil)
	}
}
