//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Anu Mittal on 13/02/21.
//

import SwiftUI

enum Constants: String {
  case rock = "Rock"
  case paper = "Paper"
  case scissors = "Scissors"
}

struct ContentView: View {
  static let moves = ["Rock", "Paper", "Scissors"]
  @State var randomPick: String = ContentView.moves.randomElement() ?? Constants.paper.rawValue
  @State var challengeBool: Bool = Bool.random()
  @State private var alert = false
  @State private var currentScore: Int = 0
  @State private var roundCount = 1
  @State private var title = ""
  @State private var showScore = false
  
  let roundsPerGame = 10
  let hash: [String: String] = [
    Constants.rock.rawValue: Constants.paper.rawValue,
    Constants.paper.rawValue: Constants.scissors.rawValue,
    Constants.scissors.rawValue: Constants.rock.rawValue
  ]
  
  func addPoint(input: String) {
    if (hash[randomPick] == input && challengeBool) || (hash[randomPick] != input && !challengeBool) {
      self.currentScore += 1
      title = "Won :)"
    } else {
      self.currentScore -= 1
      title = "Lost :/"
    }
    if roundCount >= roundsPerGame {
      showScore = true
      roundCount = 0
    }
    alert = true
  }
  
  func prepareForNext() {
    roundCount += 1
    randomPick = ContentView.moves.randomElement() ?? Constants.paper.rawValue
    challengeBool = Bool.random()
  }
  
  func resetGame() {
    roundCount = 0
    currentScore = 0
    showScore = false
  }
  
  var body: some View {
    NavigationView {
      VStack(alignment: .center, spacing: 30) {
        
        Text(" \n \nCurrent score is: \(currentScore)/\(roundsPerGame)")
        
        Text("Current Pick is: \(randomPick)")
        
        Text("Challenge: \(challengeBool ? "Win": "Lose") \n \n")
        
        HStack(alignment: .center, spacing: 40) {
          Button(Constants.rock.rawValue, action: {
            addPoint(
              input: Constants.rock.rawValue)
          })
          Button(Constants.paper.rawValue, action: {
            addPoint(input: Constants.paper.rawValue)
          })
          Button(Constants.scissors.rawValue, action: {
            addPoint(input: Constants.scissors.rawValue)
          })
        }
        
        Spacer()
      }
      .navigationBarTitle("Game 🎮")
    }
    .alert(isPresented: $alert) {
      Alert(
        title: Text(title),
        message: Text(showScore ? "\(currentScore)/\(roundsPerGame)" : ""),
        dismissButton: .default(Text(showScore ? "New game" : "Next round")){
          prepareForNext()
          if showScore {
            resetGame()
          }
        })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}


// MARK - Phase 2

struct Game {
  var gameTask: Constants
  var challenge: Bool
  var rule: Rules
}

struct Rules {
  let roundsPerGame = 10
  let hash: [String: String] = [
    Constants.rock.rawValue: Constants.paper.rawValue,
    Constants.paper.rawValue: Constants.scissors.rawValue,
    Constants.scissors.rawValue: Constants.rock.rawValue
  ]
  
  func addPoint(quest: Constants, challenge: Bool, input: Constants) -> Bool {
    if (hash[quest.rawValue] == input.rawValue && challenge) || (hash[quest.rawValue] != input.rawValue && !challenge) {
      return true
    }
    return false
  }
}

