//
//  Deck.m
//  CardGame
//
//  Created by Shachar Langbeheim on 07/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

- (NSMutableArray *)cards {
    if(!_cards) _cards = [ [NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    }
    else {
        [self.cards addObject:card];
    }
}

- (void) addCard:(Card *)card {
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard {
    Card *randomCard = nil;
    
    if([self.cards count]) {
      unsigned index = arc4random() % [self.cards count];
      randomCard = self.cards[index];
      [self.cards removeObjectAtIndex: index];
    }
        
    return randomCard;
}

- (BOOL)cardsLeft {
  return self.cards.count != 0;
}

@end
