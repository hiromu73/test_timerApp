
import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClockTimer(),
    );
  }
}



class ClockTimer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClockTimerState();
  }
}

class _ClockTimerState extends State<ClockTimer> {
  /// 初期値
  var _timeString = '00:00:00';
  var _isStart = false;
  ///開始時間
  DateTime _startTime;
  ///ローカルタイマー
  var _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('タイマーアプリ')
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(_timeString, style: TextStyle(fontSize: 60)),
          ),
          Container(
            width: 100,
            height: 50,
            color: Colors.greenAccent,
            child: TextButton(
                onPressed: _startTimer,
                child: Text(_isStart ? 'STOP' : 'START')),
          )
        ],
      ),
    );
  }
  ///スタートボタンタップ時に走る関数
          void _startTimer(){
            setState((){
              _isStart = !_isStart;
              if(_isStart) {///stop
                _startTime = DateTime.now();///現在の時刻の取得'00:00:00'
                _timer = Timer.periodic(Duration(seconds: 1), _onTimer);///1秒ごとに_onTimerをよぶ
              } else {///start
                _timer.cancel();
              }
            });
          }

          void _onTimer(Timer timer){
            ///現在時刻を取得
            var now = DateTime.now();
            ///開始時刻と比較して差分を取得
            var diff = now.difference(_startTime).inSeconds;

            ///タイマーのロジック
            var hour = (diff / (60 * 60)).floor();
            var mod = diff % (60 * 60);
            var minutes = (mod / 60).floor();
            var second = mod % 60;

            setState(() => {
              _timeString = """${_convertTwoDigits(hour)}:${_convertTwoDigits(minutes)}:${_convertTwoDigits(second)}"""
            });
          }
          ///intからStringに変換するメソッド
            String _convertTwoDigits(int number){
              return number >= 10 ? "$number" : "0$number";
            }
          }
