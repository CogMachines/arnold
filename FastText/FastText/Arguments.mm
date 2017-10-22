// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.

// Self
#import "Arguments.h"

// System
#include <fstream>
#include <iostream>

// Local
#import "args.h"

@interface Arguments() {
 
    fasttext::Args mArgs;
}
@end

@implementation Arguments

- (NSString*)
input {
    return [NSString stringWithUTF8String:mArgs.input.c_str()];
}

- (void)
setInput:(NSString*)value {
    mArgs.input = value.UTF8String;
}

- (NSString*)
test {
    return [NSString stringWithUTF8String:mArgs.test.c_str()];
}

- (void)
setTest:(NSString*)value {
    mArgs.test = value.UTF8String;
}

- (NSString*)
output {
    return [NSString stringWithUTF8String:mArgs.output.c_str()];
}

- (void)
setOutput:(NSString*)value {
    mArgs.output = value.UTF8String;
}

- (NSString*)
label {
    return [NSString stringWithUTF8String:mArgs.label.c_str()];
}

- (void)
setLabel:(NSString*)value {
    mArgs.label = value.UTF8String;
}

- (NSString*)
pretrainedVectors {
    return [NSString stringWithUTF8String:mArgs.pretrainedVectors.c_str()];
}

- (void)
setPretrainedVectors:(NSString*)value {
    mArgs.pretrainedVectors = value.UTF8String;
}

- (int)
dim {
    return mArgs.dim;
}

- (void)
setDim:(int)inValue {
    mArgs.dim = inValue;
}

- (int)
ws {
    return mArgs.ws;
}

- (void)
setWs:(int)inValue {
    mArgs.ws = inValue;
}

- (int)
epoch {
    return mArgs.epoch;
}

- (void)
setEpoch:(int)inValue {
    mArgs.epoch = inValue;
}

- (int)
minCount {
    return mArgs.minCount;
}

- (void)
setMinCount:(int)inValue {
    mArgs.minCount = inValue;
}

- (int)
minCountLabel {
    return mArgs.minCountLabel;
}

- (void)
setMinCountLabel:(int)inValue {
    mArgs.minCountLabel = inValue;
}

- (int)
neg {
    return mArgs.neg;
}

- (void)
setNeg:(int)inValue {
    mArgs.neg = inValue;
}

- (int)
wordNgrams {
    return mArgs.wordNgrams;
}

- (void)
setWordNgrams:(int)inValue {
    mArgs.wordNgrams = inValue;
}

- (int)
bucket {
    return mArgs.bucket;
}

- (void)
setBucket:(int)inValue {
    mArgs.bucket = inValue;
}

- (int)
minn {
    return mArgs.minn;
}

- (void)
setMinn:(int)inValue {
    mArgs.minn = inValue;
}

- (int)
maxn {
    return mArgs.maxn;
}

- (void)
setMaxn:(int)inValue {
    mArgs.maxn = inValue;
}

- (int)
thread {
    return mArgs.thread;
}

- (void)
setThread:(int)inValue {
    mArgs.thread = inValue;
}

- (int)
verbose {
    return mArgs.verbose;
}

- (void)
setVerbose:(int)inValue {
    mArgs.verbose = inValue;
}

- (int)
saveOutput {
    return mArgs.saveOutput;
}

- (void)
setSaveOutput:(int)inValue {
    mArgs.saveOutput = inValue;
}

- (double)
t {
    return mArgs.t;
}

- (void)
setT:(double)inValue {
    mArgs.t = inValue;
}

- (bool)
qout {
    return mArgs.qout;
}

- (void)
setQout:(bool)inValue {
    mArgs.qout = inValue;
}

- (bool)
retrain {
    return mArgs.retrain;
}

- (void)
setRetrain:(bool)inValue {
    mArgs.retrain = inValue;
}

- (bool)
qnorm {
    return mArgs.qnorm;
}

- (void)
setQnorm:(bool)inValue {
    mArgs.qnorm = inValue;
}

- (size_t)
cutoff {
    return mArgs.cutoff;
}

- (void)
setCutoff:(size_t)inValue {
    mArgs.cutoff = inValue;
}

- (size_t)
dsub {
    return mArgs.dsub;
}

- (void)
setDsub:(size_t)inValue {
    mArgs.dsub = inValue;
}

- (loss_name)
loss {
    switch (mArgs.loss)
    {
        case fasttext::loss_name::hs:
            return hs;

        case fasttext::loss_name::ns:
            return ns;

        case fasttext::loss_name::softmax:
            return softmax;
    }
}

- (void)
setLoss:(loss_name)inValue {
    
    switch (inValue)
    {
        case hs:
            mArgs.loss = fasttext::loss_name::hs;
            break;
            
        case ns:
            mArgs.loss = fasttext::loss_name::ns;
            break;

        case softmax:
            mArgs.loss = fasttext::loss_name::softmax;
            break;
    }
}

- (model_name)
model {
    switch (mArgs.model)
    {
        case fasttext::model_name::cbow:
            return cbow;
            
        case fasttext::model_name::sg:
            return sg;
            
        case fasttext::model_name::sup:
            return sup;
    }
}

- (void)
setModel:(model_name)inValue {
    
    switch (inValue)
    {
        case cbow:
            mArgs.model = fasttext::model_name::cbow;
            break;
            
        case sg:
            mArgs.model = fasttext::model_name::sg;
            break;
            
        case sup:
            mArgs.model = fasttext::model_name::sup;
            break;
    }
}

- (void)
parseArgs:(NSArray<NSString*>*) args {
    std::vector<std::string> arguments;
    for (NSString* arg : args) {
        arguments.push_back(arg.UTF8String);
    }
    mArgs.parseArgs(arguments);
}

- (void)
printHelp {
    mArgs.printHelp();
}

- (void)
printBasicHelp {
    mArgs.printBasicHelp();
}

- (void)
printDictionaryHelp {
    mArgs.printDictionaryHelp();
}

- (void)
printTrainingHelp {
    mArgs.printTrainingHelp();
}

- (void)
printQuantizationHelp {
    mArgs.printQuantizationHelp();
}

- (void)
save:(NSString*)path {
    const std::string thePath = path.UTF8String;
    std::ofstream stream(thePath.c_str());
    mArgs.save(stream);
}

- (void)
load:(NSString*)path {
    const std::string thePath = path.UTF8String;
    std::ifstream stream(thePath.c_str());
    mArgs.load(stream);
}

@end

// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.
