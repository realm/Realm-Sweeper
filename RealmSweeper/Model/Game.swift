//
//  Game.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 10/12/2021.
//

import Foundation
import RealmSwift

class Game: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var numRows = 0
    @Persisted var numCols = 0
    @Persisted var score = 0
    @Persisted var startTime: Date?
    @Persisted var latestMoveTime: Date?
    @Persisted var secondsTakenToComplete: Int?
    @Persisted var board: Board?
    @Persisted var gameStatus = GameStatus.notStarted
    @Persisted var winningTimeInSeconds: Int?
    
    convenience init(rows: Int, cols: Int, mines: Int) {
        self.init()
        numRows = rows
        numCols = cols
        board = Board(numRows: rows, numColums: cols, numMines: mines)
    }
    
    var hasWon: Bool {
        guard let board = board else { return false }
        if board.remainingMines > 0 { return false }
        
        var result = true
        
        board.rows.forEach() { row in
            row.cells.forEach() { cell in
                if !cell.isExposed && !cell.isFlagged {
                    result = false
                    return
                }
            }
            if !result { return }
        }
        return result
    }
    
    var hasLost: Bool {
        guard let board = board else { return false }
        var result = false
        
        board.rows.forEach() { row in
            row.cells.forEach() { cell in
                if cell.isExposed && cell.isMine {
                    result = true
                    return
                }
            }
            if result { return }
        }
        return result
    }
}

enum GameStatus: String, PersistableEnum {
    case notStarted = "Not Started"
    case inProgress = "In Progress"
    case won = "Won"
    case lost = "Lost"
}
