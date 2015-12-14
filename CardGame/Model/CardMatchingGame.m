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
@property (nonatomic) int numberOfCardsToChoose;
@property (nonatomic) int matchBonus;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH2_BONUS = 4;
static const int MATCH3_BONUS = 2;
static const int COST_TO_CHOOSE = 1;

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    [self setMatchMode:NO];
    if (self){
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (instancetype) init
{
    return nil;
}

- (void)setMatchMode:(BOOL)match3
{
    self.numberOfCardsToChoose = match3 ? 3 : 2;
    self.matchBonus = match3 ? MATCH3_BONUS : MATCH2_BONUS;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *chosenCard = [self cardAtIndex:index];
    
    if(chosenCard.isChosen){
        chosenCard.chosen = NO;
    }
    else {
        chosenCard.chosen = YES;
        NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
        
        for (Card *card in self.cards){
            if(card.isChosen && !card.isMatched){
                [chosenCards addObject:card];
            }
        }
        
        if([chosenCards count] == self.numberOfCardsToChoose){
            int matchScore = [chosenCard matchCards:chosenCards];
            
            if(matchScore){
                for(Card *card in chosenCards){
                    card.matched = YES;
                }
                
                self.score += matchScore * self.matchBonus;
            }
            else {
                for(Card *card in chosenCards){
                    card.chosen = NO;
                }
                
                chosenCard.chosen = YES;
                self.score -= MISMATCH_PENALTY;
            }
        }
        
        self.score -= COST_TO_CHOOSE;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)removeCardFromIndex:(int)index{
  [self.cards removeObjectAtIndex:index];
}


- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

@end
