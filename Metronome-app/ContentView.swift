//
//  ContentView.swift
//  Metronome-app
//
//  Created by kyosuke sato on 2022/07/18.
//

import SwiftUI

struct ContentView: View {
    
    @State var timerHandler : Timer? // タイマーの変数を作成
    @State private var isRight = false // クリック表示が左右どちらかを表す
    @State private var isStart = false // クリックがスタートしたかを表す
//    @State private var bpmNum:Int = 60
    @State private var bpmNum:Double = 60
//    @State var bpmNumDouble:Double = 0
//    @State var count = 0 // カウント（経過時間）の変数を作成
//    @AppStorage("timer_value") var timerValue = 10
    
    let clickPlayer = ClickPlayer()
    var body: some View {
        VStack{
//            Spacer()
//                .frame(height: 300)
            HStack{ // clickのビジュアル表示
                Button(action: {
                }) {
                    if isRight && isStart {
                        Text("左")
                            .font(.title)
                            .foregroundColor(Color.blue)
                            .border(Color.black)
                    } else {
                        Text("左")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .border(Color.black)
                    }
                }
                Button(action: {
                }) {
                    if !isRight && isStart {
                        Text("右")
                            .font(.title)
                            .foregroundColor(Color.blue)
                            .border(Color.black)
                    } else {
                        Text("右")
                            .font(.title)
                            .foregroundColor(Color.white)
                            .border(Color.black)
                    }
                }
//                HStack{
//
//                }
            }
            
            Button(action: {
                if !isStart {
                    startClick()
                } else {
                    stopClick()
                }
            }) {
                if !isStart {
                    Text("Start")
                        .foregroundColor(Color.white)
                        .padding(.all)
                        .background(Color.blue)
                } else {
                    Text("Stop")
                        .foregroundColor(Color.white)
                        .padding(.all)
                        .background(Color.yellow)
                }
            }

            if !isStart {  // bpmの表示と変更用のスライドバー。startすると非表示になる
                Text("BPM　\(Int(bpmNum))")
                    .foregroundColor(Color.blue)
                    .padding()
                HStack {
                    Button(action: {
                        lowerBPM()
                    }) {
                        Text("<")
                            .foregroundColor(Color.blue)
                            .padding()
//                            .background(Color.blue)
                    }
                    Slider(value: $bpmNum, in: 0...500, step: 1)
//                        .frame(width: 250)
                
                    Button(action: {
                        uperBPM()
                    }) {
                        Text(">")
                            .foregroundColor(Color.blue)
                            .padding()
//                            .background(Color.blue)
                    }
                }
            } else {
                Spacer()
                    .frame(height: 110)
            }
        }
    }

    func lowerBPM() { // bpmを下げる関数
        bpmNum -= 1
    }
    func uperBPM() { // bpmを上げる関数
        bpmNum += 1
    }
    func startClick() { // clickを鳴らす関数
        if let unwrapedClickHandler = timerHandler {
            if unwrapedClickHandler.isValid == true {
                // 何も処理しない
                return
            }
        }
        self.isStart = true
        // 設定したbpmから一拍の長さ（秒）を計算する
        let oneBeatLength:Double = TimeInterval(60 / self.bpmNum)

        // 一拍の長さ（oneBeatLength）毎でクリック音を再生する
        timerHandler = Timer.scheduledTimer(withTimeInterval: oneBeatLength, repeats: true) { _ in
            clickPlayer.clickPlay()  // クリック音の再生
            self.isRight.toggle() // クリックのビジュアルを右・左で切り替える。
        }
    }
    
    func stopClick() { // クリックを停止する関数
        self.isStart = false
        if let unwrapedClickHandler = timerHandler {
            if unwrapedClickHandler.isValid == true {
                // clickを停止する
                unwrapedClickHandler.invalidate()

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
