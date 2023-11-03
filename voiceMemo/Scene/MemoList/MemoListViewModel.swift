//
//  MemoListViewModel.swift
//  voiceMemo
//
//  Created by Terry on 2023/10/12.
//

import Foundation

class MemoListViewModel: ObservableObject {
    @Published var memos: [Memo]
    @Published var isEditMode: Bool
    @Published var removeMemos: [Memo]
    @Published var isDisplayRemoveMemoAlert: Bool

    var removeMemoCount: Int {
        return removeMemos.count
    }

    var navigationBarRightBtnMode: NavigationBtnType {
        isEditMode ? .complete : .edit
    }


    init(
        memos: [Memo] = [],
        isEditMode: Bool = false,
        removeMemos:[Memo] = [],
        isDisplayRemoveMemoAlert: Bool = false
    ){
        self.memos = memos
        self.isEditMode = isEditMode
        self.removeMemos = removeMemos
        self.isDisplayRemoveMemoAlert = isDisplayRemoveMemoAlert
    }
}

extension MemoListViewModel {
    func addMemo(_ memo: Memo){
        memos.append(memo)
    }

    func updateMemo(_ memo: Memo){
        if let index = memos.firstIndex(where: {$0.id == memo.id }) {
            memos[index] = memo
        }
    }

    func removeMemo(_ memo: Memo){
        if let index = memos.firstIndex(where: {$0.id == memo.id }) {
            memos.remove(at: index)
        }
    }

    func navigationRightBtnTapped() {
        if isEditMode {
            if removeMemos.isEmpty {
                isEditMode = false
            }else {
                // 삭제 확인 얼럿 상태값 변경을 위한 메소드 호출
                setIsDisplayRemoveMemoAlert(true)
            }
        } else {
            isEditMode = true
        }
    }

    func setIsDisplayRemoveMemoAlert(_ isDisplay: Bool){
        isDisplayRemoveMemoAlert = isDisplay
    }

    func memoRemoveSelectedBoxTapped(_ memo: Memo){
        if let index = removeMemos.firstIndex(of: memo) {
            removeMemos.remove(at: index)
        } else {
            removeMemos.append(memo)
        }
    }

    func removeBtnTapped(){
        memos.removeAll { memo in
            removeMemos.contains(memo)
        }
        removeMemos.removeAll()
        isEditMode = false
    }
}
