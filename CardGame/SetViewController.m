//
//  SetViewController.m
//  CardGame
//
//  Created by Shachar Langbeheim on 08/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "SetViewController.h"

#import "SetCardDeck.h"

@interface GameViewController()
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation SetViewController

- (Deck *)createDeck {
  return [[SetCardDeck alloc] init];
}

- (CardMatchingGame *)game {
  CardMatchingGame *game = super.game;
  [game setMatchMode:YES];
  return game;
}

@end
