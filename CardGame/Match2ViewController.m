//
//  ViewController.m
//  CardGame
//
//  Created by Shachar Langbeheim on 07/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "Match2ViewController.h"
#import "PlayingCardDeck.h"

@interface Match2ViewController ()
@end

@implementation Match2ViewController

- (NSAttributedString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.attributedContents : [[NSAttributedString alloc] initWithString:@"" ];
}

- (UIImage *)backgroudImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"card-front" : @"card-back"];
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
