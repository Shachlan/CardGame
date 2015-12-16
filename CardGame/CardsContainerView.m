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
@property (strong, nonatomic) NSMutableArray *emptyFrames;
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
  [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
  [self setView];
}

- (void)setView {
  [self setupGrid:self.parameters.initialNumberOfCards];
  
  for(int i = 0; i < self.parameters.initialNumberOfCards; i++) {
    [self addCard];
  }
  
  [self updateUI];
}

- (void)setupGrid:(int)numberOfCards {
  _emptyFrames = nil;
  self.nextEmptyColumn = 0;
  self.nextEmptyRow = 0;
  _grid = nil;
  [self.grid setSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height)];
  self.grid.minimumNumberOfCells = numberOfCards;
  self.grid.cellAspectRatio = 9.0 / 16.0;
}

#pragma mark - card handling

- (void)dealMoreCards {
  if(self.emptyFrames.count) {
    NSMutableArray *filledSpaces = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.parameters.numberOfCardsToAdd; i++) {
      NSValue *rect = self.emptyFrames[i];
      [filledSpaces addObject:rect];
      [self addCardWithFrame:[rect CGRectValue]];
    }
    
    for(NSValue *rectValue in filledSpaces)
    {
      [self.emptyFrames removeObject:rectValue];
    }
    return;
  }
  
  [self setupGrid: (int)self.grid.minimumNumberOfCells + self.parameters.numberOfCardsToAdd];
  
  [self respreadCards];
  
  for(int i = 0; i < self.parameters.numberOfCardsToAdd; i++) {
    [self addCard];
  }
  
  [self updateUI];
}

- (void)respreadCards {
  for(UIView *subview in self.subviews) {
    if(!subview.hidden) {
      CGRect frame = [self nextFreeSlot];
      [subview setFrame:frame];
      [self advanceRowAndColumnCounters];
    }
  }
}

- (void)addCard {
  CGRect frame = [self nextFreeSlot];
  if([self addCardWithFrame:frame])
  {
    [self advanceRowAndColumnCounters];
  }
}

- (id<CardView>)addCardWithFrame:(CGRect)frame {
  
  Card *cardModel = [self.game drawCard];
  if(!cardModel) {
    return nil;
  }
  
  id<CardView> cardView = [self.cardFactory
                           makeCardViewWithAttributes:cardModel.attributes
                           andFrame: CGRectMake(0,0,frame.size.width,frame.size.height)];
  UIView *cardAsView = (UIView *)cardView;
  [self addSubview:cardAsView];
  [UIView animateWithDuration:0.5 animations:^{ cardAsView.center = CGPointMake(frame.origin.x + (frame.size.width / 2), frame.origin.y + (frame.size.height / 2)); }];
  [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                  initWithTarget:self
                                  action:@selector(cardClicked:)]];
  return cardView;
}

- (void)advanceRowAndColumnCounters {
  self.nextEmptyRow++;
  if(self.nextEmptyRow == self.grid.rowCount) {
    self.nextEmptyRow = 0;
    self.nextEmptyColumn++;
  }
}

- (void)updateUI {
  NSMutableArray *removedViewsIndices = [[NSMutableArray alloc] init];
  for(UIView *view in self.subviews) {
    if(view.hidden) {
      continue;
    }
    
    id<CardView> card = (id<CardView>)view;
    NSUInteger cardIndex = [self.subviews indexOfObject:view];
    Card *cardModel = [self.game cardAtIndex:cardIndex];
    [card chooseCard:cardModel.chosen];
    if(cardModel.matched) {
      if(self.removeCardsWhenMatched) {
        [self.emptyFrames addObject:[NSValue valueWithCGRect:view.frame]];
        [removedViewsIndices addObject:[NSNumber numberWithLong:cardIndex]];
      }
      [card matchCard];
    }
  }
  
  for(NSNumber *index in [removedViewsIndices reverseObjectEnumerator]) {
    [self.game removeCardFromIndex:[index longValue]];
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

- (NSMutableArray *)emptyFrames {
  if(!_emptyFrames) {
    _emptyFrames = [[NSMutableArray alloc] init];
  }
  return _emptyFrames;
}

@end

NS_ASSUME_NONNULL_END
