//
//  HighScoreViewModel.swift
//  TheSquareGame
//
//  Created by KAVINDU 040 on 2025-02-01.
//
import Foundation

class HighScoreViewModel: ObservableObject {
    
    @Published var highScore: Int = 0
    
    init() {
        loadHighScore()
    }
    
    func saveHighScore(newScore: Int) {
        if newScore > highScore {
            highScore = newScore
            UserDefaults.standard.set(highScore, forKey: "highScore")
        }
    }
    
    func loadHighScore() {
        highScore = UserDefaults.standard.integer(forKey: "highScore")
    }
}
