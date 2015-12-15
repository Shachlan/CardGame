//
//  SetViewController.m
//  CardGame
//
//  Created by Shachar Langbeheim on 08/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "SetGameView.h"

#import "SetCardDeck.h"
#import "SetParameters.h"
#import "SetCardViewFactory.h"
#import "CardMatchingGame.h"

@interface CardsContainerView()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong,nonatomic) id<GameParameters> parameters;
@property (strong,nonatomic) id<CardViewFactory> cardFactory;
@end

@implementation SetGameView

- (Deck *)createDeck {
  return [[SetCardDeck alloc] init];
}

@synthesize parameters = _parameters;
- (id<GameParameters>)parameters {
  if(!_parameters) {
    _parameters = [[SetParameters alloc] init];
  }
  return _parameters;
}

@synthesize cardFactory = _cardFactory;
- (id<CardViewFactory>)cardFactory {
  if(!_cardFactory) {
    _cardFactory = [[SetCardViewFactory alloc] init];
  }
  return _cardFactory;
}

@end
