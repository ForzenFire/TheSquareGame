//
//  ContentView.swift
//  TheSquareGame
//
//  Created by KAVINDU 040 on 2024-12-15.
//

import SwiftUI

struct ContentView: View {
    // Define colors and grid setup
    let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .pink, .gray]
    @State private var buttonColors: [Color] = Array(repeating: .clear, count: 9)
    @State private var firstSelectedIndex: Int? = nil
    @State private var secondSelectedIndex: Int? = nil

    var body: some View {
        VStack {
            Text("The Square Game")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            // LazyVGrid to create a 3x3 grid
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(0..<9, id: \.self) { index in
                    Button(action: {
                        handleButtonTap(at: index)
                    }) {
                        Rectangle()
                            .fill(buttonColors[index])
                            .frame(width: 80, height: 80)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .onAppear {
                assignRandomColors()
            }
        }
        .padding()
    }
    
    // Assign random colors to all buttons
    func assignRandomColors() {
        for i in 0..<buttonColors.count {
            buttonColors[i] = colors.randomElement() ?? .clear
        }
    }

    // Handle button tap
    func handleButtonTap(at index: Int) {
        // If this is the first button clicked
        if firstSelectedIndex == nil {
            firstSelectedIndex = index
        }
        // If this is the second button clicked
        else if secondSelectedIndex == nil {
            secondSelectedIndex = index
            checkMatch()
        }
    }
    
    // Check if selected colors match
    func checkMatch() {
        guard let firstIndex = firstSelectedIndex, let secondIndex = secondSelectedIndex else { return }
        
        if buttonColors[firstIndex] == buttonColors[secondIndex] {
            // Match found, clear the colors and assign new colors
            buttonColors[firstIndex] = .clear
            buttonColors[secondIndex] = .clear
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                buttonColors[firstIndex] = colors.randomElement() ?? .clear
                buttonColors[secondIndex] = colors.randomElement() ?? .clear
            }
        }
        
        // Reset selection
        firstSelectedIndex = nil
        secondSelectedIndex = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
