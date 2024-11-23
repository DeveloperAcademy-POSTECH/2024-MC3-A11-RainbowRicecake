//
//  ContentWritingStartView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 8/1/24.
//

import SwiftUI

struct ContentWritingStartView: View {
    var isTopic: Bool
    @StateObject var router = Router.shared
    
    //제목 입력
    @State var contentTitle: String = ""
    
    //발표 날짜 선택
    @State private var showDatePicker = false
    @State private var selectedDate = Date()
    @State private var selectedDateString = ""
    
    //제한 시간 선택
    let minutes = Array(0...59)
    let seconds = Array(0...59)
    
    @State private var showTimePicker = false
    @State private var selectedMinutes = 0
    @State private var selectedSeconds = 0
    @State private var timeLimit: Int = 0
    @State private var timeLimitString = ""
    
    //논리 구조 선택
    @State var selectedSpeakingStructure: SpeakingStructure? = nil
    
    //위 사항들 다 충족하면 true
    @State private var canGoNext: Bool = false
    @State private var selectingArray: [Bool] = [false, false, false, false]
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func checkValues() {
        if isTopic {
            canGoNext = true
        } else if !contentTitle.isEmpty && !selectedDateString.isEmpty && !timeLimitString.isEmpty {
            canGoNext = true
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("어떤 대본을 작성하시나요?")
                    .customFont(.title2_bold)
                Spacer()
            }
            .padding(.horizontal)
            Spacer()

            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("제목")
                            .customFont(.body1_bold)
                    }

                    TextField("대본의 제목을 작성해주세요", text: $contentTitle)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                                .fill(.wh)
                        )
                        .lineLimit(20)
                        .onChange(of: contentTitle) {
                            if !$0.isEmpty {
                                selectingArray[0] = true
                            } else {
                                selectingArray[0] = false
                            }
                        }
                }
                .padding()

                if !isTopic {
                    forTopic
                }

                VStack(alignment: .leading) {
                    HStack {
                        Text("참고할 논리구조")
                            .customFont(.body1_bold)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    
                    ScrollView(.horizontal) {
                        ScrollViewReader { proxy in
                            HStack(spacing: 16) {
                                ForEach(SpeakingStructure.allCases, id: \.self) { speakingStructure in
                                    Button(action: {
                                        selectedSpeakingStructure = speakingStructure
                                        selectingArray[3] = true
                                        withAnimation {
                                            proxy.scrollTo(speakingStructure, anchor: .center)
                                        }
                                    }) {
                                        Image("\(speakingStructure.rawValue)-\(selectedSpeakingStructure == speakingStructure ? "selected" : "unselected")")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 220)
                                    }
                                    .id(speakingStructure) // 각 항목에 고유 ID를 부여
                                    .padding(.leading, speakingStructure == SpeakingStructure.allCases.first ? 20 : 0)
                                }
                            }
                            .onAppear {
                                // 이미 선택된 항목으로 스크롤 이동
                                if let selected = selectedSpeakingStructure {
                                    withAnimation {
                                        proxy.scrollTo(selected, anchor: .center)
                                    }
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    Spacer(minLength: 100)
                }
            }
        }
        .background(Color.gray6)
        .toolbarRole(.editor)
        .onAppear {
            if isTopic {
                selectingArray = [true, true, true, true]
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .overlay(alignment: .bottom) {
            bottomButton
        }
    }

    private var bottomButton: some View {
        Button {
            router.setTopic(title: contentTitle)
            router.setSelectedStructure(selection: selectedSpeakingStructure ?? .aida)

            if isTopic {
                router.push(screen: .ContentWritingWithTopic)
            } else {
                router.setDateAndTime(date: selectedDate, time: timeLimit)
                router.push(screen: .ContentWritingWithoutTopic)
            }
        } label: {
            RoundedRectangle(cornerRadius: 18)
                .frame(width: 353, height: 54)
                .overlay(
                    Text("새로운 대본 만들기")
                        .customFont(.body1_bold)
                        .foregroundStyle(Color.wh)
                )
        }
        .tint(.main)
        .disabled(!checkConditionFilled())
        .padding(.top, isTopic ? 80 : 0)
        .padding(.bottom)
    }
    
    var forTopic: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                HStack {
                    Text("예정 날짜")
                        .customFont(.body1_bold)
                }
                TextField("예정된 발표 날짜를 선택해주세요", text: $selectedDateString)
                    .disabled(true)
                    .padding(10)
                    .background (
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                            .fill(.wh)
                    )
                    .overlay {
                        HStack {
                            Spacer()
                            Image(systemName: "calendar")
                                .padding(.trailing)
                                .foregroundStyle(Color.gray1)
                        }
                        .onTapGesture {
                            showDatePicker.toggle()
                        }
                    }
                    .sheet(isPresented: $showDatePicker) {
                        VStack {
                            DatePicker(
                                "예정된 발표 날짜를 선택해주세요",
                                selection: $selectedDate,
                                in: Date()...,
                                displayedComponents: [.date]
                            )
                            .datePickerStyle(.graphical)
                            .labelsHidden()
                            .padding()

                            Button {
                                showDatePicker = false
                                selectedDateString = selectedDate.getYMDDate()
                            } label: {
                                RoundedRectangle(cornerRadius: 18)
                                    .foregroundStyle(Color.main)
                                    .frame(width: 353, height: 54)
                                    .overlay(
                                        Text("확인")
                                            .fontWeight(.bold)
                                            .foregroundStyle(Color.wh)
                                    )
                            }
                        }
                        .padding()
                        .presentationDetents([.medium, .fraction(0.5)])
                        .onChange(of: selectedDate) {
                            self.selectingArray[1] = true
                        }
                    }
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("제한 시간")
                        .customFont(.body1_bold)
                }
                TextField("발표 제한 시간을 선택해주세요", text: $timeLimitString)
                    .disabled(true)
                    .padding(10)
                    .background (
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                            .fill(.wh)
                    )
                    .overlay {
                        HStack {
                            Spacer()
                            Image(systemName: "timer")
                                .padding(.trailing)
                                .foregroundStyle(Color.gray1)
                        }
                        
                    }
                .onTapGesture {
                    showTimePicker.toggle()
                }
                .onChange(of: selectedDate) {
                    self.selectingArray[2] = true
                }
                .sheet(isPresented: $showTimePicker) {
                    VStack {
                        HStack {
                            Picker(selection: $selectedMinutes, label: Text("분")) {
                                ForEach(0..<60) { index in
                                    Text("\(self.minutes[index])").tag(index)
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(WheelPickerStyle())
                            Text("분")
                            Picker(selection: $selectedSeconds, label: Text("초")) {
                                ForEach(0..<60) { index in
                                    Text("\(self.seconds[index])").tag(index)
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(WheelPickerStyle())
                            Text("초")
                        }
                        
                        Button(action: {
                            showTimePicker = false
                            timeLimit = selectedMinutes*60 + selectedSeconds
                            timeLimitString = "\(selectedMinutes)분 \(selectedSeconds)초"
                        }) {
                            RoundedRectangle(cornerRadius: 18)
                                .foregroundStyle(Color.main)
                                .frame(width: 353, height: 54)
                                .overlay(
                                    Text("확인")
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.wh)
                                )
                        }
                    }
                    .padding()
                    .presentationDetents([.medium, .fraction(0.5)])
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func checkConditionFilled() -> Bool {
        return self.selectingArray.filter{ !$0 }.isEmpty
    }
}

#Preview {
    NavigationStack {
        ContentWritingStartView(isTopic: false)
    }
}
