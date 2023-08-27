import UIKit

protocol Policy {
    func allowsToReplace(oldTranslation: String, newTranslation: String) -> Bool
}

class AlwaysRewritePolicy: Policy {
  func allowsToReplace(oldTranslation: String, newTranslation: String) -> Bool {
    return true
  }
}

class NoRewritingPolicy: Policy {
  func allowsToReplace(oldTranslation: String, newTranslation: String) -> Bool {
    return false
  }
}

class Translater {
  var baseDictionary: [String : String]
  var userDictionary: [String: String]
  
  init (baseDictionary: [String: String], userDictionary: [String: String]) {
    self.baseDictionary = baseDictionary
    self.userDictionary = userDictionary
  }
  
  subscript (index: String) -> String? {
    get {
      if userDictionary[index] != nil {
       return userDictionary[index]
      }
      if baseDictionary[index] != nil {
       return baseDictionary[index]
      }
      return nil
    }
  }
  
  func canTranslate(index: String) -> Bool {
    userDictionary.keys.contains(index) || baseDictionary.keys.contains(index)
  }

  func addWord(translate: String, word: String, whatDo: Policy) {
      if canTranslate(index: translate) == true {
        if whatDo.allowsToReplace(oldTranslation: word, newTranslation: word) == true {
          userDictionary[translate] = word
          baseDictionary[translate] = nil
          print("The word is replaced")
        }
        if whatDo.allowsToReplace(oldTranslation: word, newTranslation: word) == false {
           print("This word is in the dictionary")
        }
      } else {
        print("The word \(translate) has been added to the dictionary")
      }
  }
}


