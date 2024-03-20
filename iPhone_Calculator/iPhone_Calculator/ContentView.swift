import SwiftUI

struct ContentView: View {
    // Calculator button layout
    @State private var numsAndOperations: [[String]] = [
        ["AC", "+/-", "%", "÷"],
        ["7", "8", "9", "x"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]

    // Display text
    @State private var displayText = "0"

    // Additional state variables
    @State private var currentInput = ""
    @State private var previousInput = ""
    @State private var currentOperator: String?

    // Number formatter for displaying commas in numbers
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    // Function to handle button presses
    func buttonPressed(_ value: String) {
        if value == "AC" {
            // Clear the calculator
            currentInput = ""
            previousInput = ""
            currentOperator = nil
            displayText = "0"
        } else if value == "+/-" {
            // Handle the +/- button press
            if let value = Double(currentInput) {
                currentInput = String(-value)
                displayText = numberFormatter.string(from: NSNumber(value: Double(currentInput) ?? 0)) ?? "0"
            }
        } else if value == "%" {
            // Handle the % button press
            if let value = Double(currentInput) {
                currentInput = String(value / 100.0)
                displayText = numberFormatter.string(from: NSNumber(value: Double(currentInput) ?? 0)) ?? "0"
            }
        } else if value == "=" {
            // Handle the = button press
            if let num1 = Double(previousInput), let num2 = Double(currentInput) {
                if currentOperator == "+" {
                    currentInput = String(num1 + num2)
                } else if currentOperator == "-" {
                    currentInput = String(num1 - num2)
                } else if currentOperator == "x" {
                    currentInput = String(num1 * num2)
                } else if currentOperator == "÷" {
                    if num2 != 0 {
                        currentInput = String(num1 / num2)
                    } else {
                        // Handle division by zero
                        currentInput = "Error"
                        displayText = currentInput
                        return
                    }
                }

                // Format the result with commas
                displayText = numberFormatter.string(from: NSNumber(value: Double(currentInput) ?? 0)) ?? "0"

                currentOperator = nil
            }
        } else if value == "+" || value == "-" || value == "x" || value == "÷" {
            // Handle operator button presses
            previousInput = currentInput
            currentOperator = value
            displayText = numberFormatter.string(from: NSNumber(value: Double(currentInput) ?? 0)) ?? "0"
            currentInput = ""
        } else if value == "C" {
            // Change AC to C and clear current input
            currentInput = ""
            displayText = "0"
            numsAndOperations[0][0] = currentInput.isEmpty ? "AC" : "C"
        } else {
            // Handle numeric button presses
            currentInput += value
            displayText = numberFormatter.string(from: NSNumber(value: Double(currentInput) ?? 0)) ?? "0"
            // Change AC to C when number is pressed
            numsAndOperations[0][0] = "C"
        }
    }

    var body: some View {
        VStack(spacing: 10) {
            Spacer()

            Text(displayText)
                .font(.system(size: 85))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 11))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .background(Color.black)
                .foregroundColor(.white)
                .lineLimit(1)  // Set lineLimit to 1 to ensure single line display
                .minimumScaleFactor(0.5)  // Adjust minimumScaleFactor as needed

            // Button rows
            HStack(spacing: 10) {
                // Buttons for AC, +/-, %, and ÷
                Button(action: { self.buttonPressed("AC") }) {
                    Text("AC")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.black)
                        .background(Color(red: 165.0/255.0, green: 165.0/255.0, blue: 165.0/255.0))
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }

                Button(action: { self.buttonPressed("+/-") }) {
                    Text("+/-")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.black)
                        .background(Color(red: 165.0/255.0, green: 165.0/255.0, blue: 165.0/255.0))
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }

                Button(action: { self.buttonPressed("%") }) {
                    Text("%")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.black)
                        .background(Color(red: 165.0/255.0, green: 165.0/255.0, blue: 165.0/255.0))
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }

                Button(action: { self.buttonPressed("÷") }) {
                    Text("÷")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.white)
                        .background(Color(red: 255.0/255.0, green: 158.0/255.0, blue: 11.0/255.0))
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
            }

            // Row 2
            HStack(spacing: 10) {
                // Buttons for 7, 8, 9, and x
                Button(action: { self.buttonPressed("7") }) {
                    Text("7")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.white)
                        .background(Color(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0))
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }

                Button(action: { self.buttonPressed("8") }) {
                    Text("8")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.white)
                        .background(Color(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0))
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                Button(action: { self.buttonPressed("9") }) {
                    Text("9")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.white)
                        .background(Color(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0))
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                Button(action: { self.buttonPressed("x") }) {
                    Text("x")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.white)
                        .background(Color(red: 255.0/255.0, green: 158.0/255.0, blue: 11.0/255.0))
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
            }

            // Row 3
            HStack(spacing: 10) {
                // Buttons for 4, 5, 6, and -
                Button(action: { self.buttonPressed("4") }) {
                    Text("4")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.white)
                        .background(Color(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0))
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                Button(action: { self.buttonPressed("5") }) {
                    Text("5")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.white)
                        .background(Color(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0))
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                Button(action: { self.buttonPressed("6") }) {
                    Text("6")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.white)
                        .background(Color(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0))
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }

                Button(action: { self.buttonPressed("-") }) {
                    Text("-")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
            }

            // Row 4
            HStack(spacing: 10) {
                // Buttons for 1, 2, 3, and +
                Button(action: { self.buttonPressed("1") }) {
                    Text("1")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.white)
                        .background(Color(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0))
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }

                Button(action: { self.buttonPressed("2") }) {
                    Text("2")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.white)
                        .background(Color(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0))
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }

                Button(action: { self.buttonPressed("3") }) {
                    Text("3")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.white)
                        .background(Color(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0))
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                Button(action: { self.buttonPressed("+") }) {
                    Text("+")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.white)
                        .background(Color(red: 255.0/255.0, green: 158.0/255.0, blue: 11.0/255.0))
                        .cornerRadius(75)
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
            }

            // Row 5
            HStack(spacing: 10) {
                // Buttons for 0, ., and =
                Button(action: { self.buttonPressed("0") }) {
                    Text("0")
                        .font(.title)
                        .frame(width: 180, height: 85)  // Make the "0" button wider
                        .foregroundColor(.white)
                        .background(Color(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0))
                        .cornerRadius(75)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.clear, lineWidth: 1)
                        )
                }

                Button(action: { self.buttonPressed(".") }) {
                    Text(".")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.white)
                        .background(Color(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0))
                        .cornerRadius(75)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.clear, lineWidth: 1)
                        )
                }

                Button(action: { self.buttonPressed("=") }) {
                    Text("=")
                        .font(.title)
                        .frame(width: 85, height: 85)
                        .foregroundColor(.white)
                        .background(Color(red: 255.0/255.0, green: 158.0/255.0, blue: 11.0/255.0))
                        .cornerRadius(75)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
                        .overlay(
                            RoundedRectangle(cornerRadius: 75)
                                .stroke(Color.clear, lineWidth: 1)
                        )
                }
            }
        }
        .padding()
                .background(Color.black) // Set the background color to black
                .edgesIgnoringSafeArea(.all) // Ignore safe area for full-screen effect
            }
        }

        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
