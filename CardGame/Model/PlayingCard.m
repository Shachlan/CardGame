//
//  PlayingCard.m
//  CardGame
//
//  Created by Shachar Langbeheim on 07/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)matchSingleCard:(PlayingCard *)otherCard
{
  int score = 0;
  
  if(otherCard.rank == self.rank) {
    score = 4;
  }
  else if (otherCard.suit == self.suit) {
    score = 1;
  }
  
  return score;
}

- (int)matchCards:(NSArray *)cards {
  int score = 0;
  
  for(int i = 0; i < [cards count] -1;i++) {
    for(int j = i+1; j < [cards count]; j++) {
      score += [[cards objectAtIndex:i] matchSingleCard:[cards objectAtIndex:j]];
    }
  }
  
  return score;
}

+ (NSArray *)validSuits {
  return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *)rankStrings {
  return @[@"?",@"A",@"2",@"3",@"4", @"5",@"6",@"7",@"8",@"9",@"10",@"j",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [[self rankStrings] count]-1; }

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit {
  if ([[PlayingCard validSuits] containsObject:suit]) {
    _suit = suit;
  }
}

- (NSString *)suit {
  return _suit ? _suit : @"?";
}

@synthesize rank = _rank;
@synthesize attributes = _attributes;

- (NSArray *) attributes {
  if(!_attributes) {
    NSMutableArray *mutableAttributes = [[NSMutableArray alloc] init];
    [mutableAttributes addObject:[NSNumber numberWithLong: self.rank]];
    [mutableAttributes addObject:self.suit];
    _attributes = mutableAttributes;
  }
  
  return _attributes;
}

@end
