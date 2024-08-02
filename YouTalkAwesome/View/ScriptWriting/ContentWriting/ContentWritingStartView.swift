//
//  ContentWritingStartView.swift
//  YouTalkAwesome
//
//  Created by Kyuhee hong on 8/1/24.
//

import SwiftUI

struct ContentWritingStartView: View {
    var isTopic: Bool = false
    
    //제목 입력
    @State private var contentTitle: String = ""
    
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
    @State private var selectedSpeakingStructure: SpeakingStructure? = nil
    
    //위 사항들 다 충족하면 true
    @State private var canGoNext: Bool = false
    
    func checkValues() -> Bool {
        if contentTitle != "" && selectedDateString != "" && timeLimitString != "" {
            canGoNext = true
        }
        return canGoNext
    }
    
    var body: some View {
        VStack(spacing:20) {
            HStack {
                Text("어떤 대본을 작성하시나요?")
                    .customFont(.title2_bold)
                Spacer()
            }
            .padding(.horizontal)
            Spacer()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("제목")
                        .customFont(.body1_bold)
                }
                TextField("대본의 제목을 작성해주세요.", text: $contentTitle)
                    .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal)
            
            if isTopic == false {
                forTopic
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("참고할 논리구조")
                        .customFont(.body1_bold)
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(SpeakingStructure.allCases, id: \.self) { speakingStructure in
                            Button(action: {
                                selectedSpeakingStructure = speakingStructure
                                //다 선택되면 이걸로 체크
                                checkValues()
                            }) {
                                Image("\(speakingStructure.rawValue)-\(selectedSpeakingStructure == speakingStructure ? "selected" : "unselected")")
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
            }
            // 새로운 대본
//            NavigationLink(destination: )) {
            RoundedRectangle(cornerRadius: 18)
                .foregroundStyle(canGoNext ? Color.main : Color.gray5)
                .frame(width: 353, height: 54)
                .overlay(
                    Text("새로운 대본 만들기")
                        .customFont(.body1_bold)
                        .foregroundStyle(canGoNext ? Color.wh : Color.gray2)
                )
//            }
//            .disabled(!canGoNext)
        }
        .background(Color.gray6)
        .toolbarRole(.editor)
    }
    
    var forTopic: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                HStack {
                    Text("예정 날짜")
                        .customFont(.body1_bold)
                }
                ZStack {
                    TextField("예정된 발표 날짜를 선택해주세요", text: $selectedDateString)
                        .disabled(true)
                        .foregroundStyle(.primary)
                        .textFieldStyle(.roundedBorder)
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
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding()
                        
                        Button(action: {
                            showDatePicker = false
                            selectedDateString = selectedDate.getYMDDate()
                        }) {
                            Text("확인")
                                .customFont(.body1_bold)
                                .padding()
                                .background(Color.main)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .presentationDetents([.medium, .fraction(0.5)])
                }
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("제한 시간")
                        .customFont(.body1_bold)
                }
                ZStack {
                    TextField("발표 제한 시간을 선택해주세요", text: $timeLimitString)
                        .disabled(true)
                        .foregroundStyle(.primary)
                        .textFieldStyle(.roundedBorder)
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
                .sheet(isPresented: $showTimePicker) {
                    VStack {
                        HStack {
                            Picker(selection: $selectedMinutes, label: Text("분")) {
                                ForEach(0..<59) { index in
                                    Text("\(self.minutes[index])").tag(index)
                                }
                            }
                            .labelsHidden()
                            .pickerStyle(WheelPickerStyle())
                            Text("분")
                            
                            Picker(selection: $selectedSeconds, label: Text("초")) {
                                ForEach(0..<59) { index in
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
                            
                            print(timeLimit)
                        }) {
                            Text("확인")
                                .customFont(.body1_bold)
                                .padding()
                                .background(Color.main)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .presentationDetents([.medium, .fraction(0.5)])
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    NavigationStack {
        ContentWritingStartView(isTopic: false)
    }
}
