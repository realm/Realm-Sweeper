//
//  Row.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 10/12/2021.
//

import RealmSwift

class Row: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var cells = List<Cell>()
    
    convenience init(_ numCells: Int) {
        self.init()
        for _ in 1...numCells {
            cells.append(Cell())
        }
    }
}
