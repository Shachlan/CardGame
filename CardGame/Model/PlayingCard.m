//
//  PlayingCard.m
//  CardGame
//
//  Created by Shachar Langbeheim on 07/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
      _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}


- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

- (int)matchSingleCard:(PlayingCard *)otherCard
{
    int score = 0;
    
    if(otherCard.rank == self.rank)
    {
        score = 4;
    }
    else if (otherCard.suit == self.suit)
    {
        score = 1;
    }
    
    return score;
}

- (int)matchCards:(NSArray *)cards
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

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4", @"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [[self rankStrings] count]-1; }

@synthesize suit = _suit;

@end