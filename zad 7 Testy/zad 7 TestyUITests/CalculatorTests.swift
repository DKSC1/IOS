import XCTest
@testable import zad_7_Testy

final class ContentViewTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }
    
    func test1() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("5")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("3")
        XCTAssertTrue(app.staticTexts["Wynik: Dziesiętnie: 8"].exists)
    }
    
    func test2() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("-5")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("-3")
        XCTAssertTrue(app.staticTexts["Wynik: Dziesiętnie: -8"].exists)
    }
    
    func test3() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("5")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("3")
        app.buttons["Base 2"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Binarnie: 1000"].exists)
    }
    
    func test4() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("5")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("3")
        app.buttons["Base 8"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Ósemkowo: 10"].exists)
    }
    
    func test5() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("5")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("3")
        app.buttons["Base 16"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Szesnastkowo: 8"].exists)
        app.textFields["Wpisz pierwszą liczbę"].tap()
    }
    
    func test6() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("10")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("5")
        app.buttons["-"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Dziesiętnie: 5"].exists)
    }
    
    func test7() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("-10")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("-5")
        app.buttons["-"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Dziesiętnie: -5"].exists)
    }
    
    func test8() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("10")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("5")
        app.buttons["-"].tap()
        app.buttons["Base 2"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Binarnie: 101"].exists)
    }
    
    func test9() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("10")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("5")
        app.buttons["-"].tap()
        app.buttons["Base 8"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Ósemkowo: 5"].exists)
    }
    
    func test10() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("10")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("5")
        app.buttons["-"].tap()
        app.buttons["Base 16"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Szesnastkowo: 5"].exists)
    }
    
    func test11() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("5")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("3")
        app.buttons["*"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Dziesiętnie: 15"].exists)
    }
    
    func test12() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("-5")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("3")
        app.buttons["*"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Dziesiętnie: -15"].exists)
    }
    
    func test13() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("5")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("3")
        app.buttons["*"].tap()
        app.buttons["Base 2"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Binarnie: 1111"].exists)
    }
    
    func test14() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("5")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("3")
        app.buttons["*"].tap()
        app.buttons["Base 8"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Ósemkowo: 17"].exists)
    }
    
    func test15() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("6")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("2")
        app.buttons["*"].tap()
        app.buttons["Base 8"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Ósemkowo: 14"].exists)
    }
    
    func test16() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("10")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("2")
        app.buttons["/"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Dziesiętnie: 5"].exists)
    }
    
    func test17() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("-10")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("2")
        app.buttons["/"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Dziesiętnie: -5"].exists)
    }
    
    func test18() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("10")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("2")
        app.buttons["/"].tap()
        app.buttons["Base 2"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Binarnie: 101"].exists)
    }
    
    func test19() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("10")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("2")
        app.buttons["/"].tap()
        app.buttons["Base 8"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Ósemkowo: 5"].exists)
    }
    
    func test20() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("10")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("2")
        app.buttons["/"].tap()
        app.buttons["Base 16"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Szesnastkowo: 5"].exists)
    }
    
    func test21() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("0")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("5")
        XCTAssertTrue(app.staticTexts["Wynik: Dziesiętnie: 5"].exists)
    }
    
    func test22() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("5")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("0")
        app.buttons["-"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Dziesiętnie: 5"].exists)
    }
    
    func test23() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("5")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("0")
        app.buttons["*"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Dziesiętnie: 0"].exists)
    }
    
    func test24() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("5")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("0")
        app.buttons["/"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Błąd: Dzielenie przez zero"].exists)
    }
    
    func test25() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("1000000")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("1000000")
        XCTAssertTrue(app.staticTexts["Wynik: Dziesiętnie: 2000000"].exists)
    }
    
    func test26() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("5.5")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("2.2")
        XCTAssertTrue(app.staticTexts["Wynik: Błąd"].exists)
    }
    
    func test27() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Błąd"].exists) 
    }
    
    func test28() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("abc")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("def")
        XCTAssertTrue(app.staticTexts["Wynik: Błąd"].exists)
    }
    
    func test29() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("5")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("3")
        app.buttons["-"].tap()
        XCTAssertTrue(app.staticTexts["Wynik: Dziesiętnie: 2"].exists)
    }
    
    func test30() {
        app.textFields["Wpisz pierwszą liczbę"].tap()
        app.textFields["Wpisz pierwszą liczbę"].typeText("5")
        app.textFields["Wpisz drugą liczbę"].tap()
        app.textFields["Wpisz drugą liczbę"].typeText("3")
        app.buttons["Base 2"].tap()
    }
}
