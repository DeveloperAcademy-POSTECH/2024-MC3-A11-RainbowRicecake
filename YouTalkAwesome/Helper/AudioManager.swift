//
//  AudioManager.swift
//  YouTalkAwesome
//
//  Created by 문인범 on 7/31/24.
//

import AVFoundation

/**
 음성 녹음 및 재생과 관련된 클래스
 */
@Observable
final class AudioManager: NSObject {
    public var isRecording: Bool = false

    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    
    private let audioSession = AVAudioSession.sharedInstance()
    private let recorderSettings: [String: Any] = [
        AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless),
        AVSampleRateKey: 44100.0,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue
    ]
    private let fileURL: URL = {
        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = filePath.appending(path: "speechRecord.m4a")
        return fileURL
    }()
    
    public func requestPermission() async -> Bool {
//        let result = await AVCaptureDevice.requestAccess(for: .audio)
        let result = await AVAudioApplication.requestRecordPermission()
        
        return result
    }
    
    public func startRecording() {
//        guard let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            return
//        }
//
//        let fileURL = filePath.appending(path: "speechRecord.m4a")
        
        do {
            try audioSession.setCategory(.playAndRecord)
            try audioSession.setActive(true)
            
            self.audioRecorder = try AVAudioRecorder(url: fileURL, settings: recorderSettings)
            self.audioRecorder?.record()
            self.isRecording = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func stopRecording() {
        self.audioRecorder?.stop()
    }
}
