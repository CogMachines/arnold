// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.

// MacOS
#import <Foundation/Foundation.h>

enum model_name : int {
    cbow = 1,
    sg,
    sup
};

enum loss_name : int {
    hs = 1,
    ns,
    softmax
};

@interface Arguments : NSObject

@property (nonatomic, assign, nonnull) NSString* input;
@property (nonatomic, assign, nonnull) NSString* test;
@property (nonatomic, assign, nonnull) NSString* output;
@property (nonatomic, assign) double lr;
@property (nonatomic, assign) int lrUpdateRate;
@property (nonatomic, assign) int dim;
@property (nonatomic, assign) int ws;
@property (nonatomic, assign) int epoch;
@property (nonatomic, assign) int minCount;
@property (nonatomic, assign) int minCountLabel;
@property (nonatomic, assign) int neg;
@property (nonatomic, assign) int wordNgrams;
@property (nonatomic, assign) enum loss_name loss;
@property (nonatomic, assign) enum model_name model;
@property (nonatomic, assign) int bucket;
@property (nonatomic, assign) int minn;
@property (nonatomic, assign) int maxn;
@property (nonatomic, assign) int thread;
@property (nonatomic, assign) double t;
@property (nonatomic, assign, nonnull) NSString* label;
@property (nonatomic, assign) int verbose;
@property (nonatomic, assign, nonnull) NSString* pretrainedVectors;
@property (nonatomic, assign) int saveOutput;
@property (nonatomic, assign) bool qout;
@property (nonatomic, assign) bool retrain;
@property (nonatomic, assign) bool qnorm;
@property (nonatomic, assign) size_t cutoff;
@property (nonatomic, assign) size_t dsub;

- (void) parseArgs:(nonnull NSArray<NSString*>*) args;
- (void) printHelp;
- (void) printBasicHelp;
- (void) printDictionaryHelp;
- (void) printTrainingHelp;
- (void) printQuantizationHelp;
- (void) save:(nonnull NSString*) path;
- (void) load:(nonnull NSString*) path;

@end

// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.
