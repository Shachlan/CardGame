// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCardFaceView : UIView
@property (nonatomic, strong)NSString *suit;
@property (nonatomic)NSUInteger rank;
@property (nonatomic) float cardAlpha;
@end

NS_ASSUME_NONNULL_END
