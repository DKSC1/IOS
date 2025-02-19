
import XCTest
@testable import zad_7_Testy // Zmień na rzeczywistą nazwę Twojego modułu

final class CalculatorTests: XCTestCase {
    var calculator: CalculatorModel!
    
    override func setUp() {
        super.setUp()
        calculator = CalculatorModel()
    }
    
    override func tearDown() {
        calculator = nil
        super.tearDown()
    }
    
    func testAddition() {
        XCTAssertEqual(calculator.computeResult(num1: "5", num2: "3", operation: "+", base: 10), "Dziesiętnie: 8")
        XCTAssertEqual(calculator.computeResult(num1: "2", num2: "3", operation: "+", base: 2), "Binarnie: 101")
        XCTAssertEqual(calculator.computeResult(num1: "7", num2: "1", operation: "+", base: 8), "Ósemkowo: 10")
        XCTAssertEqual(calculator.computeResult(num1: "15", num2: "1", operation: "+", base: 16), "Szesnastkowo: 10")
        XCTAssertEqual(calculator.computeResult(num1: "abc", num2: "3", operation: "+", base: 10), "Błąd")
    }
    
    func testSubtraction() {
        XCTAssertEqual(calculator.computeResult(num1: "9", num2: "4", operation: "-", base: 10), "Dziesiętnie: 5")
        XCTAssertEqual(calculator.computeResult(num1: "10", num2: "1", operation: "-", base: 2), "Binarnie: 1001")
        XCTAssertEqual(calculator.computeResult(num1: "12", num2: "2", operation: "-", base: 8), "Ósemkowo: 12")
        XCTAssertEqual(calculator.computeResult(num1: "20", num2: "10", operation: "-", base: 16), "Szesnastkowo: A")
        XCTAssertEqual(calculator.computeResult(num1: "xyz", num2: "3", operation: "-", base: 10), "Błąd")
    }
    
    func testMultiplication() {
        XCTAssertEqual(calculator.computeResult(num1: "4", num2: "3", operation: "*", base: 10), "Dziesiętnie: 12")
        XCTAssertEqual(calculator.computeResult(num1: "2", num2: "2", operation: "*", base: 2), "Binarnie: 100")
        XCTAssertEqual(calculator.computeResult(num1: "3", num2: "3", operation: "*", base: 8), "Ósemkowo: 11")
        XCTAssertEqual(calculator.computeResult(num1: "5", num2: "2", operation: "*", base: 16), "Szesnastkowo: A")
        XCTAssertEqual(calculator.computeResult(num1: "xyz", num2: "3", operation: "*", base: 10), "Błąd")
    }
    
    func testDivision() {
        XCTAssertEqual(calculator.computeResult(num1: "8", num2: "2", operation: "/", base: 10), "Dziesiętnie: 4")
        XCTAssertEqual(calculator.computeResult(num1: "4", num2: "2", operation: "/", base: 2), "Binarnie: 10")
        XCTAssertEqual(calculator.computeResult(num1: "10", num2: "2", operation: "/", base: 8), "Ósemkowo: 5")
        XCTAssertEqual(calculator.computeResult(num1: "12", num2: "3", operation: "/", base: 16), "Szesnastkowo: 4")
        XCTAssertEqual(calculator.computeResult(num1: "10", num2: "0", operation: "/", base: 10), "Błąd: Dzielenie przez zero")
    }
    
    func testInvalidInput() {
        XCTAssertEqual(calculator.computeResult(num1: "", num2: "5", operation: "+", base: 10), "Błąd")
        XCTAssertEqual(calculator.computeResult(num1: "abc", num2: "xyz", operation: "-", base: 2), "Błąd")
        XCTAssertEqual(calculator.computeResult(num1: "7", num2: "2", operation: "?", base: 8), "Błąd")
        XCTAssertEqual(calculator.computeResult(num1: "9", num2: "3", operation: "/", base: 99), "Błąd")
        XCTAssertEqual(calculator.computeResult(num1: "", num2: "", operation: "*", base: 16), "Błąd")
    }
    
    func testNegativeNumbers() {
        XCTAssertEqual(calculator.computeResult(num1: "-5", num2: "3", operation: "+", base: 10), "Dziesiętnie: -2")
        XCTAssertEqual(calculator.computeResult(num1: "-4", num2: "2", operation: "*", base: 10), "Dziesiętnie: -8")
        XCTAssertEqual(calculator.computeResult(num1: "-8", num2: "2", operation: "-", base: 10), "Dziesiętnie: -10")
        XCTAssertEqual(calculator.computeResult(num1: "-16", num2: "2", operation: "/", base: 10), "Dziesiętnie: -8")
        XCTAssertEqual(calculator.computeResult(num1: "-5", num2: "-3", operation: "*", base: 10), "Dziesiętnie: 15")
    }
}
