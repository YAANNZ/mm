import Foundation

/// Azure Speech SDK STT service stub.
/// Requires `MicrosoftCognitiveServicesSpeech-iOS` pod to be installed.
class AzureSTTService {
    func startRecognition(onResult: @escaping (String, Bool) -> Void) {
        // TODO: Implement with Azure Speech SDK
        // 1. Create SpeechConfig with subscription key and region
        // 2. Create SpeechRecognizer with audio config
        // 3. Start continuous recognition
        print("AzureSTTService: Not implemented - add MicrosoftCognitiveServicesSpeech-iOS pod")
    }

    func stopRecognition() {
        // TODO: Stop Azure recognizer
    }
}
