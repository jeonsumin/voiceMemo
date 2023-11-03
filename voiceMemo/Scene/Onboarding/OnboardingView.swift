//
//  OnboardingView.swift
//  voiceMemo
//
//  Created by Terry on 2023/10/12.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var pathModel = PathModel()
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    @StateObject private var todoListViewModel = TodoListViewModel()
    @StateObject private var memoListViewModel = MemoListViewModel()

    var body: some View {
        NavigationStack(path: $pathModel.paths) {
            OnboardingContentView(onboardingViewModel: onboardingViewModel)
                .navigationDestination( // 어디로 갈지를 결정
                    for: PathType.self, // pathType으로 설정
                    destination: { pathType in
                        switch pathType {
                            case .HomeView:
                                HomeView()
                                    .navigationBarBackButtonHidden()
                                    .environmentObject(todoListViewModel)
                                    .environmentObject(memoListViewModel)
                            case .todoView:
                                TodoView()
                                    .navigationBarBackButtonHidden()
                                    .environmentObject(todoListViewModel)
                            case let .memoView(isCreateMode, memo):
                                MemoView(
                                    memoViewModel: isCreateMode
                                    ? .init(memo: .init(title: "", content: "", date: Date()))
                                    : .init(memo: memo ?? .init(title: "", content: "", date: Date())), isCreateMode: isCreateMode
                                )
                                .navigationBarBackButtonHidden()
                                .environmentObject(memoListViewModel)
                        }
                    }
                )
        }
        //pathModel을 다른쪽에서 같이 사용하기 위해서 environmentObject에 pathModel주입
        .environmentObject(pathModel)
    }
}

//MARK: - 온보딩 컨텐츠 뷰
private struct OnboardingContentView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel

    fileprivate init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
    }

    fileprivate var body: some View {
        VStack {
            //온보딩 셀 리스트 뷰
            OnboardingCellListView(onboardingViewModel: onboardingViewModel)

            // 시작버튼 뷰
            Spacer()

            StartBtnView()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

//MARK: - 온보딩 셀 리스트 뷰
private struct OnboardingCellListView: View {
    @ObservedObject private var onboardingViewModel: OnboardingViewModel
    @State private var selectedIndex: Int

    fileprivate init(
        onboardingViewModel: OnboardingViewModel,
        selectedIndex: Int = 0
    ) {
        self.onboardingViewModel = onboardingViewModel
        self.selectedIndex = selectedIndex
    }

    fileprivate var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(Array(onboardingViewModel.onboardingContents.enumerated()), id: \.element) { index, onboardingContent in
                //온보딩 셀
                OnboardingCellView(onboardingContent: onboardingContent)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5)
        .background(selectedIndex % 2 == 0 ? Color.customSky : Color.customBackgroundGreen)
        .clipped()
    }
}

// MARK: - 온보딩 셀 뷰
private struct OnboardingCellView: View {
    private var onboardingContent: OnboardingContent

    fileprivate init(onboardingContent: OnboardingContent) {
        self.onboardingContent = onboardingContent
    }

    fileprivate var body: some View {
        VStack {
            Image(onboardingContent.imageFileName)
                .resizable()
                .scaledToFit()

            HStack {
                Spacer()

                VStack {
                    Spacer()
                        .frame(height: 46)

                    Text(onboardingContent.title)
                        .font(.system(size: 16, weight: .bold))

                    Spacer()
                        .frame(height: 5)

                    Text(onboardingContent.subTitle)
                        .font(.system(size: 16))
                }
                Spacer()
            }
            .background(Color.customWhite)
            .cornerRadius(0)
        }
        .shadow(radius: 10)
    }
}

//MARK: - 시작 버튼
private struct StartBtnView:View {
    @EnvironmentObject private var pathModel: PathModel

    fileprivate var body: some View {
        Button(
            action: {
                pathModel.paths.append(.HomeView)
            },
            label: {
                HStack {
                    Text("시작하기")
                        .font(.system(size: 16))
                        .foregroundColor(.customGreen)

                    Image("startHome")
                        .renderingMode(.template)
                        .foregroundColor(.customGreen)
                }
            }
        )
        .padding(.bottom, 50)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
