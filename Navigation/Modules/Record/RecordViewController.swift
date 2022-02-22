//
//  RecordViewController.swift
//  Navigation
//
//  Created by a.agataev on 22.02.2022.
//

import UIKit
import AVFoundation
import SnapKit

class RecordViewController: UIViewController, AVAudioRecorderDelegate {
    
    private lazy var recordButton: CustomButton = {
        recordButton = CustomButton(
            title: "Tap to Record",
            titleColor: .blue,
            onTap: { [weak self] in
                self?.recordTapped()
            }
        )
        return recordButton
    }()
    
    private lazy var playButton: CustomButton = {
        playButton = CustomButton(
            title: "Tap to play",
            titleColor: .blue,
            onTap: { [weak self] in
                self?.playTapped()
            }
        )
        return playButton
    }()
    
    private(set) var audioRecorder: AVAudioRecorder?
    private(set) var recordingSession: AVAudioSession?
    private(set) var player: AVAudioPlayer?
    private(set) var audioUrl: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
                
        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession?.setCategory(.playAndRecord, mode: .default)
            try recordingSession?.setActive(true)
            recordingSession?.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        print("failed to record")
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    private func loadRecordingUI() {
        view.addSubview(recordButton)
        view.addSubview(playButton)
        setupLayout()
    }
    
    private func setupLayout() {
        recordButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(recordButton.snp.bottom).offset(5)
        }
    }
    
    private func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    private func playTapped() {
        guard let audioUrl = audioUrl else { return }
        do {
            player = try AVAudioPlayer(contentsOf: audioUrl)
            player?.play()
        } catch {
            print(error)
        }
    }
    
    
   private  func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        audioUrl = audioFilename

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
                        
            audioRecorder?.delegate = self
            audioRecorder?.record()

            recordButton.setTitle("Tap to Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func finishRecording(success: Bool) {
        audioRecorder?.stop()
        audioRecorder = nil

        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}
