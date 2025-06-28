//
//  ContentView.swift
//  StopWatchGame
//
//  Created by Mac on 2025/06/25.
//
import SwiftUI

struct ContentView: View {
    
    @State private var timer: Timer?
    @State private var secondsElapsed: Double = 0.0
    @State private var isRunning = false
    @State private var targetTime: Double = 0.0
    @State private var currentScore: Int = 0
    @State private var totalScore: Int = 0
    @State private var roundCount: Int = 0
    @State private var gameStarted = false
    @State private var showResult = false
    @State private var lastDifference: Double = 0.0
    @State private var bestScore: Int = 0
    
    var body: some View {
        VStack(spacing: 30) {
            
            // スコア表示
            HStack {
                VStack {
                    Text("ラウンド")
                        .font(.caption)
                    Text("\(roundCount)")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack {
                    Text("合計スコア")
                        .font(.caption)
                    Text("\(totalScore)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                VStack {
                    Text("ベスト")
                        .font(.caption)
                    Text("\(bestScore)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            
            if gameStarted {
                // ターゲット時間表示
                VStack {
                    Text("目標時間")
                        .font(.headline)
                    Text(String(format: "%.2f秒", targetTime))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(10)
                
                // 現在の時間表示
                VStack {
                    Text("経過時間")
                        .font(.headline)
                    Text(String(format: "%.2f秒", secondsElapsed))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .monospacedDigit()
                }
                
                // コントロールボタン
                HStack(spacing: 20) {
                    if isRunning {
                        Button {
                            stop()
                        } label: {
                            VStack {
                                Image(systemName: "stop.fill")
                                    .font(.title)
                                Text("ストップ!")
                                    .font(.caption)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(15)
                        }
                    } else {
                        Button {
                            start()
                        } label: {
                            VStack {
                                Image(systemName: "play.fill")
                                    .font(.title)
                                Text("スタート")
                                    .font(.caption)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(15)
                        }
                    }
                    
                    Button {
                        resetRound()
                    } label: {
                        VStack {
                            Image(systemName: "arrow.clockwise")
                                .font(.title)
                            Text("リセット")
                                .font(.caption)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(15)
                    }
                }
                
            } else {
                // ゲーム開始画面
                VStack(spacing: 20) {
                    Text("🎯 タイムウォッチ 🎯")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("指定された時間ピッタリで\nストップウォッチを止めよう！")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                    
                    Button {
                        startNewGame()
                    } label: {
                        Text("ゲーム開始")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(15)
                    }
                }
            }
            
            // 結果表示
            if showResult {
                VStack(spacing: 15) {
                    Text("🎉 結果発表!")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("差: \(String(format: "%.2f", lastDifference))秒")
                        .font(.headline)
                    
                    Text("スコア: \(currentScore)点")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(getScoreColor(currentScore))
                    
                    Text(getScoreMessage(currentScore))
                        .font(.headline)
                        .foregroundColor(getScoreColor(currentScore))
                    
                    Button {
                        nextRound()
                    } label: {
                        Text("次のラウンド")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(15)
                .transition(.scale)
            }
            
            Spacer()
        }
        .padding()
        .animation(.easeInOut(duration: 0.3), value: showResult)
    }
    
    func startNewGame() {
        gameStarted = true
        roundCount = 1
        totalScore = 0
        generateNewTarget()
    }
    
    func generateNewTarget() {
        // 1.00秒から10.00秒の間でランダムなターゲット時間を生成
        targetTime = Double.random(in: 1.00...10.00)
        targetTime = round(targetTime * 100) / 100.0 // 小数点以下2桁に丸める
    }
    
    func start() {
        secondsElapsed = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            secondsElapsed += 0.01
        }
        isRunning = true
        showResult = false
    }
    
    func stop() {
        timer?.invalidate()
        isRunning = false
        
        // スコア計算
        lastDifference = abs(secondsElapsed - targetTime)
        currentScore = calculateScore(difference: lastDifference)
        totalScore += currentScore
        
        if currentScore > bestScore {
            bestScore = currentScore
        }
        
        showResult = true
    }
    
    func calculateScore(difference: Double) -> Int {
        // 差が小さいほど高得点（100点満点）
        if difference <= 0.05 {
            return 100
        } else if difference <= 0.1 {
            return 95
        } else if difference <= 0.2 {
            return 85
        } else if difference <= 0.5 {
            return 70
        } else if difference <= 1.0 {
            return 50
        } else if difference <= 2.0 {
            return 25
        } else {
            return 5
        }
    }
    
    func getScoreColor(_ score: Int) -> Color {
        if score >= 95 {
            return .purple
        } else if score >= 85 {
            return .blue
        } else if score >= 70 {
            return .green
        } else if score >= 50 {
            return .orange
        } else {
            return .red
        }
    }
    
    func getScoreMessage(_ score: Int) -> String {
        if score == 100 {
            return "パーフェクト! 🏆"
        } else if score >= 95 {
            return "素晴らしい! ⭐️"
        } else if score >= 85 {
            return "とても良い! 👏"
        } else if score >= 70 {
            return "良い! 👍"
        } else if score >= 50 {
            return "まずまず 😊"
        } else {
            return "もう一度挑戦! 💪"
        }
    }
    
    func nextRound() {
        roundCount += 1
        generateNewTarget()
        resetRound()
    }
    
    func resetRound() {
        timer?.invalidate()
        isRunning = false
        secondsElapsed = 0.0
        showResult = false
    }
}

#Preview {
    ContentView()
}
