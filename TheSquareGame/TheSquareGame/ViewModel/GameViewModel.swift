//
//  GameViewModel.swift
//  TheSquareGame
//
//  Created by KAVINDU 040 on 2025-02-01.
//
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var buttonColors: [Color] = Array(repeating: .clear, count: 9)
    @Published var firstSelection: (index: Int, color: Color)? = nil
    @Published var isDisabled: Bool = true
    @Published var timeRemaining: Int = 60
    @Published var isGameRunning: Bool = false
    
    let colors: [Color] = [.red, .green, .blue, .yellow, .purple, .orange, .pink, .indigo]
    private var timer: Timer?

    func startGame() {
        assignRandomColors()
        isGameRunning = true
        isDisabled = false
        timeRemaining = 60
        startTimer()
    }

    func resetGame() {
        buttonColors = Array(repeating: .clear, count: 9)
        firstSelection = nil
        isDisabled = true
        isGameRunning = false
        timer?.invalidate()
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

    func assignRandomColors() {
        var remainingColors = colors.shuffled()
        var newButtonColors = Array(repeating: Color.clear, count: 9)

        let matchingColor = remainingColors.removeFirst()
        var matchingIndices = Array(0..<9).shuffled().prefix(2)
        newButtonColors[matchingIndices.removeFirst()] = matchingColor
        newButtonColors[matchingIndices.removeFirst()] = matchingColor

        for i in 0..<9 where newButtonColors[i] == .clear {
            if !remainingColors.isEmpty {
                newButtonColors[i] = remainingColors.removeFirst()
            }
        }
        
        buttonColors = newButtonColors
        firstSelection = nil
    }

    func handleButtonTap(at index: Int) {
        guard let selectedColor = buttonColors[safe: index] else { return }

        if let first = firstSelection, first.index == index {
            return
        }

        if let first = firstSelection {
            if first.color == selectedColor {
                print("Match found!")
                assignRandomColors()
            } else {
                print("No match!")
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
