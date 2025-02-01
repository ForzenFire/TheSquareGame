//
//  LayerSelection.swift
//  TheSquareGame
//
//  Created by KAVINDU 040 on 2025-02-01.
//
import SwiftUI

struct LevelSelectionView: View {
    var body: some View {
        VStack {
            Text("Select Difficulty")
                .font(.largeTitle)
                .padding()

            ForEach(["Easy", "Medium", "Hard"], id: \.self) { level in
                NavigationLink(destination: ContentView(level: level)) {
                    Text(level)
                        .font(.title)
                        .frame(width: 200, height: 50)
                        .background(levelColor(level))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }

    func levelColor(_ level: String) -> Color {
        switch level {
        case "Easy": return .green
        case "Medium": return .orange
        case "Hard": return .red
        default: return .gray
        }
    }
}

struct LevelSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSelectionView()
    }
}
