//
//  Cell.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 10/12/2021.
//

import RealmSwift

class Cell: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var isMine = false
    @Persisted var numMineNeigbours = 0
    @Persisted var isExposed = false
    @Persisted var isFlagged = false
    @Persisted var hasExploded = false
    
    convenience init(isMine: Bool, numMineNeigbours: Int) {
        self.init()
        self.isMine = isMine
        self.numMineNeigbours = numMineNeigbours
    }
}
