// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "SetCardView.h"

#import "../SetEnums.h"
#import "ShapeFiller.h"
#import "ShapeCreator.h"
#import "OvalCreator.h"
#import "EmptyFiller.h"
#import "StripesFiller.h"
#import "FullFiller.h"
#import "SquiggleCreator.h"
#import "DiamondCreator.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView()
@property (nonatomic, weak) UIColor *color;
@property (nonatomic) int number;
@property (nonatomic) float cardAlpha;
@property (nonatomic, strong) id<ShapeCreator> shapeCreator;
@property (nonatomic, strong) id<ShapeFiller> shapeFiller;
@end

@implementation SetCardView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if(self) {
    [self setup];
  }
  
  return self;
}

- (void)setup {
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
  self.cardAlpha = 1;
}

#define CORNER_RADIUS 12.0

- (void)drawRect:(CGRect)rect {
  // Drawing code
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                         cornerRadius:CORNER_RADIUS];
  
  [roundedRect addClip];
  
  [[[UIColor whiteColor] colorWithAlphaComponent:self.cardAlpha] setFill];
  UIRectFill(self.bounds);

  [[UIColor blackColor] setStroke];
  [roundedRect stroke];
  
  [self.color setFill];
  [self.color setStroke];
  
  float xSize = rect.size.width * 0.8;
  float ySize = rect.size.height * 0.2;
  float xOffset = rect.size.width * 0.1;
  float yRange = rect.size.height / (self.number);
  float yOffset = (yRange - ySize) / 2;
  
  for(int i = 0; i < self.number; i++) {
    CGRect drawingBounds = CGRectMake(rect.origin.x + xOffset,
                                      yOffset * (1 + (2*i)) + (i * ySize),
                                      xSize,
                                      ySize);
    
    UIBezierPath *path = [self.shapeCreator createShape:drawingBounds];
    int lineWidth = (int)(rect.size.width / 20);
    [path setLineWidth:lineWidth];
    
    UIBezierPath *fill = [self.shapeFiller createFill:path];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [path fill];
    
    // draw the fill pattern first, using the outline to clip
    CGContextSaveGState( context );         // save the graphics state
    [path addClip];                        // use the outline as the clipping path
    [[UIColor whiteColor] set];              // blue color for vertical stripes
    [fill stroke];                       // draw the stripes
    CGContextRestoreGState( context );
    
    [path stroke];
  }
}

#pragma mark - card view implementation

- (void)chooseCard:(BOOL)chosen{
  self.cardAlpha = chosen ? 0.5 : 1;
  [self setNeedsDisplay];
}

- (void)setCard:(NSArray *)attributes {
  self.number = [attributes[0] intValue];
  self.color = attributes[1];
  switch([attributes[2] intValue]) {
    case DIAMOND:
      self.shapeCreator = [[DiamondCreator alloc] init];
      break;
    case OVAL:
      self.shapeCreator = [[OvalCreator alloc] init];
      break;
    case SQUIGGLE:
      self.shapeCreator = [[SquiggleCreator alloc] init];
      break;
  }

  switch([attributes[3] intValue]) {
    case NO_FILL:
      self.shapeFiller = [[EmptyFiller alloc] init];
      break;
    case PARTIAL:
      self.shapeFiller = [[StripesFiller alloc] init];
      break;
    case FULL:
      self.shapeFiller = [[FullFiller alloc] init];
      break;
  }
}

- (void)matchCard {
  for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
    recognizer.enabled = NO;
  }
  
  float superWidth = self.superview.bounds.size.width;
  float superHeight = self.superview.bounds.size.height;
  CGPoint newCenter = CGPointMake(self.center.x + superWidth, self.center.y + superHeight);
  [UIView animateWithDuration:0.5 animations:^{ self.center = newCenter; } completion:^(BOOL completed) { [self removeFromSuperview]; } ];
}
@end

NS_ASSUME_NONNULL_END
