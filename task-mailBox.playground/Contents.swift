import UIKit

protocol Mailbox {
  func send(_ message: String)
}

final class RemoteMailbox: Mailbox {
  private(set) var sentMessages = [String]()

  func send(_ message: String) {
    sentMessages.append(message)
  }
}

final class FilteringPersonalInformationMailbox: Mailbox {
  let mailBox: Mailbox

  init (mailBox: Mailbox) {
    self.mailBox = mailBox
  }

  func send(_ message: String) {
    if message.contains("password") {
       return
    } else {
      mailBox.send(message)
    }
  }
}

final class FilteringSuspiciousLinksMailbox: Mailbox {
  var mailBox: Mailbox
  
  init (mailBox: Mailbox) {
    self.mailBox = mailBox
  }
  
  func send(_ message: String) {
      if message.contains("hacker") || message.contains("bad_link") {
        return
      } else {
        mailBox.send(message)
    }
  }
}

// unit tests
func testRemoteMailboxStoresEveryGivenMessage() {
  let mailbox = RemoteMailbox()

  mailbox.send("message1")
  mailbox.send("message2")

  assert(mailbox.sentMessages == ["message1", "message2"])
}

func testFilteringPersonalInformationMailboxStopsSendingMessagesWithPassword() {
  let originalMailbox = RemoteMailbox()
  let filteringMailbox = FilteringPersonalInformationMailbox(mailBox: originalMailbox)

  filteringMailbox.send("message1")
  filteringMailbox.send("password")
  filteringMailbox.send("password")

  assert(originalMailbox.sentMessages.count == 1)
  assert(originalMailbox.sentMessages.first == "message1")
}

func testFilteringSuspiciousLinksMailboxStopsSendingMessagesWithLink() {
  let originalMailbox = RemoteMailbox()
  let filteringMailbox = FilteringSuspiciousLinksMailbox(mailBox: originalMailbox)

  filteringMailbox.send("hacker.com")
  filteringMailbox.send("normal message")
  filteringMailbox.send("bad_link.org")

  assert(originalMailbox.sentMessages.count == 1)
  assert(originalMailbox.sentMessages.first == "normal message")
}

func testCode() {
  testRemoteMailboxStoresEveryGivenMessage()
  testFilteringPersonalInformationMailboxStopsSendingMessagesWithPassword()
  testFilteringSuspiciousLinksMailboxStopsSendingMessagesWithLink()
  print("Testing is done!")
}

testCode()
