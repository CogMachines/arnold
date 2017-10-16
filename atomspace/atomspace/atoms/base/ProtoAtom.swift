// Semitone Inc. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.

import Foundation

class ProtoAtom : CustomStringConvertible {

    public private(set) var type : Type
    
    init(_ inType : Type) {
        self.type = inType
    }
    
    // Basic predicate
    func isType(type inType : Type, subclass inSubclass : Bool) -> Bool {
        
        if !inSubclass {
            return inType == self.type
        }
        //return classserver().isA(at, t);
        return false
    }
    
    public func isAtom() ->Bool {
        return false
    }

    public func isNode() ->Bool {
        return false
    }

    public func isLink() ->Bool {
        return false
    }
    
    /// Returns a string representation of the proto-atom.
    public func toString(_ inIndent : String) -> String {
        preconditionFailure("This method must be overridden")
    }
    
    public func toShortString(_ inIndent : String) -> String {
        return toString(inIndent)
    }
    
    static func == (left: ProtoAtom, right: ProtoAtom) -> Bool {
        preconditionFailure("This method must be overridden")
    }

    static func != (left: ProtoAtom, right: ProtoAtom) -> Bool {
        preconditionFailure("This method must be overridden")
    }
    
    var description: String {
        return toString("")
    }
    typealias ProtomSeq = [ProtoAtom]


}

// Semitone Inc. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.
