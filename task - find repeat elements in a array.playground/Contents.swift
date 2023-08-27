import UIKit

func findRepeatElement(in array: [String]) -> Bool {
  var element = " "
  for i in 0..<array.count {
    element = array[i]
    for j in (i + 1)..<array.count {
      if array[j] == element {
        return true
      }
    }
  }
  return false
}

var array = ["House", "Mouse", "Sun", "Train", "Joke", "Train"]
findRepeatElement(in: array)

func findSumRecursion(_ array: [Int], index: Int) -> Int {
  let sum = array[index]
  while index < array.count - 1 {
    return sum + findSumRecursion(array, index: index + 1)
  }
  return sum
}

func findSum(_ array: [Int]) -> Int {
  findSumRecursion(array, index: 0)
}

let array1 = [2,5,6,10]
findSum(array1)

func sayNumberOfItems(in array: [Int]) -> Int {
  var numberOfItems = 0
  var newArray = array
  if newArray.isEmpty {
    return 0
  } else {
    newArray.remove(at: 0)
    numberOfItems = 1 + sayNumberOfItems(in: newArray)
  }
  return numberOfItems
}

let array2 = [10,2,6,5]
sayNumberOfItems(in: array2)

func findTheGreatestNumber(in array: [Int]) -> Int {
  var theGreatestNumber = 0
  for i in 0..<array.count {
    if array[i] > theGreatestNumber {
      theGreatestNumber = array[i]
    }
  }
  return theGreatestNumber
}

func findTheGreatestNumberRecursion(in array: [Int], index: Int) -> Int {
  var max = array[index]

  if index > array.count - 2 {
    return array[index]
  } else {
    let maximumFromTheRightPart = findTheGreatestNumberRecursion(in: array, index: index + 1)
    if array[index] < maximumFromTheRightPart {
      max = maximumFromTheRightPart
    }
  }
  return max
}

let array3 = [6,20,102,17,56]
findTheGreatestNumber(in: array3)
findTheGreatestNumberRecursion(in: array3, index: 0)
