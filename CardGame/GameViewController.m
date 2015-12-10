//
//  GameViewController.m
//  CardGame
//
//  Created by Shachar Langbeheim on 09/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "GameViewController.h"
#import "CardMatchingGame.h"

@interface GameViewController()
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cards;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation GameViewController

- (IBAction)resetGame:(UIButton *)sender
{
    _game = nil;
    [self updateUI];
}

- (IBAction)touchCardButton:(UIVI *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void) updateUI
{
    for(UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroudImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void)viewWillAppear:(BOOL)animated{
    [self updateUI];
}

- (UIImage *)backgroudImageForCard:(Card *)card
{
    return nil;
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    return card.attributedContents;
}

- (Deck *)createDeck
{
    return nil;
}

- (CardMatchingGame *)game
{
    if(!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}

@end
