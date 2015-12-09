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

- (int) match:(NSArray *)otherCards
{
    int score = 0;
    
    for(Card *card in otherCards)
    {
        if([card.contents isEqualToString:self.contents])
        {
            score = 1;
        }
    }
    
    return score;
}

- (int)matchSingleCard:(Card *)otherCard
{
    int score = 0;
    
    if([otherCard.contents isEqualToString:self.contents])
    {
        score = 1;
    }
    
    return score;
}

+ (int)matchCards:(NSArray *)cards
{
    int score = 0;
    
    for(int i = 0; i < [cards count] -1;i++)
    {
        for(int j = i+1; j < [cards count]; j++)
        {
            score += [[cards objectAtIndex:i] matchSingleCard:[cards objectAtIndex:j]];
        }
    }
    
    return score;
}

@end
