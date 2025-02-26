import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class RecordingWave extends StatefulWidget {

  const RecordingWave({
    super.key,
  });

  @override
  RecordingWaveState createState() => RecordingWaveState();
}

class RecordingWaveState extends State<RecordingWave> {
  late Timer _timer;
  late Timer _waveTimer;
  int _seconds = 0;
  final List<double> _waveformValues = List.generate(20, (index) => Random().nextDouble());

  @override
  void initState() {
    super.initState();
    _startTimer();
    _startWaveAnimation();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _startWaveAnimation() {
    _waveTimer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        _waveformValues.insert(0, Random().nextDouble());
        if (_waveformValues.length > 30) {
          _waveformValues.removeLast();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _waveTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "0:${_seconds.toString().padLeft(2, '0')}",
            style:  TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
          ),
          SizedBox(width: 8),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 2,
                  width: double.infinity,
                  color: Colors.grey[400],
                ),
                Row(
                  spacing: 2,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _waveformValues.map((value) {
                    return Container(
                      width: 3,
                      height: value * 20 + 5,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}