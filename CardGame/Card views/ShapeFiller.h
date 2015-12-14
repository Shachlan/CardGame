// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ShapeFiller <NSObject>
- (UIBezierPath *)createFill:(UIBezierPath *)shape;
@end

NS_ASSUME_NONNULL_END
