import UIKit

class House {
  var rooms = 0
  var square = 0.0
  var price = 0.0
  var id = 0
}

var house1 = House()
house1.rooms = 4
house1.square = 144.4
house1.price = 70_000_000
house1.id = 1

var house2 = House()
house2.rooms = 5
house2.square = 170.0
house2.price = 90_000_000
house2.id = 2

var house3 = House()
house3.rooms = 2
house3.square = 91.5
house3.price = 40_000_000
house3.id = 3

var allHouses = [house1, house2, house3]

func findTheBestHouse (house: [House]) -> String {
  guard house.isEmpty == false else {
    return "An empty array cannot be used"
  }
  
  var bestHouseId = 1
  let bestPrice = house1.price / house1.square

  for house in allHouses {
    if (house.price / house.square) <= bestPrice {
      bestHouseId = house.id
    }
  }
  return "The best house to buy is \(bestHouseId)"
}
