//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Shachar Langbeheim on 07/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic,readwrite) int score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, weak) id<GameParameters> parameters;
@property (nonatomic, strong) Deck *deck;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

- (instancetype)initWithDeck:(Deck *)deck andParameters:(id<GameParameters>)parameters {
  self = [super init];
  if (self) {
    _deck = deck;
    self.parameters = parameters;
  }
  
  return self;
}

- (instancetype) init {
  return nil;
}

- (Card *)drawCard {
  Card *card = [self.deck drawRandomCard];
  [self.cards addObject:card];
  return card;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
  Card *chosenCard = [self cardAtIndex:index];
  
  if(chosenCard.isChosen) {
    chosenCard.chosen = NO;
  }
  else {
    chosenCard.chosen = YES;
    NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
    
    for (Card *card in self.cards) {
      if(card.isChosen && !card.isMatched) {
        [chosenCards addObject:card];
      }
    }
    
    if([chosenCards count] == self.parameters.numberOfCardsToMatch) {
      int matchScore = [chosenCard matchCards:chosenCards];
      
      if(matchScore) {
        for(Card *card in chosenCards) {
          card.matched = YES;
        }
        
        self.score += matchScore * self.parameters.matchMultiplier;
      }
      else {
        for(Card *card in chosenCards) {
          card.chosen = NO;
        }
        
        chosenCard.chosen = YES;
        self.score -= MISMATCH_PENALTY;
      }
    }
    
    self.score -= COST_TO_CHOOSE;
  }
}

- (Card *)cardAtIndex:(NSUInteger)index {
  return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)removeCardFromIndex:(int)index {
  [self.cards removeObjectAtIndex:index];
}


- (NSMutableArray *)cards {
  if(!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

@synthesize deck = _deck;

@end
