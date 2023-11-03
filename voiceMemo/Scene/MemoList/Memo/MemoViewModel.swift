//
//  MemoViewModel.swift
//  voiceMemo
//
//  Created by Terry on 2023/10/12.
//

import Foundation

class MemoViewModel: ObservableObject {
    @Published var memo: Memo

    init(memo: Memo){
        self.memo = memo
    }
}
