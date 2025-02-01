//
//  ContentView.swift
//  TheSquareGame
//
//  Created by KAVINDU 040 on 2024-12-15.
//
import SwiftUI

struct ContentView: View {
    let level: String
    @StateObject private var viewModel = GameViewModel()

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

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
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<9, id: \.self) { index in
                        Button(action: {
                            viewModel.handleButtonTap(at: index)
                        }) {
                            Rectangle()
                                .fill(viewModel.buttonColors[index])
                                .frame(width: 80, height: 80)
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
