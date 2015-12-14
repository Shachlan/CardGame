// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "DiamondCreator.h"

NS_ASSUME_NONNULL_BEGIN

@implementation DiamondCreator
- (UIBezierPath *)createShape:(CGRect)rect{
  UIBezierPath *diamond = [UIBezierPath bezierPath];
  [diamond setLineJoinStyle:kCGLineJoinMiter];
  
  float halfWidth = rect.origin.x + (rect.size.width / 2);
  float halfHeight = rect.origin.y + (rect.size.height / 2);
  float fullHeight = rect.origin.y + rect.size.height;
  float fullWidth = rect.origin.x + rect.size.width;
  
  [diamond moveToPoint:CGPointMake(rect.origin.x, halfHeight)];
  [diamond addLineToPoint:CGPointMake(halfWidth, fullHeight)];
  [diamond addLineToPoint:CGPointMake(fullWidth, halfHeight)];
  [diamond addLineToPoint:CGPointMake(halfWidth, rect.origin.y)];
  [diamond closePath];
  
  return diamond;
}
@end

NS_ASSUME_NONNULL_END
