//
//  Board.swift
//  RealmSweeper
//
//  Created by Andrew Morgan on 10/12/2021.
//

import RealmSwift

class Board: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var rows = List<Row>()
    @Persisted var startingNumberOfBombs = 0
    
    var remainingBombs: Int {
        var count = 0
        rows.forEach() { row in
            count += row.cells.filter{ $0.isFlagged }.count
        }
        return startingNumberOfBombs - count
    }
    
    convenience init(numRows: Int, numColums: Int, numBombs: Int) {
        self.init()
        startingNumberOfBombs = numBombs
        for _ in 1...numRows {
            rows.append(Row(numColums))
        }
        var bombsToPlace = min(numColums * numRows, numBombs)
        
        while(bombsToPlace > 0) {
            let col = Int.random(in: 0...numColums - 1)
            let row = Int.random(in: 0...numRows - 1)
            if !rows[row].cells[col].isBomb {
                rows[row].cells[col].isBomb = true
                print("Placed bomb \(bombsToPlace)")
                bombsToPlace -= 1
            }
        }
        
        for row in 0...numRows - 1 {
            for col in 0...numColums - 1 {
                rows[row].cells[col].numBombNeigbours = countNeighbours(row: row, col: col)
            }
        }
    }
    
    private func countNeighbours(row: Int, col: Int) -> Int {
        var neighbours = 0
        for rowToCheck in row - 1...row + 1 {
            neighbours += countNeighboursInRow(row: rowToCheck, col: col)
        }
        return neighbours
    }
    
    private func countNeighboursInRow(row: Int, col: Int) -> Int {
        var neighbours = 0
        guard row >= 0 && row < rows.count && col >= 0 && col < rows[row].cells.count else {
            return neighbours
        }
        if col > 0 && rows[row].cells[col - 1].isBomb { neighbours += 1 }
        if rows[row].cells[col].isBomb { neighbours += 1 }
        if col < rows[row].cells.count - 1 && rows[row].cells[col + 1].isBomb { neighbours += 1 }
        return neighbours
    }
    
    func findCellsToExpose(row: Int, col: Int, existingCoords: Set<Coord>? = nil) -> Set<Coord>{
        var coords = existingCoords ?? Set<Coord>()
        guard row >= 0 && row < rows.count && col >= 0 && col < rows[row].cells.count else {
            print("Error. Requested out of bounds coordinates when finding cells to expose.")
            return coords
        }
        let coord = Coord(row: row, col: col)
        let cell = self.rows[row].cells[col]
        
        if cell.isExposed || cell.isBomb || cell.isFlagged || coords.contains(coord) {
            return coords
        }
        coords.insert(coord)
        if cell.numBombNeigbours == 0 {
            if col > 0 {
                coords = findCellsToExpose(row: row, col: col - 1, existingCoords: coords)
                if row > 0 {
                    coords = findCellsToExpose(row: row - 1, col: col - 1, existingCoords: coords)
                }
                if row < rows.count - 1 {
                    coords = findCellsToExpose(row: row + 1, col: col - 1, existingCoords: coords)
                }
            }
            if rows.count > 0 && col < rows[0].cells.count - 1 {
                coords = findCellsToExpose(row: row, col: col + 1, existingCoords: coords)
                if row > 0 {
                    coords = findCellsToExpose(row: row - 1, col: col + 1, existingCoords: coords)
                }
            }
            if row < rows.count - 1 {
                coords = findCellsToExpose(row: row + 1, col: col, existingCoords: coords)
                if col < rows[row].cells.count - 1 {
                    coords = findCellsToExpose(row: row + 1, col: col + 1, existingCoords: coords)
                }
            }
            if row > 0 {
                coords = findCellsToExpose(row: row - 1, col: col, existingCoords: coords)
            }
        }
        return coords
    }
}

struct Coord: Hashable {
    var row: Int
    var col: Int
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
}
