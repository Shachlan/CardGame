//
//  CardMatchingGame.h
//  CardGame
//
//  Created by Shachar Langbeheim on 07/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Deck.h"
#import "GameParameters.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithDeck:(Deck *)deck andParameters:(id<GameParameters>)params;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)removeCardFromIndex:(NSUInteger)index;
- (Card *)drawCard;
- (BOOL)cardsLeft;

@property (nonatomic, readonly) int score;

@end
