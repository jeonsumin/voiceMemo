//
//  PathModel.swift
//  voiceMemo
//
//  Created by Terry on 2023/10/12.
//

import Foundation

class PathModel: ObservableObject {
    @Published var paths: [PathType]

    init(
        paths: [PathType] = []
    ) {
        self.paths = paths
    }
}
