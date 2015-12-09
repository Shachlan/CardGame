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
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveDescription;
@property (nonatomic, readonly) int maxMessagesInHistory;
@property (nonatomic,strong) NSMutableArray *historyMessages;
@end

@implementation GameViewController

static const int MAX_MESSAGES_IN_HISTORY = 10;

- (IBAction)resetGame:(UIButton *)sender
{
    _game = nil;
    [self clearHistory];
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender
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
    
    self.lastMoveDescription.attributedText = self.game.lastMove;
    [self pushMessageToHistory:self.game.lastMove];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void)viewWillAppear:(BOOL)animated{
    [self updateUI];
}

- (void)clearHistory
{
    [self.historyMessages removeAllObjects];
}

- (void)pushMessageToHistory:(NSAttributedString *)message
{
    if([self.historyMessages count] == self.maxMessagesInHistory) {
        [self.historyMessages removeObjectAtIndex:0];
    }
    if(message){
        [self.historyMessages addObject:message];
    }
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

- (NSMutableArray *)historyMessages
{
    if(!_historyMessages) _historyMessages = [[NSMutableArray alloc] init];
    return _historyMessages;
}

- (CardMatchingGame *)game
{
    if(!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}

- (NSAttributedString *)history
{
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    // Put this delimiter between each string - change as desired
    NSAttributedString *delimiter = [[NSAttributedString alloc] initWithString:@"\r"];
    for (NSAttributedString *str in self.historyMessages) {
        if (result.length) {
            [result appendAttributedString:delimiter];
        }
        [result appendAttributedString:str];
    }
    
    return result;
}

- (int) maxMessagesInHistory
{
    return MAX_MESSAGES_IN_HISTORY;
}

@end
