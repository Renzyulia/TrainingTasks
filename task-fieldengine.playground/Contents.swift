import UIKit

protocol Farm {
    func harvest()
}

final class Fieldengine {
    private var durability: Int = 5

    func canWork() -> Bool {
        return durability > 0
    }
    func work() {
        durability -= 1
    }
}

protocol FieldengineFactory {
    func fieldengine() -> Fieldengine
}

class Factory: FieldengineFactory {
  func fieldengine() -> Fieldengine {
    let newFieldengine = Fieldengine()
    return newFieldengine
  }
}

class TheFarm: Farm {
  var feildengine: Fieldengine
  let factory: Factory
  
  func harvest() {
    if feildengine.canWork() == true {
      feildengine.work()
      print("Fieldengine harvests")
    } else {
      feildengine = factory.fieldengine()
      feildengine.work()
      print("New fieldengine harvests")
    }
  }
  
  init(factory: Factory) {
    self.feildengine = factory.fieldengine()
    self.factory = factory
  }
}

let fieldengine = Fieldengine()
let factory = Factory()
let farm = TheFarm(factory: factory)
farm.harvest()
farm.harvest()
farm.harvest()
farm.harvest()
farm.harvest()
farm.harvest()

