// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "SetCardViewFactory.h"

#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardViewFactory
- (id<CardView>)makeCardViewWithAttributes:(NSArray *)attributes  andFrame:(CGRect)frame{
  SetCardView *card = [[SetCardView alloc] initWithFrame:frame];
  [card setCard:attributes];
  return card;
}
@end

NS_ASSUME_NONNULL_END
