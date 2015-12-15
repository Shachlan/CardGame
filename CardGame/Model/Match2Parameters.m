// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "Match2Parameters.h"

NS_ASSUME_NONNULL_BEGIN

@implementation Match2Parameters
- (int) initialNumberOfCards {
  return 25;
}

- (int) numberOfCardsToMatch {
  return 2;
}

- (int) matchMultiplier {
  return 2;
}
@end

NS_ASSUME_NONNULL_END
