//
//  Int+Extension.swift
//  voiceMemo
//
//  Created by Terry on 2023/10/16.
//

import Foundation

extension Int {
    var formattedTimeString: String {
        let time = Time.fromSeconds(self)
        let hoursString = String(format: "%02d", time.hours)
        let minutesString = String(format: "%02d", time.minutes)
        let secondsString = String(format: "%02d", time.seconds)

        return "\(hoursString) : \(minutesString) : \(secondsString)"
    }

    var formattedSettingsTime: String {
        let currentDate = Date()
        let settingsDate = currentDate.addingTimeInterval(TimeInterval(self))

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.dateFormat = "HH:mm"

        let formattedTime = formatter.string(from: settingsDate)

        return formattedTime
    }
}
