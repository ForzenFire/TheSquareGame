//
//  GameModel.swift
//  TheSquareGame
//
//  Created by KAVINDU 040 on 2025-02-01.
//
import Foundation
import SwiftUI // Add this import to use Color

struct GameModel {
    let level: String
    var buttonColors: [Color] = Array(repeating: .clear, count: 9)
    var firstSelection: (index: Int, color: Color)? // Fixed 'Color' to lowercase
    var timeRemaining: Int = 60
    var isGameRunning: Bool = false
}
