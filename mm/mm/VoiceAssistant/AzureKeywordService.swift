import Foundation

/// Azure keyword spotting service stub.
/// Requires `MicrosoftCognitiveServicesSpeech-iOS` pod and a keyword model file.
class AzureKeywordService {
    func startListening(onWakeWord: @escaping () -> Void) {
        // TODO: Implement with Azure Speech SDK keyword recognition
        // 1. Load keyword model (.table file)
        // 2. Create KeywordRecognizer
        // 3. Start recognition, call onWakeWord when triggered
        print("AzureKeywordService: Not implemented - add MicrosoftCognitiveServicesSpeech-iOS pod")
    }

    func stopListening() {
        // TODO: Stop keyword recognizer
    }
}
