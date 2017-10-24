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
        fastText.trainSupervised(trainingData)
    }
    
    private func preprocess(_ text: String) -> String {
        struct Constants {
            static let ValidChars : Set<Character> = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890".characters)
        }
        return String(text.characters.filter {Constants.ValidChars.contains($0) }).lowercased()
    }
    
    func testPredict() {
        
        var trainingData = [TrainingData]()
        
        trainingData.append(TrainingData(label: "query_person",
                                         data: preprocess("Can you tell me about primitive_person?")))
        trainingData.append(TrainingData(label: "query_person",
                                         data: preprocess("Can you tell me anything about primitive_person?")))
        trainingData.append(TrainingData(label: "query_person",
                                         data: preprocess("Do you know primitive_person?")))
        trainingData.append(TrainingData(label: "query_person",
                                         data: preprocess("Have you heard about primitive_person?")))
        trainingData.append(TrainingData(label: "query_person",
                                         data: preprocess("Have you heard of primitive_person?")))
        trainingData.append(TrainingData(label: "query_person",
                                         data: preprocess("What can you tell me about primitive_person?")))
        trainingData.append(TrainingData(label: "query_person",
                                         data: preprocess("What do you know about primitive_person?")))

        let fastText = FastText()
        let modelPath = fastText.trainSupervised(trainingData)
        
        let results = fastText.predict(modelPath, text: preprocess("Do you know primitive_person"))
        //fastText.predict(modelPath, text: "Are you a piglet?")
        
        print("\n\n\n")
        for result in results {
            print("label: \(result.label) confidence: \(result.confidence)")
        }
        print("\n\n\n")
    }
}

// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.
