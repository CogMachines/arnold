//: Playground - noun: a place where people can play

// MacOS
import Cocoa

// Local
import FastText

#if true
let fastText = FastText()
var trainingData = [TrainingData]()

trainingData.append(TrainingData(label: "query_person",
                                 data: "Do you know Melanie?"))

trainingData.append(TrainingData(label: "query_person",
                                 data: "Do you know Reggie?"))

print("Begin training...")
let modelPath = fastText.trainSupervised(trainingData)
print("Training complete: " + modelPath)

fastText.predict(modelPath, text: "Do you know Poppy?")

#endif

#if false
//: ## NSLinguisticTagger

let text: NSString = "Do you know about Reggie Bird?"

// Create a tagger with "nameType" scheme to find named entities
let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)

tagger.string = String(text)

// Whole range of text.
let range: NSRange = NSMakeRange(0, text.length)

// Consider compound names, like Apple Inc. as one word.
let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]

// Interested in all names.
//let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName]

var personals: [String] = []
var places: [String] = []
var organizations: [String] = []

// Enumerate through recognized tokens.
tagger.enumerateTags(in: range,
                     unit: .word,
                     scheme: .nameType,
                     options: options) { (tag, tokenRange, stop) in
    
    guard let tag = tag else { return }
    let token = text.substring(with: tokenRange)
    
    let word = (text as NSString).substring(with: tokenRange)
    print("\(word): \(tag)")

    switch tag {
    case .personalName: personals.append(token)
    case .placeName: places.append(token)
    case .organizationName: organizations.append(token)
    default: break
    }
}

print("""
    Persons:\n\(personals)\n\n
    Places:\n\(places)\n\n
    Organizations:\n\(organizations)\n\n
    """)
#endif

