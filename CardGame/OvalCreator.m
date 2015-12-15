// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "OvalCreator.h"

NS_ASSUME_NONNULL_BEGIN

@implementation OvalCreator
- (UIBezierPath *)createShape:(CGRect)rect {
  UIBezierPath *oval = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:12];
  return oval;
}
@end

NS_ASSUME_NONNULL_END
