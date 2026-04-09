import AVFoundation
import Foundation

/// Backend-backed TTS service.
/// Calls backend API to get synthesized audio URL, then plays it locally.
class PollyTTSService {
    private var audioPlayer: AVAudioPlayer?

    func speak(_ text: String, completion: (() -> Void)? = nil) {
        // TODO: Call backend /api/tts/synthesize endpoint
        // 1. POST text to backend
        // 2. Receive audio URL or audio data
        // 3. Play with AVAudioPlayer
        print("PollyTTSService: Not implemented - requires backend TTS endpoint")
        completion?()
    }

    func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}
