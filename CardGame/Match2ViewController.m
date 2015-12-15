//
//  ViewController.m
//  CardGame
//
//  Created by Shachar Langbeheim on 07/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "Match2ViewController.h"
#import "PlayingCardDeck.h"

@implementation Match2ViewController

- (Deck *)createDeck {
  return [[PlayingCardDeck alloc] init];
}

@end
