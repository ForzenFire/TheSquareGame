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
        GridItem(.flexible()),
    ]
    var body: some View {
        // Use LazyVGrid for vertical grid layout
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<8) { index in
                    Button(action: {
                        // Handle button action
                        print("Button \(index + 1) tapped")
                    }) {
                        Text("Button \(index + 1)")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
