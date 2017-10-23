// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.

// MacOS
#import <Foundation/Foundation.h>

@interface TrainingData : NSObject

@property (nonatomic, strong, nonnull) NSArray<NSString*>* labels;
@property (nonatomic, strong, nonnull) NSString* data;

- (nonnull instancetype) initWithLabel:(nonnull NSString*)label data:(nonnull NSString*)data;
- (nonnull instancetype) initWithLabels:(nonnull NSArray<NSString*>*)labels data:(nonnull NSString*)data;

- (nonnull NSString*) getLabeledData;

@end

// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.
