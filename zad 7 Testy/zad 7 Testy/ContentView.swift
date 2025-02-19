import SwiftUI

struct ContentView: View {
    @State private var number1: String = ""
    @State private var number2: String = ""
    @State private var selectedOperation = "+"
    @State private var selectedBase = 10
    private let calculator = CalculatorModel()
    
    let operations = ["+", "-", "*", "/"]
    let bases = [2, 8, 10, 16]
    
    var computedResult: String {
        return calculator.computeResult(
            num1: number1,
            num2: number2,
            operation: selectedOperation,
            base: selectedBase
        )
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Kalkulator w SwiftUI")
                .font(.title)
            
            TextField("Wpisz pierwszą liczbę", text: $number1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            
            TextField("Wpisz drugą liczbę", text: $number2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            
            Picker("Wybierz operację", selection: $selectedOperation) {
                ForEach(operations, id: \ .self) { operation in
                    Text(operation)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Text("Wynik: \(computedResult)")
                .font(.headline)
                .padding()
            
            Picker("Wybierz system liczbowy", selection: $selectedBase) {
                ForEach(bases, id: \ .self) { base in
                    Text("Base \(base)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
    }
}

public struct CalculatorModel {
    func computeResult(num1: String, num2: String, operation: String, base: Int) -> String {
        guard let number1 = Int(num1), let number2 = Int(num2) else { return "Błąd" }
        
        let result: Int
        switch operation {
        case "+": result = number1 + number2
        case "-": result = number1 - number2
        case "*": result = number1 * number2
        case "/":
            guard number2 != 0 else { return "Błąd: Dzielenie przez zero" }
            result = number1 / number2
        default: return "Błąd"
        }
        
        return convertNumber(result, toBase: base)
    }
    
    func convertNumber(_ number: Int, toBase base: Int) -> String {
        switch base {
        case 2: return "Binarnie: \(String(number, radix: 2))"
        case 8: return "Ósemkowo: \(String(number, radix: 8))"
        case 10: return "Dziesiętnie: \(number)"
        case 16: return "Szesnastkowo: \(String(number, radix: 16).uppercased())"
        default: return "Błąd"
        }
    }
}

#Preview {
    ContentView()
}
