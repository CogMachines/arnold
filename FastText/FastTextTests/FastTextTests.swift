// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.

// MaxOS
import XCTest

// Local
@testable import FastText

class FastTextTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTrain() {
        
        var trainingData = [TrainingData]()
        
        var trainingItem = TrainingData(label: "query", data: "Do you know Melanie?")
        trainingData.append(trainingItem)
        
        trainingItem = TrainingData(label: "query", data: "Do you know Reggie?")
        trainingData.append(trainingItem)

        let fastText = FastText()
        let results = fastText.trainSupervised(trainingData)
    }
    
    func testPredict() {
        
        var trainingData = [TrainingData]()
        
        var trainingItem = TrainingData(label: "query", data: "Do you know Melanie?")
        trainingData.append(trainingItem)
        
        trainingItem = TrainingData(label: "query", data: "Do you know Reggie?")
        trainingData.append(trainingItem)
        
        let fastText = FastText()
        let modelPath = fastText.trainSupervised(trainingData)
        
        fastText.predict(modelPath, text: "Do you know Melanie?")
    }
    
}

// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.
