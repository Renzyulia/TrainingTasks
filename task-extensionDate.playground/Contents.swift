import UIKit

extension Date {
  var isSaturday: Bool {
    let calendar = Calendar.current
    return calendar.component(.weekday, from: self) == 7
  }
}

let dateComponents = DateComponents(calendar: Calendar.current, year: 2022, month: 8, day: 6)
let calendar = Calendar.current
let today = calendar.date(from: dateComponents)
today!.isSaturday
