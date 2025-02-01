//
//  HomeScreen.swift
//  TheSquareGame
//
//  Created by KAVINDU 040 on 2025-02-01.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("The Square Game")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: LevelSelectionView()) {
                    Text("Start Game")
                        .font(.title)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                NavigationLink(destination: HighScoreView()) {
                    Text("High Score")
                        .font(.title)
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: { exit(0) }) {
                    Text("Exit")
                        .font(.title)
                        .frame(width: 200, height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
