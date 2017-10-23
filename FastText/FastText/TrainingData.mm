// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.

// Self
#import "TrainingData.h"

// System
#import <string>

// Local
#import "Arguments.h"

static const Arguments* sArguments = [Arguments new];

@implementation TrainingData

- (nonnull instancetype)
initWithLabel:(nonnull NSString*)label data:(nonnull NSString*)data {
    
    self = [super init];
    if (self) {
        self.data = data;
        self.labels = @[ label ];
    }
    return self;
}

- (nonnull instancetype)
initWithLabels:(nonnull NSArray<NSString*>*)labels data:(nonnull NSString*)data;
{
    self = [super init];
    if (self) {        
        self.data = data;
        self.labels = labels;
    }
    return self;
}

- (nonnull NSString*)
getLabeledData {
    
    const std::string prefix = sArguments.label.UTF8String;
    
    std::string result;
    
    for (NSString* label in self.labels) {
        result += prefix + label.UTF8String + " ";
    }
    result += self.data.UTF8String;
    
    return [NSString stringWithUTF8String:result.c_str()];
}

@end

// CogMachines, LLC. Confidential Information.
// TM and (c) 2017-present Semitone Inc.  All Rights Reserved.
// Reproduction in whole or in part without prior written permission of a
// duly authorized representative is prohibited.
