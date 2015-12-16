//
//  ViewController.m
//  CardGame
//
//  Created by Shachar Langbeheim on 07/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "Match2GameView.h"

#import "PlayingCardDeck.h"
#import "Match2Parameters.h"
#import "PlayingCardViewFactory.h"

@interface CardsContainerView()
@property (strong,nonatomic) id<GameParameters> parameters;
@property (strong,nonatomic) id<CardViewFactory> cardFactory;
@end

@implementation Match2GameView

- (Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

@synthesize parameters = _parameters;
- (id<GameParameters>)parameters {
  if(!_parameters) {
    _parameters = [[Match2Parameters alloc] init];
  }
  return _parameters;
}

@synthesize cardFactory = _cardFactory;
- (id<CardViewFactory>)cardFactory {
  if(!_cardFactory) {
    _cardFactory = [[PlayingCardViewFactory alloc] init];
  }
  return _cardFactory;
}

- (BOOL)removeCardsWhenMatched {
  return NO;
}
@end
