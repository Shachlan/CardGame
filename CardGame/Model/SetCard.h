//
//  SetCard.h
//  CardGame
//
//  Created by Shachar Langbeheim on 09/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "Card.h"

#import <UIKit/UIKit.h>

@interface SetCard : Card

@property (nonatomic, strong, readonly) NSNumber *fillLevel;
@property (nonatomic, strong, readonly) UIColor *color;
@property (nonatomic, strong, readonly) NSNumber *shape;
@property (nonatomic, readonly) int number;

- (void)setCard:(int)numOfChars color:(UIColor *)color fillLevel:(NSNumber *)fillLevel shape:(NSString *)shape;

+ (NSArray *)fillLevels;
+ (NSArray *)colors;
+ (NSArray *)shapes;

@end
