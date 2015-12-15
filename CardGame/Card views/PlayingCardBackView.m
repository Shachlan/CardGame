// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "PlayingCardBackView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardBackView

#define CORNER_RADIUS 12.0

- (void)drawRect:(CGRect)rect{
  // Drawing code
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                         cornerRadius:CORNER_RADIUS];
  
  [roundedRect addClip];
  
  [[UIImage imageNamed:@"cardback.png"] drawInRect:self.bounds];
  
  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
}

- (void)setup{
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}
@end

NS_ASSUME_NONNULL_END
