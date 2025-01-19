import SwiftUI

struct ContentView: View {
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // List of possible colors
    let colors: [Color] = [.red, .green, .blue, .yellow, .purple, .orange, .pink, .indigo]
    
    // State variables
    @State private var buttonColors: [Color] = Array(repeating: .clear, count: 9) // Placeholder colors
    @State private var firstSelection: (index: Int, color: Color)? = nil
    @State private var isDisabled: Bool = true // Buttons are initially disabled
    @State private var timeRemaining: Int = 90 // Timer starts at 90 seconds
    @State private var isGameRunning: Bool = false // Tracks if the game is running
    
    // Timer
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("The Square Game")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            // Display the timer
            if isGameRunning {
                Text("Time Remaining: \(timeRemaining) seconds")
                    .font(.headline)
                    .padding(.bottom, 20)
            }
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<9, id: \.self) { index in
                        Button(action: {
                            handleButtonTap(at: index)
                        }) {
                            Rectangle()
                                .fill(buttonColors[index])
                                .frame(width: 80, height: 80)
                                .cornerRadius(10)
                        }
                        .disabled(isDisabled) // Disable interaction if the game isn't running
                    }
                }
                .padding()
            }
            
            // Display the start button if the game isn't running
            if !isGameRunning {
                Button("Start") {
                    startGame()
                }
                .padding()
                .font(.title)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        .onAppear(perform: resetGame) // Reset the game when the view appears
        .onReceive(timer) { _ in
            updateTimer()
        }
    }
    
    // Start the game
    func startGame() {
        assignRandomColors() // Assign colors to the buttons
        isGameRunning = true // Mark the game as running
        isDisabled = false // Enable the buttons
        timeRemaining = 90 // Reset the timer to 90 seconds
    }
    
    // Reset the game
    func resetGame() {
        buttonColors = Array(repeating: .clear, count: 9) // Clear button colors
        firstSelection = nil // Reset the first selection
        isDisabled = true // Disable buttons
        isGameRunning = false // Stop the game
    }
    
    // Update the timer
    func updateTimer() {
        guard isGameRunning else { return }
        
        if timeRemaining > 0 {
            timeRemaining -= 1 // Decrement the timer
        } else {
            // Timer reached 0, reset the game
            resetGame()
        }
    }
    
    // Assign random colors such that exactly 2 buttons have the same color
    func assignRandomColors() {
        var remainingColors = colors.shuffled() // Shuffle colors for randomness
        var newButtonColors = Array(repeating: Color.clear, count: 9)
        
        // Choose a random color for the two matching buttons
        let matchingColor = remainingColors.removeFirst()
        
        // Choose two random positions for the matching color
        var matchingIndices = Array(0..<9).shuffled().prefix(2)
        newButtonColors[matchingIndices.removeFirst()] = matchingColor
        newButtonColors[matchingIndices.removeFirst()] = matchingColor
        
        // Assign unique colors to the other buttons
        for i in 0..<9 where newButtonColors[i] == .clear {
            if !remainingColors.isEmpty {
                newButtonColors[i] = remainingColors.removeFirst()
            }
        }
        
        buttonColors = newButtonColors // Update button colors
        firstSelection = nil // Reset the first selection
    }
    
    // Handle button tap
    func handleButtonTap(at index: Int) {
        guard let selectedColor = buttonColors[safe: index] else { return }
        
        // Prevent the same button from being clicked twice
        if let first = firstSelection, first.index == index {
            return
        }
        
        if let first = firstSelection {
            // Second button selected, check for match
            if first.color == selectedColor {
                print("Match found!")
                assignRandomColors() // Reassign colors
            } else {
                print("No match!")
            }
            firstSelection = nil // Reset selection
        } else {
            // First button selected
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
