
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class VoiceNoteService {
  final SpeechToText _speechToText = SpeechToText();


  //final FlutterSoundRecorder _soundRecorder = FlutterSoundRecorder();
  final AudioRecorder _soundRecorder = AudioRecorder();


  Future<bool> initializeVoiceFeature() async {
    try {
      //request permission for microphone and speech to text
      await Permission.microphone.request();
      final speechPermission = await _speechToText.initialize();
      bool audioRecordPermission = await _soundRecorder.hasPermission();
      if (audioRecordPermission == true && speechPermission == true) {
        return true;
      }
      throw Exception('These permission are required for you to use voice feature');
    } catch (e) {
      rethrow;
    }
  }


  Future<void> startRecorder() async {
    if (await _soundRecorder.hasPermission()) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/chatter_voice_notes.wav';
      await _soundRecorder.start(RecordConfig(encoder: AudioEncoder.wav),
          path: filePath);
    }
  }

  Future<String?> stopRecorder() async {
    String? path = await _soundRecorder.stop();
    return path;
    }

  disposeRecorder() async {
    await _soundRecorder.dispose();
  }



  Future<void> startListening({required Function(String) onResult}) async {
    try {
      _speechToText.listen(onResult: (result) {
        if (result.finalResult == true && result.recognizedWords.trim().isNotEmpty) {
          onResult(result.recognizedWords);
        }
        return;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> stopListening() async {
    try {
      await _speechToText.stop();
    } catch (e) {
     rethrow;
    }
  }

  cancelListener() async {
    await _speechToText.cancel();
  }

}
