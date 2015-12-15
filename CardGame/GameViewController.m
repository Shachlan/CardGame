//
//  GameViewController.m
//  CardGame
//
//  Created by Shachar Langbeheim on 09/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "GameViewController.h"

#import "CardMatchingGame.h"
#import "CardView.h"
#import "Grid.h"

@interface GameViewController()
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cards;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong,nonatomic) Grid *grid;
@end

@implementation GameViewController

- (void)viewWillAppear:(BOOL)animated {
  [self setViews];
}

- (IBAction)cardClicked:(UITapGestureRecognizer *)sender {
  id<CardView> card = (id<CardView>)sender.view;
  [self.game chooseCardAtIndex:[self.cards indexOfObject:card]];
  [self updateUI];
}

- (IBAction)resetGame:(UIButton *)sender {
  _game = nil;
  [self setViews];
}

- (void)setViews {
  float gridWidth = self.view.bounds.size.width * 0.9;
  float gridHeight = (self.view.bounds.size.height - self.scoreLabel.bounds.origin.y) * 0.9;
  [self.grid setSize:CGSizeMake(gridWidth, gridHeight)];
  
  for(id<CardView>  card in self.cards) {
    NSUInteger cardButtonIndex = [self.cards indexOfObject:card];
    Card *cardModel = [self.game cardAtIndex:cardButtonIndex];
    [card setCard:cardModel.attributes];
    [card addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                initWithTarget:self
                                action:@selector(cardClicked:)]];
  }
  [self updateUI];
}

- (void)updateUI {
  for(id<CardView> card in self.cards) {
    NSUInteger cardButtonIndex = [self.cards indexOfObject:card];
    Card *cardModel = [self.game cardAtIndex:cardButtonIndex];
    [card chooseCard:cardModel.chosen];
    if(cardModel.matched){
      [card matchCard];
    }
  }
  
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (Deck *)createDeck {
  return nil;
}

- (CardMatchingGame *)game {
  if(!_game){
    _game = [[CardMatchingGame alloc]
             initWithCardCount:[self.cards count]
             usingDeck:[self createDeck]];
  }
  return _game;
}

- (Grid *)grid {
  if(!_grid){
    _grid = [[Grid alloc] init];
  }
  return _grid;
}

@end
