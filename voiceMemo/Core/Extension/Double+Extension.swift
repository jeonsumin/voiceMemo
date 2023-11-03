//
//  Double+Extension.swift
//  voiceMemo
//
//  Created by Terry on 2023/10/12.
//

import Foundation

extension Double {
    //ex) 03:05
    var formattedTimeInterval: String {
        let totalSeconds = Int(self)
        let seconds = totalSeconds % 60
        let minutes = (totalSeconds / 60) % 60

        return String(format: "%02d:%02d", minutes,seconds)
    }
}
