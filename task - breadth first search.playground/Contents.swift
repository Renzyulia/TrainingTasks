import UIKit

var graph = [String : [String]]()
graph["you"] = ["alice", "bob", "claire"]
graph["bob"] = ["anuj", "peggy"]
graph["alice"] = ["peggy"]
graph["claire"] = ["thom", "jonny"]
graph["anuj"] = []
graph["peggy"] = []
graph["thom"] = []
graph["jonny"] = []


func personIsSeller(_ person: String) -> Bool {
    return person.contains("m")
}

func findMangoSeller(_ name: String) -> Bool {
    var searchQueue = [String]()
    searchQueue.append(contentsOf: graph[name]!)
    var searched = [String]()
    
    while searchQueue.isEmpty != true {
        let person = searchQueue.removeFirst()
        if searched.contains(person) == false {
            if personIsSeller(person) {
                print(person + " " + "is a mango seller")
                return true
            } else {
                searchQueue.append(contentsOf: graph[person]!)
                searched.append(person)
            }
        }
    }
    return false
}

findMangoSeller("you")
