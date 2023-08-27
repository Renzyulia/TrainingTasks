import UIKit

class Bakery {
  var donuts: Int
  let location: String
  
  var donutsToSell = 0 {
  didSet {
    if donuts - donutsToSell >= 0 {
    print ("Someone in \(location) has bought \(donutsToSell) donuts")
    } else {
    print ("Someone in \(location) tried to buy \(donutsToSell) donuts, but there are not so many available")
    }
    }
  }
  
  var cookDonuts = 0 {
    willSet {
      print ("We had \(donuts) donuts")
    }
    didSet {
      print ("Our cook made \(cookDonuts) new donuts")
    donuts = cookDonuts + donuts
    }
  }

init (donuts: Int, location: String) {
  self.donuts = donuts
  self.location = location
 }
}

