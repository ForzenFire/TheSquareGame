//
//  HighScoreView.swift
//  TheSquareGame
//
//  Created by KAVINDU 040 on 2025-02-01.
//
import SwiftUI

struct HighScoreView: View {
    @StateObject private var viewModel = HighScoreViewModel()

    var body: some View {
        VStack {
            Text("High Score")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("\(viewModel.highScore)")
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(.blue)
                .padding()

            Spacer()

            // Back Button
            NavigationLink(destination: HomeView()) {
                Text("Back to Home")
                    .font(.title)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
    }
}

struct HighScoreView_Previews: PreviewProvider {
    static var previews: some View {
        HighScoreView()
    }
}

