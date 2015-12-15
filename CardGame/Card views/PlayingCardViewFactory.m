// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "PlayingCardViewFactory.h"

#import "PlayingCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardViewFactory
- (id<CardView>)makeCardViewWithAttributes:(NSArray *)attributes andFrame:(CGRect)frame {
  PlayingCardView *card = [[PlayingCardView alloc] initWithFrame:frame];
  card.faceView = [[PlayingCardFaceView alloc]
                   initWithFrame:CGRectMake(0, 0,  frame.size.width, frame.size.height)];
  card.backView = [[PlayingCardBackView alloc]
                   initWithFrame:CGRectMake(0, 0,  frame.size.width, frame.size.height)];
  [card setCard:attributes];
  [card setup];
  return card;
}
@end

NS_ASSUME_NONNULL_END
