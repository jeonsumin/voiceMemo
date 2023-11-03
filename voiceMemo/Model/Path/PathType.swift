//
//  PathType.swift
//  voiceMemo
//
//  Created by Terry on 2023/10/12.
//

enum PathType: Hashable {
    case HomeView // 스택이 쌓일 수 있는 경로를 설정
    case todoView
    case memoView(isCreateMode: Bool, memo: Memo?)
}
