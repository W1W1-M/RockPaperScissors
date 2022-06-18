//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by William Mead on 18/06/2022.
//
// MARK: - Modules
import SwiftUI
// MARK: - Views
struct ContentView: View {
// MARK: - Properties
    @State var AiItem: Item = .rock
    @State var AiWantedResult: Result = .tie
    @State var AiMustLoose: Bool = false
    @State var playerItem: Item = .rock
    @State var playerScore: Int = 0
    @State var totalGameRounds: Int = 10
    @State var gameRounds: Int = 0
    @State var roundResult: Result = .tie
    enum Item: String, CaseIterable {
        case rock = "Rock 🪨"
        case paper = "Paper 📄"
        case scissors = "Scissors ✂️"
    }
    enum Result: String {
        case won = "Win 🥇"
        case lost = "Loose 🥈"
        case tie = "Tie 🏁"
    }
// MARK: - Methods
    func checkRoundResult() {
        switch playerItem {
        case .rock:
            switch AiItem {
            case .rock:
                updatePlayerScore(roundResult: .tie)
            case .paper:
                if AiMustLoose {
                    updatePlayerScore(roundResult: .lost)
                } else {
                    updatePlayerScore(roundResult: .won)
                }
            case .scissors:
                if AiMustLoose {
                    updatePlayerScore(roundResult: .won)
                } else {
                    updatePlayerScore(roundResult: .lost)
                }
            }
        case .paper:
            switch AiItem {
            case .rock:
                if AiMustLoose {
                    updatePlayerScore(roundResult: .won)
                } else {
                    updatePlayerScore(roundResult: .lost)
                }
            case .paper:
                updatePlayerScore(roundResult: .tie)
            case .scissors:
                if AiMustLoose {
                    updatePlayerScore(roundResult: .lost)
                } else {
                    updatePlayerScore(roundResult: .won)
                }
            }
        case .scissors:
            switch AiItem {
            case .rock:
                if AiMustLoose {
                    updatePlayerScore(roundResult: .lost)
                } else {
                    updatePlayerScore(roundResult: .won)
                }
            case .paper:
                if AiMustLoose {
                    updatePlayerScore(roundResult: .won)
                } else {
                    updatePlayerScore(roundResult: .lost)
                }
            case .scissors:
                updatePlayerScore(roundResult: .tie)
            }
        }
        addGameRound()
    }
    func addGameRound() {
        gameRounds += 1
    }
    func updatePlayerScore(roundResult: Result) {
        switch roundResult {
        case .won:
            playerScore += 1
        case .lost:
            playerScore -= 1
        case .tie:
            playerScore = playerScore
        }
    }
    func resetRound() {
        AiItem = Item.allCases[Int.random(in: 1...3)]
        AiMustLoose = Bool.random()
    }
    func resetGame() {
        playerScore = 0
        gameRounds = 0
    }
// MARK: - ContentView body
    var body: some View {
        ZStack {
            LinearGradient(colors: [.gray, .yellow], startPoint: .bottom, endPoint: .top).ignoresSafeArea()
            ScrollView {
                VStack {
                    VStack(spacing: 10) {
                        Text("Happy HAL").font(.largeTitle.bold())
                        Text("Satisfy HAL to earn points").font(.subheadline)
                        Text("\(playerScore) points")
                            .font(.title.bold())
                            .foregroundStyle(.regularMaterial)
                            .shadow(radius: 10)
                    }.padding(.vertical)
                    HALView()
                    VStack {
                        Text("HAL wants to play Rock, Paper, Scissors")
                            .font(.headline)
                            .foregroundStyle(.ultraThickMaterial)
                            .padding(.vertical)
                        VStack(spacing: 10) {
                            HStack {
                                Spacer()
                                Text("HAL choses").font(.title3)
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text(AiWantedResult.rawValue)
                                Spacer()
                                Text(AiItem.rawValue)
                                Spacer()
                            }.font(.largeTitle)
                        }.frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                    }
                    VStack {
                        Text("Pick carefully to make HAL happy")
                            .font(.headline)
                            .foregroundStyle(.ultraThickMaterial)
                            .padding(.vertical)
                        HStack {
                            ForEach(Item.allCases, id: \.self) { Item in
                                Button {
                                    
                                } label: {
                                    Text(Item.rawValue)
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                        .shadow(radius: 5)
                                }.padding()
                                .background(.yellow)
                                .clipShape(Capsule(style: .continuous))
                                .shadow(radius: 5)
                            }
                        }
                    }
                }.padding()
            }
        }
    }
}
// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
