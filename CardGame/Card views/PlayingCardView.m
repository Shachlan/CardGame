//
//  CardView.m
//  CardGame
//
//  Created by Shachar Langbeheim on 10/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()
@property (nonatomic)BOOL faceUp;
@property (nonatomic)BOOL matched;
@end

@implementation PlayingCardView

- (void)chooseCard:(BOOL)chosen {
  if(self.matched) {
    return;
  }
  if(chosen != self.faceUp) {
    self.faceUp = chosen;
    if(chosen) {
      self.faceView.hidden = NO;
      [UIView transitionFromView:self.backView
                          toView:self.faceView
                        duration:0.5
                         options:UIViewAnimationOptionTransitionFlipFromRight |
       UIViewAnimationOptionShowHideTransitionViews
                      completion:nil];
    }
    else {
      self.backView.hidden = NO;
      [UIView transitionFromView:self.faceView
                          toView:self.backView
                        duration:0.5
                         options:UIViewAnimationOptionTransitionFlipFromLeft |
       UIViewAnimationOptionShowHideTransitionViews
                      completion:nil];
    }
  }
}

- (void)setCard:(NSArray *)attributes {
  self.faceView.rank = [attributes[0] intValue];
  self.faceView.suit = attributes[1];
  self.faceUp = NO;
  for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
    recognizer.enabled = YES;
  }
  self.faceView.cardAlpha = 1;
}

- (void)setup {
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
  [self addSubview: self.faceView];
  [self addSubview:self.backView];
  [self.faceView setup];
  [self.backView setup];
}

- (void)matchCard{
  self.faceView.cardAlpha = 0.3;
  self.matched = YES;
}

@end
