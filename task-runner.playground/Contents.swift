import UIKit

struct Position {
  let x: Int
  let y: Int
}

class AlTrainer {
  var position = Position(x: 0, y: 0) {
    didSet {
      let time = Double(5)
      let distance = (sqrt(Double(pow((Double (position.x - oldValue.x)),2) + (pow((Double(position.y - oldValue.y)),2)))))
      let speed = Int(distance / time)
      let averageSpeed = 2
      
      if speed < averageSpeed {
        print ("Run faster")
      } else {
        print("Run slover")
      }
    }
 }
}

