//
//  ContentWritingView.swift
//  YouTalkAwesome
//
//  Created by marty.academy on 8/1/24.
//

import SwiftUI
import Foundation
import SwiftData

// TODO: 완료버튼 이외에도 "현재 페이지를 이탈했을 때에 현재까지의 상황을 저장/전달"하는 기능 구현
struct ContentWritingView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    
    @Environment(\.modelContext) private var modelContext
    
    var topic : String
    var selectedStructure : SpeakingStructure
    var designatedDate : Date?
    var expectedLeadTime : Int?
    var isFreeTopic : Bool

    @State private var scriptProcess : Int = 1
    
    @State private var textFields : [String] = []
    
    @State private var structureSections : [StructureSection] = []
    
    @State private var isPresented : Bool = false
    
    @State private var keyboardHeight: CGFloat = 0
    
    let nonVerbalExpressions = ["⭐️ 강조", "🫲 제스쳐", "🙂 미소", "🗣️ 크게 말하기"]
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @ViewBuilder
    func makeButtonInModalView(_ word: String) -> some View {
        Text(word)
            .customFont(.body1_bold)
            .foregroundColor(.gray3)
            .background {
                GeometryReader {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .stroke(.gray3, lineWidth: 0.66)
                        .frame(width: $0.size.width + 20, height: 38)
                        .position(x: $0.frame(in: .local).midX, y: $0.frame(in: .local).midY)
                }
            }
            .padding()
    }
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                Text(topic)
                    .customFont(.title4_bold)
                    .padding()
                    .padding(.top, 80)
                
                if let designatedDate = self.designatedDate, let expectedLeadTime = self.expectedLeadTime {
                    HStack {
                        Label(
                            title: { Text("\(designatedDate.getYMDDate())") },
                            icon: { Image(systemName: "calendar") }
                        )
                        
                        Label(
                            title: { Text("\(expectedLeadTime / 60)분 \(expectedLeadTime % 60)초") },
                            icon: { Image(systemName: "clock") }
                        )
                        
                        Spacer()
                    }
                    .foregroundColor(Color(hex: "9BA4AB")).padding([.horizontal, .bottom])
                }
            
            }
            .frame(maxWidth: .infinity)
            .background {
                Color.bg
            }
            
            VStack {
                Image("\(selectedStructure.rawValue)_\(scriptProcess)")
                    .padding(10)
                
                ForEach(0 ..< structureSections.count, id: \.self) { index in
                    WritingComponentView(
                        color: selectedStructure.color,
                        structureSection:  structureSections[index],
                        textContent: $textFields[index],
                        isEndContent: structureSections.count - index == 1
                    )
                }
                
                Button {
                    isPresented.toggle()
                } label : {
                    Label(
                        title: { Text("추가하기").customFont(.caption1_light) },
                        icon: { Image(systemName: "plus")
                            .font(.system(size:14))}
                    )
                    .foregroundColor(.gray3)
                    .padding(.bottom, 40)
                    .padding(.bottom, keyboardHeight)
                }
            }
        }
        .scrollIndicators(.hidden)
        .ignoresSafeArea()
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    let scriptRecord: LogicalSpeakingRecord = .init(topic: self.topic, speakingStructure: self.selectedStructure, content: self.structureSections, duration: self.expectedLeadTime ?? 0, isDone: true, designatedTimestamp: self.designatedDate, isFreeTopic: !self.isFreeTopic)
                    
                    var finalStructureSections = [StructureSection]()
                    for index in 0 ..< self.textFields.count {
                        let result = StructureSection(topContent: self.structureSections[index].topContent, bodyContent: self.textFields[index], isScript: self.structureSections[index].isScript)
                        finalStructureSections.append(result)
                    }
                    
                    Router.shared.setStructureSections(finalStructureSections)
                    scriptRecord.content = finalStructureSections
                    
                    do {
                        modelContext.insert(scriptRecord)
                        try modelContext.save()
                    } catch {
                        print("[Error] Speaking Record Inserting Error")
                    }
                    
                    if self.isFreeTopic {
                        coordinator.push(.WritingCompleteWithoutTopic(title: self.topic, date: nil, time: nil, structure: finalStructureSections))
                    } else {
                        coordinator.push(.WritingCompleteWithTopic(title: self.topic, structure: finalStructureSections))
                    }
                } label: {
                    Text("완료")
                        .font(.system(size: 17)) //별도 customfont 지정 없음
                        .foregroundStyle(.main)
                }
            }
        }
        .onAppear {
            if structureSections.count == 0 {
                structureSections.append(.init(topContent: "\(selectedStructure.components[0]) (\(selectedStructure.components_kor[0]))", bodyContent: "", isScript: true))
                textFields.append("")
            }

            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    keyboardHeight = keyboardSize.height
                }
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                keyboardHeight = 0
            }
        }
        .sheet(isPresented: $isPresented) {
            let indexOfSpeakingStructure = structureSections.filter {$0.isScript == true}.count
            
            VStack (alignment: .leading ) {
                
                if indexOfSpeakingStructure < selectedStructure.components.count {
                    VStack (alignment: .leading) {
                        Text("언어적 요소")
                            .customFont(.body2_bold)
                        Button {
                            structureSections.append(.init(topContent: "\(selectedStructure.components[scriptProcess]) (\(selectedStructure.components_kor[scriptProcess]))", bodyContent: "", isScript: true))
                            textFields.append("")
                            
                            scriptProcess += 1
                            
                            isPresented = false
                            
                        } label : {
                            makeButtonInModalView(selectedStructure.components[indexOfSpeakingStructure])
                        }
                    }
                    .padding(.bottom)
                }
                
                VStack (alignment: .leading) {
                    Text("비언어적 요소")
                        .customFont(.body2_bold)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(nonVerbalExpressions, id: \.self) { expression in
                                Button {
                                    let topContent = String(expression.first!)
                                    let bodyContent = String(expression.suffix(expression.count - 2))
                                    
                                    structureSections.append(.init(topContent: "\(topContent)", bodyContent: "\(bodyContent)", isScript: false))
                                    textFields.append(bodyContent)
                                    
                                    isPresented = false
                                } label : {
                                    makeButtonInModalView(expression)
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .presentationDetents([.height(indexOfSpeakingStructure < selectedStructure.components.count ? 270 : 130)])
                }
            }
            .padding(.horizontal)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    let dateFormatter = DateFormatter()

    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.timeZone = NSTimeZone(name: "KST") as TimeZone?
    
    return NavigationStack {
        ContentWritingView(topic: "AI를 활용한 UX디자인", selectedStructure: .aida, designatedDate: dateFormatter.date(from: "2024-07-31"), expectedLeadTime: 90, isFreeTopic: false)
    }
}
