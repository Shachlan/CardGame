// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "SetParameters.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetParameters
- (int)initialNumberOfCards {
  return 12;
}

- (int)numberOfCardsToMatch {
  return 3;
}

- (int)matchMultiplier {
  return 4;
}

- (int)numberOfCardsToAdd {
  return 3;
}

@end

NS_ASSUME_NONNULL_END
