//
//  QuizView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 7/30/24.
//

import SwiftUI

struct QuizView: View {
    let lsStructure : SpeakingStructure
    var isRepeat: Bool?
    
    @State private var isButtonDisabled = true
    @State private var isResultCorrect: Bool? = nil
    
    @State private var buttonText : String = "결과 보기"
    @State private var messageColor : Color = .gray2
    @State private var bottomBackColor : Color = .clear
    
    @State private var confirmationMessage : String = ""
    
    @State private var currentlyDragging: LSQuizComponent?
    
    @State private var quiz: [LSQuizComponent] = [
        .init(order: 3, content: "예를 들어, 저는 스트레스 받을 때마다 초콜릿을 먹습니다. 그러면 기분이 한결 나아지고, 피로도 풀리는 느낌이 들어요. 과학적으로도 초콜릿에 들어 있는 카카오 성분이 행복 호르몬인 세로토닌을 분비시킨다고 합니다."),
        .init(order: 2, content: "초콜릿은 기분을 좋게 하고 에너지를 즉각적으로 공급해줍니다."),
        .init(order: 4, content: "그래서 초콜릿은 맛있을 뿐만 아니라 기분을 좋게 만들어 주는 최고의 간식입니다."),
        .init(order: 1, content: "초콜릿은 최고의 간식이라고 생각해요."),
        
    ]
    
    @StateObject var practicePointsViewModel = PracticePointsDataHandler.shared
    
    @Namespace private var bottomId
    
    func replaceComponent(quiz: inout [LSQuizComponent], droppingComponent: LSQuizComponent) {
        if let currentlyDragging {
            if let sourceIndex = quiz.firstIndex(where: {$0.id == currentlyDragging.id}),
               let destinationIndex = quiz.firstIndex(where: {$0.id == droppingComponent.id}) {
                let sourceItem = quiz.remove(at: sourceIndex)
                quiz.insert(sourceItem, at: destinationIndex)
            }
        }
        
        if isButtonDisabled {
            isButtonDisabled = false
        }
    }
    
    @ViewBuilder
    func makeQuizComponentRow(_ quizComponent: LSQuizComponent) -> some View {
        HStack {
            Text(quizComponent.content)
                .padding()
            Spacer()
            Image(systemName: "line.3.horizontal")
                .foregroundStyle(.gray3)
                .padding(.trailing)
            
        }
        .frame(maxWidth: .infinity)
        .background{
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 16)
                    .fill(.wh)
                    .stroke(.gray3, lineWidth: 1)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .shadow(color: .gray, radius: 10, x: 0, y: 10)
            }
        }
        .padding(.bottom)
        .padding(.horizontal)
        .draggable(quizComponent.id.uuidString) {
            HStack {
                Text(quizComponent.content)
                    .padding()
                Spacer()
                Image(systemName: "line.3.horizontal")
                    .foregroundStyle(.gray3)
                    .padding(.trailing)
                
            }
            .frame(maxWidth: .infinity)
            .onAppear {
                currentlyDragging = quizComponent
            }
        }
        .dropDestination(for: String.self) { items, location in
            currentlyDragging = nil
            return false
        } isTargeted: { status in
            if let currentlyDragging, status, currentlyDragging.id != quizComponent.id {
                withAnimation(.snappy) {
                    replaceComponent(quiz: &quiz, droppingComponent: quizComponent)
                }
            }
        }
    }
    
    func changeUIBasedOnTheResult()  {
        bottomBackColor = isResultCorrect! ? Color.bg : Color.gray3
        buttonText = isResultCorrect! ? "학습 완료" : "재도전하기"
        confirmationMessage = isResultCorrect! ? "정답이에요! 🎉" : "다시 한 번 생각해볼까요? 💪"
        messageColor = isResultCorrect! ? Color.main : Color.gray2
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack (alignment: .leading) {
                    Text("글을 움직여 아래 순서대로 배치해보세요")
                        .customFont(.title4_bold)
                    
                    Image("\(lsStructure.rawValue)_\(lsStructure.components.count)")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom)
                    
                    ForEach(quiz) { component in
                        makeQuizComponentRow(component)
                    }
                }
                .padding(.horizontal)
                
                
                Spacer(minLength: 200)
            }
            .frame(maxHeight: .infinity)
            .toolbar(.hidden, for: .tabBar)
            .toolbarRole(.editor)
            .overlay(alignment: .bottom) {
                VStack {
                    if isResultCorrect != nil {
                        HStack {
                            Spacer()
                            Text(confirmationMessage)
                                .customFont(.title4_bold)
                                .foregroundStyle(Color.main)
                                .padding(.top, 28)
                            Spacer()
                        }

                    }
                    Spacer()
                    if isResultCorrect != nil && isResultCorrect == true {
                        NavigationLink(destination: QuizDoneView(isRepeat: isRepeat ?? false, speakingStructure: lsStructure)) {
                            RoundedRectangle(cornerRadius: 18)
                                .fill(Color.main)
                                .frame(width: 353, height: 54)
                                .overlay {
                                    Text(buttonText)
                                        .customFont(.body1_bold)
                                        .foregroundStyle(.wh)
                                }
                                .id(bottomId)
                        }
                        
                    } else {
                        Button {
                            let orderInTheQuiz:[Int] = quiz.map({$0.order})
                            if orderInTheQuiz == [1,2,3,4] || orderInTheQuiz == [1,2,3] {
                                isResultCorrect = true
                            } else {
                                isResultCorrect = false
                            }
                            
                            changeUIBasedOnTheResult()
                            proxy.scrollTo(bottomId)
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 18)
                                .fill(isButtonDisabled ? Color.gray5 : Color.main)
                                .frame(width: 353, height: 54)
                                .overlay {
                                    Text(buttonText)
                                        .customFont(.body1_bold)
                                        .foregroundStyle(.wh)
                                }
                        }
                        .disabled(isButtonDisabled)
                        .id(bottomId)
                    }
                }
                .background(bottomBackColor)
            }
            .onAppear {
                quiz = lsStructure.quizSentences
            }
        }
    }
}

#Preview {
    NavigationStack {
        QuizView(lsStructure: .psb)
    }
}
