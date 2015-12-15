// Copyright (c) 2015 Lightricks. All rights reserved.
// Created by Shachar Langbeheim.

#import "CardsContainerView.h"

#import "Grid.h"
#import "CardMatchingGame.h"
#import "CardView.h"
#import "CardViewFactory.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardsContainerView()
@property (strong,nonatomic) Grid *grid;
@property (nonatomic) int nextEmptyRow;
@property (nonatomic) int nextEmptyColumn;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong,nonatomic) id<GameParameters> parameters;
@property (strong,nonatomic) id<CardViewFactory> cardFactory;
@end

@implementation CardsContainerView

- (IBAction)cardClicked:(UITapGestureRecognizer *)sender {
  UIView * card = sender.view;
  [self.game chooseCardAtIndex:[self.subviews indexOfObject:card]];
  [self updateUI];
}

#pragma mark - initializers

- (void)reset {
  _game = nil;
  self.nextEmptyColumn = 0;
  self.nextEmptyRow = 0;
  [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
  [self setView];
}

- (void)setup {
  [self.grid setSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height)];
  self.grid.minimumNumberOfCells = self.parameters.initialNumberOfCards;
  self.grid.cellAspectRatio = 9.0 / 16.0;
}

- (void)setView {
  [self setup];
  
  for(int i = 0; i < self.parameters.initialNumberOfCards; i++) {
    [self addCard];
  }
  
  [self updateUI];
}

#pragma mark - card handling

- (void)addCard {
  CGRect frame = [self nextFreeSlot];
  Card *cardModel = [self.game drawCard];
  id<CardView> cardView = [self.cardFactory
                           makeCardViewWithAttributes:cardModel.attributes
                           andFrame: frame];
  [self addSubview:(UIView *)cardView];
  [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                  initWithTarget:self
                                  action:@selector(cardClicked:)]];
  self.nextEmptyRow++;
  if(self.nextEmptyRow == self.grid.rowCount) {
    self.nextEmptyRow = 0;
    self.nextEmptyColumn++;
  }
}

- (void)updateUI {
  for(UIView *view in self.subviews) {
    id<CardView> card = (id<CardView>)view;
    NSUInteger cardButtonIndex = [self.subviews indexOfObject:view];
    Card *cardModel = [self.game cardAtIndex:cardButtonIndex];
    [card chooseCard:cardModel.chosen];
    if(cardModel.matched) {
      [card matchCard];
    }
  }
  
  [self.scoreUpdater updateScore:self.game.score];
}

- (CGRect)nextFreeSlot {
  return [self.grid frameOfCellAtRow:self.nextEmptyRow inColumn:self.nextEmptyColumn];
}

- (Deck *)createDeck {
  return nil;
}

#pragma mark - properties

- (Grid *)grid {
  if(!_grid) {
    _grid = [[Grid alloc] init];
  }
  return _grid;
}

- (CardMatchingGame *)game {
  if(!_game) {
    _game = [[CardMatchingGame alloc]
             initWithDeck:[self createDeck]
             andParameters:self.parameters];
  }
  return _game;
}

@end

NS_ASSUME_NONNULL_END
