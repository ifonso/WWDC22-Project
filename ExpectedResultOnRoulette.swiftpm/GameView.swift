//
//  GameView.swift
//  ExpectedResultOnRoulette
//
//  Created by Afonso Lucas on 13/04/22.
//

import SwiftUI

struct GameView: View {
    @StateObject var State = GameState()
    
    @State var roulettePosition: CGFloat = 3000
    @State var autoSpin = false
    @State var helpPopup = false
    @State var outOfMoney = false
    
    let numbersPosition: [UInt: CGFloat] = [1: 700, 14: 600, 2: 500, 13: 400, 3: 300, 12: 200, 4: 100, 0: 0, 11: -100, 5: -200, 10: -300, 6: -400, 9: -500, 7: -600, 8: -700]
    
    var body: some View {
        ZStack {
            VStack {
                Spacer().frame(height: 10)
                Info.padding(.horizontal, 36)
                
                Spacer()
                
                VStack {
                    Game.frame(height: 130).background(AppColors.backgroundLessDarker)
                    
                    HStack {
                        Text("Last win: $\(State.lastWin.formatted())")
                            .font(.system(size: 16, design: .monospaced))
                            .opacity(0.4)
                            .padding(.leading, 36)
                        Spacer()
                    }
                    .padding(.vertical, 10)
                }
                
                Spacer()
                
                Inputs.padding(.horizontal, 36)
                Spacer().frame(height: 60)
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
            }
        }
        .alert(isPresented: $outOfMoney) {
            Alert(
                title: Text("Oops"),
                message: Text("You don't have enough money for this play."),
                dismissButton: .default(Text("Ok")))
        }
        .sheet(isPresented: $helpPopup) {
            HelpPopup()
        }
    }
    
    var Game: some View {
        ZStack {
            DeckView().offset(x: self.roulettePosition)

            RoundedRectangle(cornerRadius: 2)
                .fill(.white)
                .frame(width: 4, height: 110)
        }
    }
    
    var Info: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                HStack(spacing: 0) {
                    Text("BALANCE: ")
                        .foregroundColor(.white)
                        Text("$\(State.balance.formatted())")
                        .foregroundColor(AppColors.primaryGold)
                }.font(.system(size: 16, design: .monospaced))
                
                Spacer().frame(height: 4)
                
                HStack(spacing: 0) {
                    Text("EV: ")
                        .foregroundColor(.white)
                    Text(String(State.expectedValue.formatted()))
                        .foregroundColor(State.expectedValue < 0 ? AppColors.primaryRed : .gray)
                }.font(.system(size: 16, design: .monospaced))
                
                Spacer().frame(height: 6)
                
                Text("GAMES: \(State.gameNumber)")
                    .font(.system(size: 16, design: .monospaced))
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Button {
                State.balance = 100000
                State.gameNumber = 0
                State.lastWin = 0
            } label: {
                Image(systemName: "arrow.counterclockwise")
            }
                .frame(width: 40, height: 40)
                .background(AppColors.backgroundGray)
                .foregroundColor(.white)
                .cornerRadius(6)
            
            Button("Help") { helpPopup = true }
                .frame(width: 60, height: 40)
                .background(AppColors.backgroundGray)
                .foregroundColor(.white)
                .cornerRadius(6)
        }
        .frame(height: 90)
    }
    
    var Inputs: some View {
        VStack {
            
            // Bet Buttons
            
            HStack {
                VStack {
                    Text("$\(State.currentBets["red"]!)")
                        .padding(.bottom, 10)
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    
                    ZStack {
                        BetButton(text: "2x", color: AppColors.primaryRed)
                        Button("R"){
                            self.State.currentBets["red"]! += State.currentValue ?? 0
                        }.font(.system(size: 64)).foregroundColor(.clear)
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("$\(State.currentBets["black"]!)")
                        .padding(.bottom, 10)
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    
                    ZStack {
                        BetButton(text: "2x", color: AppColors.primaryBlack)
                        Button("B"){
                            self.State.currentBets["black"]! += State.currentValue ?? 0
                        }.font(.system(size: 64)).foregroundColor(.clear)
                    }
                }
                
                Spacer()
                
                VStack {
                    Text("$\(State.currentBets["gold"]!)")
                        .padding(.bottom, 10)
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    
                    ZStack {
                        BetButton(text: "14x", color: AppColors.primaryGold)
                        Button("G"){
                            self.State.currentBets["gold"]! += State.currentValue ?? 0
                        }.font(.system(size: 64)).foregroundColor(.clear)
                    }
                }
            }
            
            Spacer().frame(height: 42)
            
            // Input Entries
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Bet")
                    Text("Amount")
                }
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .opacity(0.3)
                
                Spacer()
                
                ZStack {
                    HStack {
                        Text("$")
                            .foregroundColor(AppColors.primaryGold)
                        
                        Spacer()
                        
                        TextField("0", text: $State.betValue)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(AppColors.primaryGold)
                    }
                    .padding(.horizontal, 14)
                }
                .frame(width: 200, height: 45)
                .background(AppColors.backgroundDarkYellow)
                .cornerRadius(8)
            }
            .padding(16)
            .background(AppColors.backgroundLessDarker)
            .cornerRadius(10)
            
            Spacer().frame(height: 40)
            
            // Action Buttons
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 9)
                        .fill(.white)
                        .frame(width: 92, height: 64)
                        .opacity(0.3)
                    
                    Button("FAST") {
                        withAnimation(.easeIn) {
                            autoSpin = !autoSpin
                        }
                        
                    }
                        .frame(width: 90, height: 62)
                        .background(AppColors.backgroundLessDarker)
                        .cornerRadius(8)
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundColor(autoSpin ? .green : AppColors.primaryRed)
                }
                
                Spacer()

                ZStack {
                    RoundedRectangle(cornerRadius: 9)
                        .fill(.white)
                        .frame(width: 92, height: 64)
                        .opacity(0.3)
                    
                    Button("CLEAR") {
                        for (color, _) in State.currentBets {
                            State.currentBets[color] = 0
                        }
                    }
                        .frame(width: 90, height: 62)
                        .background(AppColors.backgroundLessDarker)
                        .cornerRadius(8)
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                }
                
                Spacer()

                ZStack {
                    RoundedRectangle(cornerRadius: 9)
                        .fill(.white)
                        .frame(width: 92, height: 64)
                        .opacity(0.3)

                    Button("SPIN") { spinRoulette() }
                        .frame(width: 90, height: 62)
                        .background(AppColors.backgroundLessDarker)
                        .cornerRadius(8)
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundColor(AppColors.primaryGold)
                
                    }
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
    }
    
    func draw() {
        let drawn: UInt = ORDER.randomElement()!
        self.State.drawnNumber = drawn
    }
    
    func computeResultBalance() {
        var result: Float = 0
        
        for (color, bet) in State.currentBets {
            if color == State.winnerColor! {
                if color == "gold" {
                    result += 14 * Float(bet)
                    
                } else {
                    result += 2 * Float(bet)
                }
            }
        }
        
        State.lastWin = result
        
        for (_, bet) in State.currentBets {
            result -= Float(bet)
        }
        
        State.balance += result
    }
    
    func spinRoulette() {
        if !(State.balance - Float(State.totalBets) > 0) {
            return outOfMoney.toggle()
        }
        
        draw()
        
        self.State.gameNumber += 1
        self.roulettePosition = 3000
        let drawnPosition = numbersPosition[self.State.drawnNumber!]!
        
        if autoSpin {
            self.roulettePosition = drawnPosition
        } else {
            withAnimation(.easeOut(duration: 2)) {
                self.roulettePosition = drawnPosition + CGFloat.random(in: -40...40)
            }
        }
        computeResultBalance()
    }
}

struct BetButton: View {
    var text: String
    var color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .frame(width: 80, height: 80)
                .opacity(0.2)
            
            ZStack {
                Rectangle()
                    .fill(color)
                    .opacity(0.9)
                    .frame(width: 76, height: 76)
                
                VStack(alignment: .center) {
                    Text(text)
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .padding(.top, 7)
                    
                    ZStack {
                        Rectangle()
                            .frame(height: 38)
                            .opacity(1)
                        
                        Text("BET")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(AppColors.primaryBlack)
                            .opacity(0.75)
                    }
                }
            }
            .frame(width: 76, height: 76)
            .mask(RoundedRectangle(cornerRadius: 11))
        }
        .frame(width: 80, height: 80)
        .mask(RoundedRectangle(cornerRadius: 12))
    }
    
    public init(text: String, color: Color) {
        self.text = text
        self.color = color
    }
}

struct DeckView: View {
    public var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(0...4, id: \.self) {_ in
                ForEach(ORDER, id: \.self){number in
                    CardView(number)
                }
            }
        }
    }
}

struct HelpPopup: View {
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("How To Play")
                    .font(.system(.title2))
                    .foregroundColor(.white)
                
                Spacer().frame(height: 20)

                Text("**1** - In the upper left corner you can find relevant information such as balance, expected value and number of games.\n\n**2** - In the field \"**Bet Amount**\" you can put the amount you want to play.\n\n**3** - After placing a value, choose one or more colors to play by clicking on any of the \"**BET**\" buttons.\n(you can play different values in each color).\n\n**4** - After placing your bet, press \"**SPIN**\" to play.\n\n**CLEAR:** Use the \"**CLEAR**\" button to clear the betting area.\n\n**FAST:** When the \"**FAST**\" mode is activated its color turns green and when you press \"**SPIN**\", the spins occur without animation.")
                
            }
            .font(.system(.body))
            .foregroundColor(.white)
            
        }
        .padding(26)
        .background(AppColors.backgroundDarker)
        .cornerRadius(16)
    }
}
