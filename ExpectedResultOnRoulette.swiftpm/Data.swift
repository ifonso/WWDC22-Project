//
//  Data.swift
//  ExpectedResultOnRoulette
//
//  Created by Afonso Lucas on 13/04/22.
//

import Foundation

struct BetsState {
    var redBet: Int = 0
    var blackBet: Int = 0
    var goldBet: Int = 0
    
    let returns = (red: 1, black: 1, gold: 13)
    let probabilities = (red: 0.4667, black: 0.4667, gold: 0.0667)
    
    public var totalBets: Int {
        get {
            return redBet + blackBet + goldBet
        }
    }
    
    var redReturn: Float {
        get {
            return Float(redBet * returns.red - (totalBets - redBet)) * Float(probabilities.red)
        }
    }
    
    var blackReturn: Float {
        get {
            return Float(blackBet * returns.black - (totalBets - blackBet)) * Float(probabilities.black)
        }
    }
    
    var goldReturn: Float {
        get {
            return Float(goldBet * returns.gold - (totalBets - goldBet)) * Float(probabilities.gold)
        }
    }
    
    var expectedValue: Float {
        get {
            return redReturn + blackReturn + goldReturn
        }
    }
}

public class GameState: ObservableObject {
    @Published var balance: Float = 100000 {
        didSet {
            self.lastRetrun = balance - oldValue
        }
    }
    
    @Published var betsState = BetsState()

    @Published var drawnNumber: UInt?
    @Published var currentValue: UInt?
    @Published var lastWin: Float = 0
    // Manter só se criar o return/game
    @Published var lastRetrun: Float = 0
    @Published var gameNumber: UInt = 0
    
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
}
