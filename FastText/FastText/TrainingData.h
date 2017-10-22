// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.

// MacOs
#import <Foundation/Foundation.h>

@interface TrainingData : NSObject

@property (nonatomic, strong, nonnull) NSArray<NSString*>* labels;
@property (nonatomic, strong, nonnull) NSString* data;

- (nonnull instancetype) init:(nonnull NSArray<NSString*>*)labels data:(nonnull NSString*)data;

@end

// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.
