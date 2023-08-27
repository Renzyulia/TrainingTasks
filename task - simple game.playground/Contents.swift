import UIKit

enum ElementsGame: Equatable {
  case player(Int)
  case steps
  case finish
}

func rollDice() -> Int {
  return Int.random(in: 1...6)
}

var gameField = [ElementsGame]()
gameField.append(ElementsGame.player(1))
gameField.append(ElementsGame.player(2))
gameField.append(ElementsGame.player(3))
gameField.append(ElementsGame.steps)
gameField.append(ElementsGame.steps)
gameField.append(ElementsGame.steps)
gameField.append(ElementsGame.steps)
gameField.append(ElementsGame.steps)
gameField.append(ElementsGame.steps)
gameField.append(ElementsGame.steps)
gameField.append(ElementsGame.steps)
gameField.append(ElementsGame.steps)
gameField.append(ElementsGame.steps)
gameField.append(ElementsGame.steps)
gameField.append(ElementsGame.finish)

let playerOne: ElementsGame = .player(1)
let playerTwo: ElementsGame = .player(2)
let playerThree: ElementsGame = .player(3)

func play(player: ElementsGame) {
  var number = rollDice()
  let position = gameField.firstIndex(of: player)

  guard position! + number < gameField.count - 1 else {
    gameField[gameField.count - 1] = player
    gameField[position!] = ElementsGame.steps
    return print("\(player) win!")
  }

  while gameField[position! + number] != ElementsGame.steps && (position! + number) < gameField.count {
    number += 1
  }
  gameField[position! + number] = player
  gameField[position!] = ElementsGame.steps
}
