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
    @State var AiMustLoose: Bool = false
    @State var playerItem: Item = .rock
    @State var playerScore: Int = 0
    @State var totalGameRounds: Int = 10
    @State var gameRounds: Int = 0
    @State var roundResult: Result = .tie
    enum Item: CaseIterable {
        case rock
        case paper
        case scissors
    }
    enum Result {
        case won
        case lost
        case tie
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
        Text("Hello, world!")
            .padding()
    }
}
// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
