// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.

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

// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.
