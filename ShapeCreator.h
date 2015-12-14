// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ShapeCreator <NSObject>
- (UIBezierPath *)createShape:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
