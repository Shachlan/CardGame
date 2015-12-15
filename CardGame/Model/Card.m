//
//  Card.m
//  CardGame
//
//  Created by Shachar Langbeheim on 07/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int) match:(NSArray *)otherCards {
    NSMutableArray *allCards = [otherCards mutableCopy];
    [allCards addObject:self];
    
    return [self matchCards:allCards];
}

- (int)matchCards:(NSArray *)cards {
    return 0;
}

@synthesize attributes = _attributes;

@end
