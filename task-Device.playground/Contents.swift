import UIKit

protocol Product {
  var price: Int { get }
}

class KeyBoard: Product {
  let price = 100
}

class Mouse: Product {
  let price = 50
}

class Package: Product {
  var price: Int {
    var totalPrice = 0
    for item in products {
     totalPrice = item.price + totalPrice
    }
    return totalPrice
  }
  
  var products: [Product]
  
  init (products: [Product]) {
    self.products = products
  }
}

let mouse = Mouse()
let keyboard = KeyBoard()
let package = Package (products: [mouse, keyboard])
package.price

