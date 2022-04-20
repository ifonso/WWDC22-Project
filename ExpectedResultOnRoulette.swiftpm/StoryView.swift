//
//  StoryView.swift
//  ExpectedResultOnRoulette
//
//  Created by Afonso Lucas on 18/04/22.
//

import SwiftUI

enum colorOption {
    case red
    case black
}

struct StoryView: View {
    @State var page = 0
    @State var level: Double = 0
    
    @Binding var tab: Int
    
    var body: some View {
        VStack {
            HStack {
                Button("Restart") {
                    self.page = 0
                }
                .foregroundColor(.white)
                .opacity(0.5)
                
                Spacer()
            }.padding(20)
            
            Spacer()
            
            VStack(alignment: .leading) {
                if page == 0 {
                    FirstPage()
                } else {
                    VStack {
                        ForEach(Story[page], id: \.self) { text in
                            Text(getMarkdown(text: text))
                                .font(.system(.body))

                            Spacer().frame(height: 21)
                            
                        }
                        
                        if page == 3 {
                            VStack(alignment: .leading) {
                                Image("red_prob_1")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 260)
                                
                                Image("red_prob_2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150)
                            }
                        }
                        
                        if page == 4 {
                            Spacer().frame(height: 21)
                            RoundedRectangle(cornerRadius: 12)
                                .fill(AppColors.primaryRed)
                                .frame(width: 90, height: 90)
                        }
                        
                        if page == 7 {
                            Image("ev_formula")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                            
                            Spacer().frame(height: 21)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Image("story_expected_value")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300)
                                
                                Image("story_expected_result")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300)
                            }
                        }
                        
                        if page == 9 {
                            randomAnimation()
                        }
                    }
                }
            }
            .frame(height: 500)
            .padding()
            .opacity(level)
            .onAppear {
                withAnimation(Animation.easeIn(duration: 0.5)) {
                    level = 1
                }
            }
            .onDisappear { level = 0 }
            
            Spacer()
            
            HStack(alignment: .center) {
                Button {
                    prev()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.blue)
                        .frame(width: 60, height: 40)
                }
                .background(.white)
                .foregroundColor(.black)
                .cornerRadius(12)
                .opacity(page == 0 ? 0 : 1)
                
                Spacer().frame(width: 110)
                Button {
                    if page == 10 {
                        tab = 2
                    } else {
                        next()
                    }
                } label: {
                    if page == 10 {
                        Text("Play")
                            .foregroundColor(.blue)
                            .frame(width: 60, height: 40)
                    } else {
                        Image(systemName: "arrow.right")
                            .foregroundColor(.blue)
                            .frame(width: 60, height: 40)
                    }
                }
                .background(.white)
                .foregroundColor(.black)
                .cornerRadius(12)
            }
            
            Spacer().frame(height: 50)
        }
        .padding(20)
    }
    
    func getMarkdown(text: String) -> AttributedString {
        let markdownText: AttributedString = try! AttributedString(markdown: text)
        return markdownText
    }
    
    func next() {
        if Story.count - 1 > page {
            return page += 1
        }
        return
    }
    
    func prev() {
        if page - 1 >= 0 {
            return page -= 1
        }
    }
}


struct randomAnimation: View {
    @State var wins = 0
    @State var losses = 0
    @State var iterations = 0
    @State var currentCard: UInt = 1
    @State var isTimeRunning = false
    
    @State var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack {
                Text("Wins: \(wins)")
                Spacer().frame(width: 50)
                Text("Losses: \(losses)")
            }
            
            Spacer().frame(height: 60)
            
            CardView(currentCard)
            
            Spacer().frame(height: 40)
            
            Button("Generate") {
                reset()
                startTimer()
            }
            .frame(width: 100, height: 40)
            .background(.white)
            .cornerRadius(8)
        }
        .onReceive(timer) {_ in
            if isTimeRunning {
                if iterations < 200 {
                    drawRandomCard()
                } else {
                    stopTimer()
                }
            }
        }
    }
    
    func drawRandomCard() {
        currentCard = UInt.random(in: 1...14)
        if CardPreset.REDS.contains(currentCard) {
            self.wins += 1
        } else {
            self.losses += 1
        }
        self.iterations += 1
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.isTimeRunning = true
        self.timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    }
    
    func reset() {
        self.iterations = 0
        self.wins = 0
        self.losses = 0
    }
}
