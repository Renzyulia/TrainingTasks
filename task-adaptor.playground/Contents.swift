import UIKit

protocol Office {
  var possibleServices: [String] { get }
  var nextOffice: Office? { get set }
  
  func canPerform (service: String) -> Bool
  func perform (service: String)
}

class LocalOffice: Office {
  var possibleServices = ["change card's PIN", "exchange currency"]
  var nextOffice: Office? = MainCityOffice()
  
  func canPerform(service: String) -> Bool {
    possibleServices.contains(service) ? true : false
  }

  func perform(service: String) {
    if canPerform(service: service) == true {
      print("The service is provided")
    }
  }
}

class MainCityOffice: Office {
  var nextOffice: Office? = Headquarters()
  var possibleServices = ["open account", "change card's PIN", "exchange currency"]
  
  func canPerform(service: String) -> Bool {
    possibleServices.contains(service) ? true : false
  }
  
  func perform(service: String) {
    if canPerform(service: service) == true {
      print("The service is provided")
    }
  }
}

class Headquarters: Office {
  var nextOffice: Office?
  var possibleServices = ["open account", "take a loan", "change card's PIN", "exchange currency"]
  
  func canPerform(service: String) -> Bool {
    possibleServices.contains(service) ? true : false
  }
  
  func perform(service: String) {
    if canPerform(service: service) == true {
      print("The service is provided")
    }
  }
}

// Код, написанный другим программистом, который мы должны через адаптер соединить с нашей частью кода
enum BankService {
  case takeLoan
  case changePIN
}

protocol ClientReception {
  func perform(_ service: BankService)
}

class Client {
  let knownReception: ClientReception
  
  init(knownReception: ClientReception) {
    self.knownReception = knownReception
  }
  
  func contactBank() {
    knownReception.perform(.takeLoan)
    knownReception.perform(.changePIN)
  }
}

//адаптер
class Adapter: ClientReception {
  var reception: Reception
  
  init(reseption: Reception) {
    self.reception = reseption
  }
  
  func perform(_ service: BankService) {
    switch service {
    case .takeLoan : reception.service(service: "take a loan")
    case .changePIN : reception.service(service: "change card's PIN")
    }
  }
}
  
class Reception {
  func service(service: String) {
    var office: Office? = LocalOffice()
    while office?.canPerform(service: service) != true {
      office = office?.nextOffice
      if office == nil {
        print("The service cannot be executed in the bank")
        break
      }
    office?.perform(service: service)
   }
  }
}

let localOffice = LocalOffice()
let mainCityOffice = MainCityOffice()
let headquarters = Headquarters()
let reception = Reception()

let adapter = Adapter(reseption: reception)
let client = Client(knownReception: adapter)
client.contactBank()

