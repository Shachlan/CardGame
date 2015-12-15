// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

NS_ASSUME_NONNULL_BEGIN

@protocol ScoreUpdater <NSObject>
- (void)updateScore:(int)score;
@end

NS_ASSUME_NONNULL_END
