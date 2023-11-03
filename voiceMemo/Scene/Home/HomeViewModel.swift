//
//  HomViewModel.swift
//  voiceMemo
//
//  Created by Terry on 2023/11/02.
//

import Foundation

class HomeViewModel: ObservableObject {
    //MARK: - Properties
    @Published var selectedTab: Tab
    @Published var todosCount: Int
    @Published var memoCount: Int
    @Published var voiceRecoderCount: Int

    init(
        selectedTab: Tab = .voiceRecorder,
        todosCount: Int = 0,
        memoCount: Int = 0,
        voiceRecoderCount: Int = 0
    ) {
        self.selectedTab = selectedTab
        self.todosCount = todosCount
        self.memoCount = memoCount
        self.voiceRecoderCount = voiceRecoderCount
    }
}


extension HomeViewModel {
    func setTodosCount(_ count: Int){
        todosCount = count
    }

    func setMemosCount(_ count: Int){
        memoCount = count
    }

    func setVoiceRecordersCount(_ count: Int){
        voiceRecoderCount = count
    }


    //tab변경 메소드
    func changeSelectedTab(_ tab: Tab){
        selectedTab = tab
    }
}
