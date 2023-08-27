import UIKit

protocol Recipient {
  var name: String { get }
  func send(_ message: String)
}

final class NamedRecipient: Recipient {
  let name: String
    
  init(name: String) {
    self.name = name
  }
  
  func send(_ message: String) {
    print("I've got this message from you: \(message)")
  }
}

enum WebStatus {
  case online
  case offline
}

// первый декоратор
final class AddingOnlineStatusRecipient: Recipient {
  let recipient: Recipient
  var status: WebStatus
  
  var name: String {
    switch status {
    case .online: return "\(recipient.name) (online)"
    case .offline: return "\(recipient.name) (offline)"
    }
  }
  
  func send(_ message: String) {
    recipient.send(message)
  }
  
  init(recipient: Recipient, status: WebStatus) {
    self.recipient = recipient
    self.status = status
  }
}

// второй декоратор
final class AddingNumberOfChatMembersRecipient: Recipient {
  let recipient: Recipient
  let membersInChat: Int
  
  var name: String {
    return recipient.name + " " + "(\(membersInChat))"
  }
  
  func send(_ message: String) {
    recipient.send(message)
  }
  
  init (recipient: Recipient, members: Int) {
    self.recipient = recipient
    self.membersInChat = members
  }
}
