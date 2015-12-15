// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

NS_ASSUME_NONNULL_BEGIN

@protocol GameParameters <NSObject>
@property (nonatomic,readonly) int initialNumberOfCards;
@property (nonatomic,readonly) int numberOfCardsToMatch;
@property (nonatomic,readonly) int matchMultiplier;

@end

NS_ASSUME_NONNULL_END
