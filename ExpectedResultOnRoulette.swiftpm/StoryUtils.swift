//
//  StoryUtils.swift
//  ExpectedResultOnRoulette
//
//  Created by Afonso Lucas on 18/04/22.
//

import Foundation
import SwiftUI

public let Story: [[String]] = [[""],
    ["To the surprise of most, the secret is nothing more than simple statistics, and i'm going to show you that with a very common game, the roulette.", "**Rules:** you can bet any amount on any color, if the color you chose is drawn on the roulette wheel you will receive twice the amount played in that color."],
    
    ["Now that you know the rules, I'd like you to answer a question:\nStarting with $10 bets, if we play once we can win or lose $10, but on average what will be the payback if we play many times?", "The answer to this question lies in calculating the expected value! But what is this?" ,"In statistics, in probability theory, the expected value can be understood as the average value resulting from an experiment if it is repeated many times."],
    
    ["Let's start with the probabilities, we have 7 black squares and 7 red squares, with 14 in total.", "With X being our random variable *(value drawn by the roulette wheel)*, the probability of a red house being drawn is:"],
    
    ["Now that we know the odds let's choose a strategy. The most common and simple is to always play in the same color.", "We're going with red."],
    
    ["Now let's see the return of each event with **R (red square)** and **B (black square)** being our events:", "If it lands on red: R = +10", "If it lands on black: B = -10"],
    
    ["We have the probabilities of each event occurring, a strategy and the return of each event following this strategy, we can now calculate the expected value! 😀"],
    
    ["The expected value of a random variable is the sum of the products between the return values and their respective possibilities to occur.", "With **X** being our random variable (game result), with possible values **R** and **B**,  and the probabilities represented by **P(x)**, the expected value **E(X)**:"],
    
    ["Yes, our return is **ZERO**!", "As there is the same probability of winning and losing, as we play we are tied, that is, our balance tends to remain the same.", "See that in a sufficiently large number of random games, the number of wins and losses tends to be close."],
    
    ["**TEST IT!**"],
    
    ["Okay, but no roulette works like that! Time to exit the hypothetical event, let's play something similar to European Roulette:", "We now have 15 squares on our roulette, where 7 of these are black, 7 are red, and 1 is gold.", "**Rules**: the red and black houses continue with the same return of **1:1**, but the gold house has a return of **1:13**, that is, if we bet on it and it is drawn, we win 14x the value of our bet."],
]

public enum userCardColors {
    case red
    case black
    case gold
}

public struct FirstPage: View {
    public var body: some View {
        VStack {
            Text("**Welcome!**")
                .font(.system(.title))
            Spacer().frame(height: 30)
            Text("Today I came to show you the \"**secret**\" of gambling 🤑")
                .multilineTextAlignment(.leading)
                .font(.system(.body))
        }
    }
}


