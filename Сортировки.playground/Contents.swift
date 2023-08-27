import UIKit
import Darwin

let array1 = [7, 2, 6, 3, 9]

// сортировка пузырьком
func bubbleSort(_ array: [Int]) -> [Int] {
  var sortedArray = array
  
  for i in 0..<sortedArray.count - 1 {
    for j in 0..<sortedArray.count - 1 - i {
      if sortedArray[j] > sortedArray[j + 1] {
        let temp = sortedArray[j + 1]
        sortedArray[j + 1] = sortedArray[j]
        sortedArray[j] = temp
      }
    }
  }
  return sortedArray
}

// сортировка слиянием
func merge(leftPile: [Int], rightPile: [Int]) -> [Int] {
  var leftIndex = 0
  var rightIndex = 0
  var orderedPile = [Int]()
  orderedPile.reserveCapacity(leftPile.count + rightPile.count)
  
  while leftIndex < leftPile.count && rightIndex < rightPile.count {
    if leftPile[leftIndex] < rightPile[rightIndex] {
      orderedPile.append(leftPile[leftIndex])
      leftIndex += 1
    } else if leftPile[leftIndex] > rightPile[rightIndex] {
      orderedPile.append(rightPile[rightIndex])
      rightIndex += 1
    } else {
      orderedPile.append(leftPile[leftIndex])
      leftIndex += 1
      orderedPile.append(rightPile[rightIndex])
      rightIndex += 1
    }
  }
  while leftIndex < leftPile.count {
    orderedPile.append(leftPile[leftIndex])
    leftIndex += 1
  }
  while rightIndex < rightPile.count {
    orderedPile.append(rightPile[rightIndex])
    rightIndex += 1
  }
  return orderedPile
}

func mergeSort(_ array: [Int]) -> [Int] {
  guard array.count > 1 else { return array }
  
  let middleIndex = array.count / 2
  let leftArray = mergeSort(Array(array[0..<middleIndex]))
  let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
  
  return merge(leftPile: leftArray, rightPile: rightArray)
}

// быстрая сортировка
func quickSort(_ array: [Int]) -> [Int] {
  guard array.count > 1 else { return array }
  let pivot = array[array.count / 2]
  let less = array.filter {$0 < pivot}
  let equal = array.filter {$0 == pivot}
  let greater = array.filter {$0 > pivot}
  return quickSort(less) + equal + quickSort(greater)
}

// сортировка вставками
func insertionSort(_ array: [Int]) -> [Int] {
  var sortedArray = array
  
  for index in 1..<array.count {
    var currentIndex = index
    let temp = sortedArray[currentIndex]
    
    while currentIndex > 0 && temp < sortedArray[currentIndex - 1] {
      sortedArray[currentIndex] = sortedArray[currentIndex - 1]
      currentIndex -= 1
    }
    sortedArray[currentIndex] = temp
  }
  return sortedArray
}

// линейный поиск
func linearSearch(_ array: [Int], key: Int) -> Int? {
  for index in 0..<array.count {
    if array[index] == key {
      return index
    }
  }
  return nil
}

linearSearch(array1, key: 9)

//двоичный поиск (рекурсивная реализация)
// Важно! Массив должен быть отсортирован
func binarySearch(_ array: [Int], key: Int, range: Range <Int>) -> Int? {
  if range.lowerBound >= range.upperBound {
    return nil
  } else {
    let middleIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
    if array[middleIndex] > key {
      return  binarySearch(array, key: key, range: range.lowerBound..<middleIndex)
    } else if array[middleIndex] < key {
        return  binarySearch(array, key: key, range: middleIndex..<range.upperBound)
      } else {
        return middleIndex
      }
  }
}

let array2 = [1,3,4,6,7,15,23,34,67]
binarySearch(array2, key: 3, range: 0..<array1.count)

// двоичный поиск (итеративная реализация)
func binarySearch2(_ array: [Int], key: Int) -> Int? {
  var lowerBound = 0
  var upperBound = array.count
  
  while lowerBound < upperBound {
    let middleIndex = lowerBound + (upperBound - lowerBound) / 2
    
    if array[middleIndex] > key {
      upperBound = middleIndex
    } else if array[middleIndex] < key {
      lowerBound = middleIndex + 1
    } else {
      return middleIndex
    }
  }
  return nil
}

binarySearch2(array2, key: 67)

// стек stack
class Stack <T>{
  var array = [T]()
  
  var isEmpty: Bool {
    return array.isEmpty
  }
  
  var count: Int {
    return array.count
  }
  
  var top: T? {
    return array.last
  }
  
  func push(_ element: T) {
    array.append(element)
  }
  
  func pop() -> T? {
    array.popLast()
  }
}

// Очередь
// Реализация с неочень эффективным удалением элемента из очереди
class Queue <T> {
  var array = [T]()
  
  var isEmpty: Bool {
    return array.isEmpty
  }
  
  var count: Int {
    return array.count
  }
  
  var front: T? {
    return array.first
  }
  
  func enqueue(_ element: T) {
    array.append(element)
  }
  
  func dequeue() -> T? {
    if isEmpty {
      return nil
    } else {
      return array.removeFirst()
    }
  }
}

// Очередь
// Более эффективная реализация
class Queue1 <T> {
  var array = [T?]()
  var head = 0
  
  var isEmpty: Bool {
    return array.isEmpty
  }
  
  var count: Int {
    return array.count
  }
  
  var front: T? {
    if isEmpty {
      return nil
    } else {
      return array[head]
    }
  }
  
  func enqueue(_ element: T) {
    array.append(element)
  }
  
  func dequeue() -> T? {
    guard head < array.count, let element = array[head] else { return nil }
    array[head] = nil
    head += 1
    
    let percentage = Double(head) / Double(array.count)
    if array.count > 15 && percentage > 0.25 {
      array.removeFirst(head)
      head = 0
    }
    return element
  }
}

// cвязанный список
class Node {
  var value: Int
  var next: Node?
  weak var previous: Node?
  
  init (value: Int) {
    self.value = value
  }
}

class LinkedList {
  private var head: Node?
  private var tail: Node?
  
  var isEmpty: Bool {
    head == nil
  }
  
  var first: Node? {
    return head
  }
  
  var last: Node? {
    return tail
  }
  
  func append(value: Int) {
    let newNode = Node(value: value)
    
    if let tailNode = tail {
      newNode.previous = tailNode
      tailNode.next = newNode
    } else {
      head = newNode
    }
    tail = newNode
  }
  
  func nodeAt(index: Int) -> Node? {
    if index >= 0 {
      var node = head
      var i = index
      
      while node != nil {
        if i != 0 { return node }
        i -= 1
        node = node!.next
      }
    }
    return nil
  }
  
  func removeAll() {
    head = nil
    tail = nil
  }
  
  public func remove(node: Node) -> Int {
    let prev = node.previous
    let next = node.next

    if let prev = prev {
      prev.next = next
    } else {
      head = next
    }
    next?.previous = prev

    if next == nil {
      tail = prev
    }

    node.previous = nil
    node.next = nil
    return node.value
  }
}

extension LinkedList: CustomStringConvertible {
  var description: String {
    var text = "["
    var node = head
    
    while node != nil {
      text += "\(node!.value)"
      node = node!.next
      if node != nil { text += ", "}
    }
    return text + "]"
  }
}

let linkedList = LinkedList()
linkedList.append(value: 2)
linkedList.append(value: 5)
linkedList.append(value: 7)
linkedList.append(value: 9)
print(linkedList)

