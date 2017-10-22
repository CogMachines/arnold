// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.

// Self
#import "TrainingData.h"

@implementation TrainingData

- (nonnull instancetype)
init:(nonnull NSArray<NSString*>*)labels data:(nonnull NSString*)data;
{
    self = [super init];
    if (self) {        
        self.data = data;
        self.labels = labels;
    }
    return self;
}

@end

// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.
