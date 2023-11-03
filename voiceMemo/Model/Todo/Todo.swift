//
//  Todo.swift
//  voiceMemo
//
//  Created by Terry on 2023/10/12.
//

import Foundation

struct Todo: Hashable {
    var title: String
    var time: Date
    var day: Date
    var selected: Bool

    var converedDayAndTime: String {
        //ex) 오늘 - 오후 03:00
        String("\(day.formattedDay) - \(time.formattedTime)")
    }

}
