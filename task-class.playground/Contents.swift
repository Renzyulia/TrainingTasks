import UIKit

class Plane {
  let number: String
  let company: String
  var weight: Int {
    return 1500
  }
  let passengerRamp: Bool
  
  init (number: String, company: String, passengerRamp: Bool) {
    self.number = number
    self.company = company
    self.passengerRamp = passengerRamp
  }
}

class PassengerPlane: Plane {
  let quantityOfPassengers: Int
  override var weight: Int {
    return super.weight + (quantityOfPassengers * 70)
  }
  init(quantityOfPassengers: Int, number: String, company: String, passengerRamp: Bool) {
    self.quantityOfPassengers = quantityOfPassengers
    super.init(number: number, company: company, passengerRamp: passengerRamp)
  }
}

class CargoPlane: Plane {
  let cargoWeight: Int
  override var weight: Int {
    return super.weight + cargoWeight
  }
  init(number: String, company: String, cargoWeight: Int, passengerRamp: Bool) {
    self.cargoWeight = cargoWeight
    super.init(number: number, company: company, passengerRamp: passengerRamp)
  }
}
