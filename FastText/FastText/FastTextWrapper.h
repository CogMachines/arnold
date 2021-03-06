// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.

// MacOS
#import <Foundation/Foundation.h>

// Forward declarations
@class Prediction;
@class TrainingData;

@interface FastText : NSObject

- (nonnull NSString*) trainCbow:(nonnull NSArray<TrainingData*>*)data;
- (nonnull NSString*) trainSkipGram:(nonnull NSArray<TrainingData*>*)data;
- (nonnull NSString*) trainSupervised:(nonnull NSArray<TrainingData*>*)data;

- (nonnull NSArray<Prediction*>*) predict:(nonnull NSString*)modelPath text:(nonnull NSString*)inText;


@end

// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.
