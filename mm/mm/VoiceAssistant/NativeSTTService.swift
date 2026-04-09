import Speech
import AVFoundation
import Foundation

class NativeSTTService {
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "zh-CN"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngineManager = AudioEngineManager.shared

    func startRecognition(onResult: @escaping (String, Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { [weak self] status in
            guard status == .authorized else {
                print("NativeSTTService: Speech recognition not authorized")
                return
            }

            DispatchQueue.main.async {
                self?.beginRecognition(onResult: onResult)
            }
        }
    }

    private func beginRecognition(onResult: @escaping (String, Bool) -> Void) {
        // Cancel any existing task
        recognitionTask?.cancel()
        recognitionTask = nil

        audioEngineManager.configureSession()

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { return }

        recognitionRequest.shouldReportPartialResults = true

        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                let text = result.bestTranscription.formattedString
                onResult(text, result.isFinal)
            }

            if error != nil || (result?.isFinal ?? false) {
                self.stopRecognition()
            }
        }

        audioEngineManager.installTap { [weak self] buffer, _ in
            self?.recognitionRequest?.append(buffer)
        }

        do {
            try audioEngineManager.start()
        } catch {
            print("NativeSTTService: Failed to start audio engine: \(error)")
        }
    }

    func stopRecognition() {
        audioEngineManager.removeTap()
        audioEngineManager.stop()
        recognitionRequest?.endAudio()
        recognitionRequest = nil
        recognitionTask?.cancel()
        recognitionTask = nil
    }
}
