//
//  ContentView.swift
//  TheSquareGame
//
//  Created by KAVINDU 040 on 2024-12-15.
//
import SwiftUI

struct ContentView: View {
    let level: String
    @StateObject private var viewModel: GameViewModel

    let columns: [GridItem]

    init(level: String) {
        self.level = level
        _viewModel = StateObject(wrappedValue: GameViewModel(level: level))

        let columnCount: Int
        switch level {
        case "Easy":
            columnCount = 3
        case "Medium":
            columnCount = 4
        case "Hard":
            columnCount = 5
        default:
            columnCount = 3
        }
        columns = Array(repeating: GridItem(.flexible()), count: columnCount)
    }

    var body: some View {
        VStack {
            Text("The Square Game - \(level) Mode")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            if viewModel.isGameRunning {
                Text("Time Remaining: \(viewModel.timeRemaining) sec")
                    .font(.headline)
                    .padding(.bottom, 20)
            }
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(0..<viewModel.gridSize, id: \.self) { index in
                        Button(action: {
                            viewModel.handleButtonTap(at: index)
                        }) {
                            Rectangle()
                                .fill(viewModel.hiddenColors[index] ? Color.gray : viewModel.buttonColors[index])
                                .frame(width: 60, height: 60)
                                .cornerRadius(10)
                        }
                        .disabled(viewModel.isDisabled)
                    }
                }
                .padding()
            }
            
            if !viewModel.isGameRunning {
                Button("Start") {
                    viewModel.startGame()
                }
                .padding()
                .font(.title)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        .onAppear(perform: viewModel.resetGame)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(level: "Easy")
    }
}
