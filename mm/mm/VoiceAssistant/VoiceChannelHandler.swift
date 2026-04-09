import Flutter
import Foundation

@objc class VoiceChannelHandler: NSObject {
    private var methodChannel: FlutterMethodChannel?
    private var eventChannel: FlutterEventChannel?
    private var eventSink: FlutterEventSink?

    private lazy var sttService = NativeSTTService()
    private lazy var ttsService = NativeTTSService()

    @objc func register(with engine: FlutterEngine) {
        methodChannel = FlutterMethodChannel(
            name: "com.aimusic/voice",
            binaryMessenger: engine.binaryMessenger
        )

        eventChannel = FlutterEventChannel(
            name: "com.aimusic/voice_events",
            binaryMessenger: engine.binaryMessenger
        )

        methodChannel?.setMethodCallHandler { [weak self] call, result in
            self?.handleMethodCall(call, result: result)
        }

        eventChannel?.setStreamHandler(self)
    }

    private func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "startSTT":
            sttService.startRecognition { [weak self] text, isFinal in
                self?.eventSink?(["event": "stt_result", "text": text, "isFinal": isFinal])
            }
            result(nil)

        case "stopSTT":
            sttService.stopRecognition()
            result(nil)

        case "speakText":
            guard let args = call.arguments as? [String: Any],
                  let text = args["text"] as? String else {
                result(FlutterError(code: "INVALID_ARGS", message: "Missing text", details: nil))
                return
            }
            ttsService.speak(text) { [weak self] in
                self?.eventSink?(["event": "tts_complete"])
            }
            result(nil)

        case "stopTTS":
            ttsService.stop()
            result(nil)

        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

extension VoiceChannelHandler: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }
}
