import AVFoundation
import Foundation

class AudioEngineManager {
    static let shared = AudioEngineManager()

    let audioEngine = AVAudioEngine()

    private init() {}

    func configureSession() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
            try session.setActive(true)
        } catch {
            print("AudioEngineManager: Failed to configure session: \(error)")
        }
    }

    func installTap(bufferSize: AVAudioFrameCount = 1024, handler: @escaping (AVAudioPCMBuffer, AVAudioTime) -> Void) {
        let inputNode = audioEngine.inputNode
        let format = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: bufferSize, format: format, block: handler)
    }

    func removeTap() {
        audioEngine.inputNode.removeTap(onBus: 0)
    }

    func start() throws {
        if !audioEngine.isRunning {
            try audioEngine.start()
        }
    }

    func stop() {
        if audioEngine.isRunning {
            audioEngine.stop()
        }
    }
}
