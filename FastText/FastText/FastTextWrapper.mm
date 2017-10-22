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

// FastText
#import "./fasttext/args.h"
#import "./fasttext/fasttext.h"


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

- (void)
trainCbow {
    //[self train:ModelName::Cbow];
}

- (void)
trainSkipGram {
    //[self train:ModelName::SkipGram];
}

- (void)
trainSupervised {
    //[self train:ModelName::Supervised];
}

- (nonnull NSArray<NSString*>*)
train:(ModelName)type input:(nonnull NSArray<NSString*>*)input {

    //./fasttext supervised -input cooking.train -output model_cooking -lr 1.0 -epoch 25 -wordNgrams 2
    
    fasttext::model_name modelName;

    switch (type)
    {
        case ModelName::SkipGram:
            modelName = fasttext::model_name::sg;
            break;
            
        case ModelName::Cbow:
            modelName = fasttext::model_name::cbow;
            break;
            
        case ModelName::Supervised:
            modelName = fasttext::model_name::sup;
            break;
    }
    
    TrainingData* data;
    
    const auto args = std::make_shared<fasttext::Args>();
    args->model = modelName;
    args->lr = 1.0;
    args->epoch = 25;
    args->wordNgrams = 2;
    
    fasttext::FastText fasttext;
    fasttext.train(args);
    
    NSArray* result = [NSArray new];
    return result;
}

@end

// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.
