import UIKit
import Darwin

// решение 1
protocol Office1 {
  var possibleServices1: [String] { get }
  var nextOffice1: Office1? { get set }
  
  func canPerform1 (service: String) -> Bool
  func perform1 (service: String)
}

class LocalOffice1: Office1 {
  var possibleServices1 = ["change card's PIN", "exchange currency"]
  var nextOffice1: Office1?
  
  func canPerform1(service: String) -> Bool {
    possibleServices1.contains(service) ? true : false
  }

  func perform1(service: String) {
    if canPerform1(service: service) == true {
      print("The service is provided")
    } else {
      print("We cannot process this service. The service has been transferred to next office")
      nextOffice1?.perform1(service: service)
    }
  }
}

class MainCityOffice1: Office1 {
  var nextOffice1: Office1?
  var possibleServices1 = ["open account", "change card's PIN", "exchange currency"]
  
  func canPerform1(service: String) -> Bool {
    possibleServices1.contains(service) ? true : false
  }
  
  func perform1(service: String) {
    if canPerform1(service: service) == true {
      print("The service is provided")
    } else {
      print("We cannot process this service. The service has been transferred to next office")
      nextOffice1?.perform1(service: service)
    }
  }
}

class Headquarters1: Office1 {
  var nextOffice1: Office1?
  var possibleServices1 = ["open account", "take a loan", "change card's PIN", "exchange currency"]
  
  func canPerform1(service: String) -> Bool {
    possibleServices1.contains(service) ? true : false
  }
  
  func perform1(service: String) {
    if canPerform1(service: service) {
      print("The service is provided")
    } else {
      print("The service cannot be executed in the bank")
    }
  }
}

class Reception1 {
  let office1: Office1

  init (office: Office1) {
    self.office1 = office
  }

  func service1(service: String, office: Office1) {
      office1.perform1(service: service)
    }
}

let localOffice1 = LocalOffice1()
let mainCityOffice1 = MainCityOffice1()
let headquarters1 = Headquarters1()

localOffice1.nextOffice1 = mainCityOffice1
mainCityOffice1.nextOffice1 = headquarters1


//решение 2: через использование алгоритма при вызове заявки
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
  

class Reception {
  var offices: [Office]
  
  init (offices: [Office]) {
    self.offices = offices
  }
  
  func add(office: Office) {
    self.offices.append(office)
  }
  
  func service(service: String) {
    for office in offices {
      if office.canPerform(service: service) == true {
        office.perform(service: service)
      }
    }
  }
// другой вариант
  func service2(service: String) {
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
let offices = [Office]()

let reception = Reception(offices: offices )
reception.add(office: localOffice)
reception.add(office: mainCityOffice)
reception.add(office: headquarters)

reception.service2(service: "take a loan")
reception.service2(service: "take a mortgage")
