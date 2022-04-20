//
//  Data.swift
//  ExpectedResultOnRoulette
//
//  Created by Afonso Lucas on 13/04/22.
//

import Foundation

public class GameState: ObservableObject {
    @Published var balance: Float = 100000 {
        didSet {
            self.lastRetrun = balance - oldValue
        }
    }

    @Published var currentBets: [String: UInt] = ["red": 0, "black": 0, "gold": 0]
    @Published var drawnNumber: UInt?
    @Published var currentValue: UInt?
    @Published var lastWin: Float = 0
    // Manter só se criar o return/game
    @Published var lastRetrun: Float = 0
    
    @Published var gameNumber: UInt = 0
    
    var totalBets: UInt {
        get {
            return currentBets["red"]! + currentBets["black"]! + currentBets["gold"]!
        }
    }
    
    let gains: [String: Int] = ["red": 1, "black": 1, "gold": 13]
    let probabilities: [String: Float] = ["red": 7/15, "black": 7/15, "gold": 1/15]
    
    var betValue: String {
        get {
            (currentValue != nil) ? String(currentValue!) : ""
        }
        set {
            currentValue = UInt(newValue) ?? nil
        }
    }
    
    var winnerColor: String? {
        get {
            if drawnNumber != nil {
                if CardPreset.BLACKS.contains(drawnNumber!) {
                    return "black"
                } else if CardPreset.REDS.contains(drawnNumber!){
                    return "red"
                } else {
                    return "gold"
                }
            }
            return nil
        }
    }
    
    var expectedValue: Float {
        get {
            var finalValue: Float = 0
            let total: UInt = totalBets
            for (color, bet) in self.currentBets {
                let returnValue = (Int(bet) * gains[color]!) - (Int(total) - Int(bet))
                finalValue += Float(returnValue) * probabilities[color]!
            }

            return finalValue
        }
    }
}
