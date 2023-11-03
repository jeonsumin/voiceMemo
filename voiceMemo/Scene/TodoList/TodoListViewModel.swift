//
//  TodoListViewModel.swift
//  voiceMemo
//
//  Created by Terry on 2023/10/12.
//

import Foundation

class TodoListViewModel: ObservableObject {
    @Published var todos:[Todo]
    @Published var isEditMode: Bool
    ///삭제 예정 투두를 담는 배열
    @Published var removeTodos: [Todo]
    @Published var isDisplayRemoveTodoAlert: Bool

    var removeTodosCount: Int {
        return removeTodos.count
    }

    var navigationBarRightBtnMode: NavigationBtnType {
        isEditMode ? .complete : .edit
    }

    init(
        todos: [Todo] = [],
        isEditMode: Bool = false,
        removeTodos: [Todo] = [],
        isDisplayRemoveTodoAlert: Bool = false
    ) {
        self.todos = todos
        self.isEditMode = isEditMode
        self.removeTodos = removeTodos
        self.isDisplayRemoveTodoAlert = isDisplayRemoveTodoAlert
    }

}

extension TodoListViewModel {
    ///투두리스트 선택 메소드
    func selectedBoxTapped(_ todo: Todo){
        if let index = todos.firstIndex(where: { $0 == todo }) {
            todos[index].selected.toggle()
        }
    }

    /// 투두리스트 추가 메소드
    func addTodo(_ todo: Todo) {
        todos.append(todo)
    }

    func navigationRightBtnTapped(){
        if isEditMode {
            if removeTodos.isEmpty {
                isEditMode = false
            }else {
                //얼럿을 불러준다!
                setIsDisplayRemoveTodoAlert(true)
            }
        } else {
            isEditMode = true
        }
    }

    func setIsDisplayRemoveTodoAlert(_ isDisplay: Bool) {
        isDisplayRemoveTodoAlert = isDisplay
    }

    func todoRemoveSelectedBoxTapped(_ todo: Todo){
        if let index = removeTodos.firstIndex(of: todo){ // 삭제 배열에 선택된 투두리스트가 있는지 체크
            removeTodos.remove(at: index)
        } else {
            removeTodos.append(todo)
        }
    }
    /// 투두 리스트 제거 메소드
    func removeBtnTapped(){
        todos.removeAll { todo in
            removeTodos.contains(todo)
        }
        removeTodos.removeAll()
        isEditMode = false 
    }
}
