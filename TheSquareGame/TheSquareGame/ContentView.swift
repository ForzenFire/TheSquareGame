//
//  ContentView.swift
//  TheSquareGame
//
//  Created by KAVINDU 040 on 2024-12-15.
//

import SwiftUI

struct ContentView: View {
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    var body: some View {
        VStack {
            Text("The Square Game")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
        // Use LazyVGrid for a 3x3 grid layout
        ScrollView {
            LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(0..<9) { index in
                    Button(action: {
                    // Handle button action
                    print("Button \(index + 1) tapped")
                        }) {
                        Text("")
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 130)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                    }
                }
                .padding()
                }
            }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
