//
//  SetViewController.m
//  CardGame
//
//  Created by Shachar Langbeheim on 08/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "SetViewController.h"

#import "SetCardDeck.h"

@implementation SetViewController

- (UIImage *)backgroudImageForCard:(Card *)card
{
    return card.isChosen ?[UIImage imageNamed:@"card-chosen"] : [UIImage imageNamed:@"card-front"];
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (CardMatchingGame *)game
{
    CardMatchingGame *game = super.game;
    [game setMatchMode:YES];
    return game;
}

@end
