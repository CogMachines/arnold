// Semitone Inc. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.

import Foundation

class AtomSpace {
    
    // private var ClassServer& _classserver;
    
    // Single, global mutex for locking the indexes.
    // Its recursive because we need to lock twice during atom insertion
    // and removal: we need to keep the indexes stable while we search
    // them during add/remove.
    //mutable std::recursive_mutex _mtx;

    // Cached count of the number of atoms in the table.
    private var _size : UInt64
    private var _num_nodes : UInt64
    private var _num_links : UInt64

    // Cached count of the number of atoms of each type.
    private var _size_by_type : [UInt64]
    
    // Index of all the atoms in the table, addressible by thier hash.
    //std::unordered_multimap<ContentHash, Handle> _atom_store;

    //! Index for quick retrieval of certain kinds of atoms.
    TypeIndex typeIndex;


}

// Semitone Inc. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.
