//
//  PlayingCard.h
//  CardGame
//
//  Created by Shachar Langbeheim on 07/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

@end
