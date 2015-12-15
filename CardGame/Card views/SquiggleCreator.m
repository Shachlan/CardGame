// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "SquiggleCreator.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SquiggleCreator
- (UIBezierPath *)createShape:(CGRect)rect {
  UIBezierPath *squiggle = [UIBezierPath bezierPath];
  
  float widthOffset = 0.2 * rect.size.width;
  float heightOffset = 0.1 * rect.size.height;
  float leftJoint = rect.origin.x + widthOffset;
  float rightJoint = rect.origin.x + rect.size.width - widthOffset;
  float leftControlPointX = rect.origin.x;
  float rightControlPointX = rect.origin.x + rect.size.width;
  CGPoint leftArcControlPoint = CGPointMake(leftControlPointX,
                                            rect.origin.y + rect.size.height + heightOffset);
  CGPoint rightArcControlPoint = CGPointMake(rightControlPointX, rect.origin.y - heightOffset);
  
  float upperJoint = rect.origin.y + heightOffset;
  float lowerJoint = rect.origin.y + rect.size.height - heightOffset;
  CGPoint leftUpperJoint = CGPointMake(leftJoint, upperJoint);
  CGPoint leftLowerJoint = CGPointMake(leftJoint, lowerJoint);
  CGPoint rightUpperJoint = CGPointMake(rightJoint, upperJoint);
  CGPoint rightLowerJoint = CGPointMake(rightJoint, lowerJoint);
  
  float widthBetweenCurveControls = (rightJoint - leftJoint) / 3;
  float leftCurveControl = leftJoint + widthBetweenCurveControls;
  float rightCurveControl = rightJoint - widthBetweenCurveControls;
  
  float curveControlHeight = 0.4 * rect.size.height;
  CGPoint lowerLeftControlPoint = CGPointMake(leftCurveControl,
                                              lowerJoint - curveControlHeight);
  CGPoint upperLeftControlPoint = CGPointMake(leftCurveControl,
                                               upperJoint - curveControlHeight);
  CGPoint upperRightControlPoint = CGPointMake(rightCurveControl,
                                               upperJoint + curveControlHeight);
  CGPoint lowerRightControlPoint = CGPointMake(rightCurveControl,
                                               lowerJoint + curveControlHeight);
  
  [squiggle moveToPoint:leftUpperJoint];
  [squiggle addQuadCurveToPoint:leftLowerJoint
               controlPoint:leftArcControlPoint];
  [squiggle addCurveToPoint:rightLowerJoint
              controlPoint1:lowerLeftControlPoint
              controlPoint2:lowerRightControlPoint];
  [squiggle addQuadCurveToPoint:rightUpperJoint
                   controlPoint:rightArcControlPoint];
  [squiggle addCurveToPoint:leftUpperJoint
              controlPoint1:upperRightControlPoint
              controlPoint2:upperLeftControlPoint];
  
  [squiggle closePath];
  [squiggle setLineJoinStyle:kCGLineJoinRound];
  
  return squiggle;
}
@end

NS_ASSUME_NONNULL_END
