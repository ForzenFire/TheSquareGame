//
//  GameViewModel.swift
//  TheSquareGame
//
//  Created by KAVINDU 040 on 2025-02-01.
//
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var buttonColors: [Color] = []
    @Published var hiddenColors: [Bool] = []
    @Published var firstSelection: (index: Int, color: Color)? = nil
    @Published var isDisabled: Bool = true
    @Published var timeRemaining: Int = 30
    @Published var isGameRunning: Bool = false
    
    let colors: [Color] = [.red, .green, .blue, .yellow, .purple, .orange, .pink, .indigo]
    private var timer: Timer?
    private var hideTimer: Timer?
    
    var gridSize: Int
    
    init(level: String) {
        switch level {
            case "Easy":
            gridSize = 9
        case "Medium":
            gridSize = 16
        case "Hard":
            gridSize = 25
        default:
            gridSize = 9
        }
        resetGame()
    }

    func startGame() {
        assignRandomColors()
        isGameRunning = true
        isDisabled = false
        timeRemaining = 30
        startTimer()
        startHideTimer()
    }

    func resetGame() {
        buttonColors = Array(repeating: .clear, count: gridSize)
        hiddenColors = Array(repeating: false, count: gridSize)
        firstSelection = nil
        isDisabled = true
        isGameRunning = false
        timer?.invalidate()
        hideTimer?.invalidate()
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.resetGame()
            }
        }
    }
    
    private func startHideTimer() {
        hideTimer?.invalidate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.hiddenColors = Array(repeating: true, count: self.gridSize)
        }
    }

    func assignRandomColors() {
        var remainingColors = colors.shuffled()
        var newButtonColors = Array(repeating: Color.clear, count: gridSize)

        let matchingColor = remainingColors.removeFirst()
        var matchingIndices = Array(0..<gridSize).shuffled().prefix(2)
        newButtonColors[matchingIndices.removeFirst()] = matchingColor
        newButtonColors[matchingIndices.removeFirst()] = matchingColor

        for i in 0..<gridSize where newButtonColors[i] == .clear {
            if !remainingColors.isEmpty {
                newButtonColors[i] = remainingColors.removeFirst()
            }
        }
        
        buttonColors = newButtonColors
        hiddenColors = Array(repeating: false, count: gridSize)
        firstSelection = nil
    }

    func handleButtonTap(at index: Int) {
        guard index < buttonColors.count else { return }
        hiddenColors[index] = false
        let selectedColor = buttonColors[index]

        if let first = firstSelection, first.index == index {
            return
        }

        if let first = firstSelection {
            if first.color == selectedColor {
                print("Match found!")
            } else {
                print("No match!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.hiddenColors[first.index] = true
                    self.hiddenColors[index] = true
                }
            }
            firstSelection = nil
        } else {
            firstSelection = (index: index, color: selectedColor)
        }
    }
}

// Safe index accessor to avoid crashes
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
