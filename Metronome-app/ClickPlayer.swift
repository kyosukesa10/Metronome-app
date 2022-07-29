//
//  SoundPlayer.swift
//  Metronome-app
//
//  Created by kyosuke sato on 2022/07/19.
//

import UIKit
import AVFoundation

class ClickPlayer: NSObject {
    
    let clickData = NSDataAsset(name: "click_1")!.data // 音源の指定
    var clickPlayer:AVAudioPlayer!
    
    // 音楽を再生
    func clickPlay() {
        do {
            clickPlayer = try AVAudioPlayer(data:clickData) // 音源を指定
            clickPlayer.play() // 音源の再生
        } catch {
            print("エラーが発生しました。音源が再生できません。")
        }
    }
    // 音源を停止
    func stopClick() {
        clickPlayer?.stop()
    }
}
