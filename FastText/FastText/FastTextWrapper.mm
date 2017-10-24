// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.

//supervised     train a supervised classifier
//test           evaluate a supervised classifier
//predict        predict most likely labels
//predict-prob   predict most likely labels with probabilities
//skipgram       train a skipgram model
//cbow           train a cbow model
//print-vectors  print vectors given a trained model

// Self
#import "FastTextWrapper.h"

// System
#import <cstddef>
#import <sstream>

// FastText
#import "fasttext/args.h"
#import "fasttext/fasttext.h"

// Local
#import "Prediction.h"
#import "TrainingData.h"

enum class ModelName {
    Cbow,
    SkipGram,
    Supervised
};

@interface FastText()
{
    //std::unique_ptr<fasttext::FastText> mFastText;
}
@end


@implementation FastText

- (instancetype)
init {
    self = [super init];
    if (self) {
        //mFastText = std::unique_ptr<fasttext::FastText>(new fasttext::FastText());
    }
    return self;
}

- (nonnull NSString*)
trainCbow:(nonnull NSArray<TrainingData*>*)data {
    return [self train:ModelName::Cbow data:data];
}

- (nonnull NSString*)
trainSkipGram:(nonnull NSArray<TrainingData*>*)data {
    return [self train:ModelName::SkipGram data:data];
}

- (nonnull NSString*)
trainSupervised:(nonnull NSArray<TrainingData*>*)data {
    return [self train:ModelName::Supervised data:data];
}

- (nonnull NSString*)
train:(ModelName)type data:(nonnull NSArray<TrainingData*>*)inData {
    
    // Map the ModelName to the fasttext model
    const auto args = std::make_shared<fasttext::Args>();

    switch (type)
    {
        case ModelName::SkipGram:
        {
            args->model = fasttext::model_name::sg;
            break;
        }
            
        case ModelName::Cbow:
        {
            args->model = fasttext::model_name::cbow;
            break;
        }
            
        case ModelName::Supervised:
        {
            args->model = fasttext::model_name::sup;
            args->loss = fasttext::loss_name::softmax;
            args->minCount = 1;
            args->minn = 0;
            args->maxn = 0;
            args->lr = 0.1;
            
            args->epoch = 500;
            break;
        }
    }
    
    // Convert the training data to an array of strings
    NSMutableArray<NSString*>* dataArray = [NSMutableArray new];
    for (TrainingData* trainingData : inData) {
        NSString* const dataString = [trainingData getLabeledData];
        [dataArray addObject:dataString];
    }
    
    // Write the training data to a file
    NSURL* dataURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"data.train"]];
    NSString* dataContent = [dataArray componentsJoinedByString: @"\n"];
    [dataContent writeToURL:dataURL atomically:NO encoding:NSUTF8StringEncoding error:nil];
    args->input = dataURL.path.UTF8String;

    // Set the results location
    NSURL* modelURL = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"data"]];
    args->output = modelURL.path.UTF8String;
    
    // Train the model
    fasttext::FastText fasttext;
    fasttext.train(args);
    
    return [NSString stringWithFormat:@"%@.bin", modelURL.path];
}

- (NSArray<Prediction*>*)
predict:(nonnull NSString*)modelPath text:(nonnull NSString*)inText {
    
    // Make the prediction
    fasttext::FastText fasttext;
    fasttext.loadModel(std::string(modelPath.UTF8String));
    const std::string inTextString(inText.UTF8String);
    std::istringstream stringStream(inTextString.c_str()); 
    std::vector<std::pair<fasttext::real, std::string>> predictions;
    fasttext.predict(stringStream, 1, predictions);
    
    // Populate the results
    NSMutableArray* results = [NSMutableArray<Prediction*> new];
    for (const auto& pred : predictions) {
        Prediction* prediction = [Prediction new];
        prediction.confidence = pred.first;
        prediction.label = [NSString stringWithUTF8String: pred.second.c_str()];
        [results addObject:prediction];
    }

    return results;
}

@end

// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.
