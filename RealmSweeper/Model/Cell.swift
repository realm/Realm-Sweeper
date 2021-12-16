//
//  Cell.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 10/12/2021.
//

import RealmSwift

class Cell: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var isBomb = false
    @Persisted var numBombNeigbours = 0
    @Persisted var isExposed = false
    @Persisted var isFlagged = false
    @Persisted var hasExploded = false
    
    convenience init(isBomb: Bool, numBombNeigbours: Int) {
        self.init()
        self.isBomb = isBomb
        self.numBombNeigbours = numBombNeigbours
    }
}
