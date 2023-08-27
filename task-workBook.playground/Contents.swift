import UIKit

class WorkBook {
  class var maxPages: Int { return 12 }
  let text: Int
  let wordsOnPage: Int
  
  var pages: (Int, Int) { return
   (text / wordsOnPage, text % wordsOnPage)
  }
  
  var calcWorkBookQuantity: Int {
    var pagesQuantity: Int {
    if pages.1 != 0 {
      return (pages.0 + 1)
    } else {
      return pages.0
      }
    }
    if (pagesQuantity % WorkBook.maxPages) != 0 {
      return ((pagesQuantity / WorkBook.maxPages) + 1)
    } else {
      return (pagesQuantity / WorkBook.maxPages)
    }
  }
  init (text: Int, wordsOnPage: Int){
    self.text = text
    self.wordsOnPage = wordsOnPage
  }

 func sayQuantityWorkBooks() -> String {
    return "You will need \(calcWorkBookQuantity) workbooks"
  }
 lazy var result = sayQuantityWorkBooks()
}

let text = WorkBook (text: 130004, wordsOnPage: 50)
text.calcWorkBookQuantity
text.sayQuantityWorkBooks()


