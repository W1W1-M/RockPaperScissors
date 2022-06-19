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
    @State var AiSelectedItem: Item = .rock
    @State var AiWantedResult: Result = .tie
    @State var playerSelectedItem: Item = .rock
    @State var playerScore: Int = 0
    @State var gameRounds: Int = 0
    @State var alertPresented: Bool = true
    @State var alertToPresent: AlertType = .welcome
    var maxGameRounds: Int = 10
    enum Item: String, CaseIterable {
        case rock = "Rock 🪨"
        case paper = "Paper 📄"
        case scissors = "Scissors ✂️"
    }
    enum Result: String, CaseIterable {
        case win = "🥇 Win"
        case lose = "🥈 Lose"
        case tie = "🏁 Tie"
    }
    enum AlertType: String {
        case won = "Won 🥇"
        case lost = "Lost 🥈"
        case gameOver = "Game Over"
        case welcome = "Welcome"
    }
// MARK: - Methods
    func checkRoundResult() {
        switch playerSelectedItem {
        case .rock:
            switch AiSelectedItem {
            case .rock:
                switch AiWantedResult {
                case .win:
                    updatePlayerScore(roundResult: .lose)
                case .lose:
                    updatePlayerScore(roundResult: .lose)
                case .tie:
                    updatePlayerScore(roundResult: .win)
                }
            case .paper:
                switch AiWantedResult {
                case .win:
                    updatePlayerScore(roundResult: .win)
                case .lose:
                    updatePlayerScore(roundResult: .lose)
                case .tie:
                    updatePlayerScore(roundResult: .lose)
                }
            case .scissors:
                switch AiWantedResult {
                case .win:
                    updatePlayerScore(roundResult: .lose)
                case .lose:
                    updatePlayerScore(roundResult: .win)
                case .tie:
                    updatePlayerScore(roundResult: .lose)
                }
            }
        case .paper:
            switch AiSelectedItem {
            case .rock:
                switch AiWantedResult {
                case .win:
                    updatePlayerScore(roundResult: .lose)
                case .lose:
                    updatePlayerScore(roundResult: .win)
                case .tie:
                    updatePlayerScore(roundResult: .lose)
                }
            case .paper:
                switch AiWantedResult {
                case .win:
                    updatePlayerScore(roundResult: .lose)
                case .lose:
                    updatePlayerScore(roundResult: .lose)
                case .tie:
                    updatePlayerScore(roundResult: .win)
                }
            case .scissors:
                switch AiWantedResult {
                case .win:
                    updatePlayerScore(roundResult: .win)
                case .lose:
                    updatePlayerScore(roundResult: .lose)
                case .tie:
                    updatePlayerScore(roundResult: .lose)
                }
            }
        case .scissors:
            switch AiSelectedItem {
            case .rock:
                switch AiWantedResult {
                case .win:
                    updatePlayerScore(roundResult: .win)
                case .lose:
                    updatePlayerScore(roundResult: .lose)
                case .tie:
                    updatePlayerScore(roundResult: .lose)
                }
            case .paper:
                switch AiWantedResult {
                case .win:
                    updatePlayerScore(roundResult: .lose)
                case .lose:
                    updatePlayerScore(roundResult: .win)
                case .tie:
                    updatePlayerScore(roundResult: .lose)
                }
            case .scissors:
                switch AiWantedResult {
                case .win:
                    updatePlayerScore(roundResult: .lose)
                case .lose:
                    updatePlayerScore(roundResult: .lose)
                case .tie:
                    updatePlayerScore(roundResult: .win)
                }
            }
        }
        addGameRound()
        checkLastRound()
    }
    func addGameRound() {
        gameRounds += 1
    }
    func updatePlayerScore(roundResult: Result) {
        switch roundResult {
        case .win:
            playerScore += 1
            alertToPresent = .won
        case .lose:
            playerScore -= 1
            alertToPresent = .lost
        case .tie:
            playerScore = playerScore
        }
    }
    func resetRound() {
        AiSelectedItem = Item.allCases[Int.random(in: 0...2)]
        AiWantedResult = Result.allCases[Int.random(in: 0...2)]
    }
    func resetGame() {
        playerScore = 0
        gameRounds = 0
        resetRound()
    }
    func checkLastRound() {
        if gameRounds == maxGameRounds {
            alertToPresent = .gameOver
            alertPresented = true
        }
    }
// MARK: - ContentView body
    var body: some View {
        ZStack {
            LinearGradient(colors: [.gray, .yellow], startPoint: .bottom, endPoint: .top).ignoresSafeArea()
            ScrollView {
                VStack {
                    VStack(spacing: 10) {
                        Text("Happy HAL").font(.largeTitle.bold())
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
                                Text("HAL choses to").font(.title)
                                Spacer()
                            }
                            HStack(alignment: .bottom) {
                                Spacer()
                                Text(AiWantedResult.rawValue)
                                Spacer()
                                Text("with").font(.title)
                                Spacer()
                                Text(AiSelectedItem.rawValue)
                                Spacer()
                            }.font(.title.bold())
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
                                    playerSelectedItem = Item
                                    checkRoundResult()
                                    alertPresented = true
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
                        }.alert(isPresented: $alertPresented) {
                            switch alertToPresent {
                            case .won:
                                return Alert(
                                    title: Text("Round \(gameRounds) 🙌"),
                                    message: Text("You made HAL happy, you get 1 point"),
                                    dismissButton: .default(
                                        Text("Next Round"),
                                        action: {
                                            resetRound()
                                        }
                                    )
                                )
                            case .lost:
                                return Alert(
                                    title: Text("Round \(gameRounds) 😰"),
                                    message: Text("HAL didn't like that, you lose 1 point"),
                                    dismissButton: .default(
                                        Text("Next Round"),
                                        action: {
                                            resetRound()
                                        }
                                    )
                                )
                            case .gameOver:
                                return Alert(
                                    title: Text("Game Over"),
                                    message: Text("You scored \(playerScore) points"),
                                    dismissButton: .default(
                                        Text("New Game"),
                                        action: {
                                            resetGame()
                                        }
                                    )
                                )
                            case .welcome:
                                return Alert(
                                    title: Text("Welcome to Happy HAL"),
                                    message: Text("Satisfy HAL to earn points"),
                                    dismissButton: .default(
                                        Text("Start Game"),
                                        action: {
                                            resetGame()
                                        }
                                    )
                                )
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
