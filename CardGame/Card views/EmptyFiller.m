// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "EmptyFiller.h"

NS_ASSUME_NONNULL_BEGIN

@implementation EmptyFiller
- (UIBezierPath *)createFill:(UIBezierPath *)shape {
  [[UIColor whiteColor] setFill];
  [shape fill];
  return shape;
}
@end

NS_ASSUME_NONNULL_END
