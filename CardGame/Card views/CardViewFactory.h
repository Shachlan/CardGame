// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CardViewFactory <NSObject>
- (id<CardView>) makeCardViewWithAttributes:(NSArray *)attributes andFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
