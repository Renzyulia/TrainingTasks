import UIKit

protocol Observer {
  func someAction (hours: Int)
}

class Watchman: Observer {
  func someAction (hours: Int) {
    switch hours {
    case 9...20 : print("I am resting")
    case 21...23, 0...8: print("I am guarding a territory")
    default: return
    }
  }
}

class Farmer: Observer {
  func someAction(hours: Int) {
    switch hours {
    case 7...20: print("I am watching over my farm")
    case 20...23, 0...6: print("I am sleeping")
    default: return
    }
  }
}
    
class Clock {
  var observersCollection = [Observer]()
  
  func add(observer: Observer) {
    observersCollection.append(observer)
  }
  
  var hours = 0 {
    didSet {
      for observer in observersCollection {
        observer.someAction(hours: hours)
      }
    }
  }
}

let farmer = Farmer ()
let watchman = Watchman()

let clock = Clock()
clock.add(observer: farmer)
clock.add(observer: watchman)
clock.hours = 10

