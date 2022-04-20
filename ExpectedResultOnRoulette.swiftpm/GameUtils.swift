//
//  GameUtils.swift
//  ExpectedResultOnRoulette
//
//  Created by Afonso Lucas on 13/04/22.
//

import SwiftUI

// Cards order
public let ORDER: [UInt] = [1, 14, 2, 13, 3, 12, 4, 0, 11, 5, 10, 6, 9, 7, 8]


public struct AppColors {
    public static let primaryRed = Color(red: 0.933, green: 0.235, blue: 0.227)
    public static let primaryGold = Color(red: 0.980, green: 0.823, blue: 0)
    public static let primaryBlack = Color(red: 0, green: 0, blue: 0)
    
    public static let backgroundDarker = Color(red: 0.118, green: 0.121, blue: 0.149)
    public static let backgroundLessDarker = Color(red: 0.188, green: 0.196, blue: 0.216)
    public static let backgroundDarkYellow = Color(red: 0.392, green: 0.376, blue: 0.282)
    public static let backgroundGray = Color(red: 0.478, green: 0.478, blue: 0.478)
}


public struct CardPreset {
    public let number: UInt
    public let color: Color
    
    private let maximum: UInt = 14
    
    public static let BLACKS: [UInt] = [14, 13, 12, 11, 10, 9, 8]
    public static let REDS: [UInt] = [1, 2, 3, 4, 5, 6, 7]
    
    public init(number: UInt) {
        self.number = min(number, self.maximum)

        if CardPreset.BLACKS.contains(number) {
            color = AppColors.primaryBlack
        } else if CardPreset.REDS.contains(number) {
            color = AppColors.primaryRed
        } else {
            color = AppColors.primaryGold
        }
    }
}

public struct CardView: View {
    public let size: CGFloat = 90
    public let card: CardPreset
    public var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(card.color)
                    .frame(width: size, height: size)
            }
            
            Text("\(card.number)")
                .font(.system(size: 32, design: .rounded))
                .foregroundColor(.white)
        }
        .padding(5)
    }
    
    public init(_ number: UInt) {
        self.card = CardPreset(number: number)
    }
}
