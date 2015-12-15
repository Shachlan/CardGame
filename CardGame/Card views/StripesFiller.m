// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "StripesFiller.h"

NS_ASSUME_NONNULL_BEGIN

@implementation StripesFiller
- (UIBezierPath *)createFill:(UIBezierPath *)shape {
  UIBezierPath *stripes = [UIBezierPath bezierPath];
  for (int x = shape.bounds.size.width / 20;
       x < shape.bounds.size.width;
       x += shape.bounds.size.width / 10) {
    [stripes moveToPoint:CGPointMake(shape.bounds.origin.x + x, shape.bounds.origin.y)];
    [stripes addLineToPoint:CGPointMake(shape.bounds.origin.x + x,
                                        shape.bounds.origin.y + shape.bounds.size.height )];
  }
  int lineWidth = (int)(shape.bounds.size.width / 20);
  [stripes setLineWidth:lineWidth];
  
  return stripes;
}
@end

NS_ASSUME_NONNULL_END
