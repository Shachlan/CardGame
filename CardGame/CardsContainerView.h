// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import <UIKit/UIKit.h>

#import "CardView.h"
#import "ScoreUpdater.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardsContainerView : UIView
- (void)reset;
@property (nonatomic, weak) id<ScoreUpdater> scoreUpdater;
@end

NS_ASSUME_NONNULL_END
