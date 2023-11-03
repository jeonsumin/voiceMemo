//
//  TodoListView.swift
//  voiceMemo
//
//  Created by Terry on 2023/10/12.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject private var pathModel: PathModel
    //투두뷰에서도 todolistViewModel을 사용하기 위해 @EnvironmentObject로 선언
    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @EnvironmentObject private var homeViewModel: HomeViewModel

    var body: some View {
        ZStack {
            //투두 셀 리스트
            VStack {
                if !todoListViewModel.todos.isEmpty {
                    CustomNavigationBar(
                        isDisplayLeftBtn: false,
                        rightBtnAction: {
                            todoListViewModel.navigationRightBtnTapped()
                        },
                        rightBtnType: todoListViewModel.navigationBarRightBtnMode
                    )
                } else {
                    Spacer()
                        .frame(height: 30)
                }
                TitleView()
                    .padding(.top,20)

                if todoListViewModel.todos.isEmpty {
                    AnnouncementView()
                } else {
                    TodoListContentView()
                        .padding(.top, 20)
                }

            }
            WriteTodoBtnView()
                .padding(.trailing,20)
                .padding(.bottom,50)
        }
        .alert(
            "To do list \(todoListViewModel.removeTodosCount)개 삭제하시겠습니까?",
            isPresented: $todoListViewModel.isDisplayRemoveTodoAlert
        ){
            Button("삭제", role: .destructive) {
                todoListViewModel.removeBtnTapped()
            }

            Button("취소", role: .cancel){ }
        }
        .onChange(
            of: todoListViewModel.todos) { todos in
                homeViewModel.setTodosCount(todos.count)
            }
    }
}

//MARK: - 타이틀 뷰
private struct TitleView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel

    fileprivate var body: some View {
        HStack{
            if todoListViewModel.todos.isEmpty {
                Text("To do list를\n추가해 보세요.")
            } else {
                Text("To do list \(todoListViewModel.todos.count)개가\n있습니다. ")
            }
            Spacer()
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}

//MARK: - TodoList 안내 뷰
private struct AnnouncementView: View {
    fileprivate var body: some View {
        VStack(spacing:15){
            Spacer()

            Image("pencil")
                .renderingMode(.template)

            Text("\"매일 아침 5시 운동!\"")
            Text("\"내일 8시 수강 신청 \"")
            Text("\"1시 반 점심 약속\"")

            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(.customGray2)
    }
}

//MARK: - TdooList 컨텐츠 뷰
private struct TodoListContentView: View {
    @EnvironmentObject private var todoListViewModel: TodoListViewModel

    fileprivate var body: some View {
        VStack{
            HStack {
                Text("할일 목록")
                    .font(.system(size: 16,weight: .bold))
                    .padding(.leading, 20)

                Spacer()
            }
            ScrollView(.vertical) {
                VStack(spacing:0){
                    Rectangle()
                        .fill(Color.customGray0)
                        .frame(height: 1)

                    ForEach(todoListViewModel.todos, id: \.self) { todo in
                        // TODO: - Todo 셀 뷰 todo 넣어서 뷰 호출
                        todoCellView(todo: todo)
                    }
                }
            }
        }
    }
}

//MARK: - Todo Cell View
private struct todoCellView: View {

    @EnvironmentObject private var todoListViewModel: TodoListViewModel
    @State private var isRemoveSelected: Bool
    private var todo: Todo

    fileprivate init(
        isRemoveSelected: Bool = false,
        todo: Todo
    ){
        _isRemoveSelected = State(initialValue: isRemoveSelected)
        self.todo = todo
    }

    fileprivate var body: some View {
        VStack(spacing:20){
            HStack{
                if !todoListViewModel.isEditMode {
                    Button(
                        action: {
                            todoListViewModel.selectedBoxTapped(todo)
                        },
                        label: {
                            todo.selected ? Image("selectedBox") : Image("unSelectedBox")
                        }
                    )
                }

                VStack(alignment: .leading,spacing: 5) {
                    Text(todo.title)
                        .font(.system(size: 16))
                        .foregroundColor(todo.selected ? .customIconGray : .customBlack)
                        .strikethrough(todo.selected)

                    Text(todo.converedDayAndTime)
                        .font(.system(size: 16))
                        .foregroundColor(.customIconGray)
                }

                Spacer()

                if todoListViewModel.isEditMode {
                    Button {
                        isRemoveSelected.toggle()
                        todoListViewModel.todoRemoveSelectedBoxTapped(todo)
                    } label: {
                        isRemoveSelected ? Image("selectedBox") : Image("unSelectedBox")
                    }
                }
            }
            .padding(.horizontal,20)
            .padding(.top, 10)

            Rectangle()
                .fill(Color.customGray0)
                .frame(height: 1)
        }
    }
}

//MARK: - Todo 작성 버튼 뷰
private struct WriteTodoBtnView: View {
    @EnvironmentObject private var pathModel: PathModel

    fileprivate var body: some View {
        VStack {
            Spacer()

            HStack {
                Spacer()

                Button {
                    pathModel.paths.append(.todoView)
                } label: {
                    Image("writeBtn")
                }

            }
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
            .environmentObject(PathModel())
            .environmentObject(TodoListViewModel())
    }
}
