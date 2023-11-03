//
//  Memo.swift
//  voiceMemo
//
//  Created by Terry on 2023/10/12.
//

import Foundation

struct Memo: Hashable {
    var title: String
    var content: String
    var date: Date
    var id = UUID()

    var convertDate: String {
        String("\(date.formattedDay) - \(date.formattedTime)")
    }
}
