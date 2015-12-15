//
//  CardView.m
//  CardGame
//
//  Created by Shachar Langbeheim on 10/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "PlayingCardView.h"

#import "PlayingCardFaceView.h"
#import "PlayingCardBackView.h"

@interface PlayingCardView()
@property (nonatomic)BOOL faceUp;
@property (nonatomic, strong) IBOutlet PlayingCardFaceView *faceView;
@property (nonatomic, strong) IBOutlet PlayingCardBackView *backView;
@end

@implementation PlayingCardView

- (void)chooseCard:(BOOL)chosen {
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
  for (UIView *subview in self.subviews) {
    if([subview isKindOfClass:[PlayingCardFaceView class]]) {
      self.faceView = (PlayingCardFaceView *)subview;
    }
    else {
      self.backView = (PlayingCardBackView *)subview;
    }
  }
  
  self.faceView.rank = [attributes[0] intValue];
  self.faceView.suit = attributes[1];
  self.faceUp = NO;
  for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
    recognizer.enabled = YES;
  }
  self.faceView.cardAlpha = 1;
}

- (void)matchCard{
  for (UIGestureRecognizer *recognizer in self.gestureRecognizers)  {
    self.faceView.cardAlpha = 0.3;
    recognizer.enabled = NO;
  }
}

- (void)setup{
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib {
  [self setup];
}

@end
