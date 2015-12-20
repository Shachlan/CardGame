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
@property (nonatomic) BOOL wasSetup;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *dragAttachment;
@property (nonatomic) CGPoint previousDragPoint;
@property (nonatomic) BOOL needLayout;
@end

@implementation CardsContainerView

#pragma mark - gesture recognition

- (IBAction)cardClicked:(UITapGestureRecognizer *)sender {
  if([self.animator behaviors].count)
  {
    [self.animator removeAllBehaviors];
    [self respreadCards];
  }
  else {
    UIView * card = sender.view;
    [self.game chooseCardAtIndex:[self.subviews indexOfObject:card]];
  }
  [self updateUI];
}

- (IBAction)pinched:(UIPinchGestureRecognizer *)sender {
  if(sender.state == UIGestureRecognizerStateChanged){
    for(UIView *view in self.subviews) {
      NSUInteger index = [self.subviews indexOfObject:view];
      CGPoint origin = [self.grid frameOfCellAtIndex:index].origin;
      CGPoint difference = CGPointMake(self.center.x - origin.x, self.center.y - origin.y);
      float inverseScale = 1 - sender.scale;
      CGPoint scaledDifference = CGPointMake(difference.x * inverseScale,
                                             difference.y * inverseScale);
      
      view.frame = CGRectMake(origin.x + scaledDifference.x,
                              origin.y + scaledDifference.y,
                              view.frame.size.width,
                              view.frame.size.height);
    }
  }
  else if(sender.state == UIGestureRecognizerStateEnded) {
    if(sender.scale > 0.1){
      [self respreadCards];
    }
    else {
      for(UIView *view in self.subviews) {
        NSUInteger index = [self.subviews indexOfObject:view];
        if(index) {
          UIView *previousView = [self.subviews objectAtIndex:index -1];
          UIAttachmentBehavior *attach =
            [UIAttachmentBehavior limitAttachmentWithItem:previousView
                                       offsetFromCenter:UIOffsetZero
                                         attachedToItem:view
                                       offsetFromCenter:UIOffsetZero];
          [self.animator addBehavior:attach];
        }
      }
    }
  }
}

- (IBAction)panned:(UIPanGestureRecognizer *)sender {
  if([self.animator behaviors].count)
  {
    CGPoint touchPoint = [sender locationInView:self];
    UIView* draggedView = sender.view;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
      self.previousDragPoint = touchPoint;
      self.dragAttachment = [[UIAttachmentBehavior alloc] initWithItem:draggedView attachedToAnchor:touchPoint];
      [self.animator addBehavior:self.dragAttachment];
      
    } else if (sender.state == UIGestureRecognizerStateChanged) {
      [self.dragAttachment setAnchorPoint:touchPoint];
      
    } else if (sender.state == UIGestureRecognizerStateEnded) {
      [self.animator removeBehavior:self.dragAttachment];
    }
  }
}

#pragma mark - initializers and event handlers

- (void)reset {
  if(!self.wasSetup)
  {
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    [self addGestureRecognizer:[[UIPinchGestureRecognizer alloc]
                                initWithTarget:self
                                action:@selector(pinched:)]];
    self.wasSetup = YES;
  }
  
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
  _grid = nil;
  [self.grid setSize:CGSizeMake(self.bounds.size.width, self.bounds.size.height)];
  self.grid.minimumNumberOfCells = numberOfCards;
  self.grid.cellAspectRatio = 9.0 / 16.0;
  self.needLayout = YES;
}

- (void)layoutIfNeeded {
  [super layoutIfNeeded];
  if(self.needLayout) {
    self.grid.size = self.bounds.size;
    [self respreadCards];
    self.needLayout = NO;
  }
}

#pragma mark - card handling

- (void)dealMoreCards {
  if(!self.game.cardsLeft) {
    return;
  }
  
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
  [self.emptyFrames removeAllObjects];
  self.nextEmptyColumn = 0;
  self.nextEmptyRow = 0;
  for(UIView *subview in self.subviews) {
    if(!subview.hidden) {
      CGRect frame = [self nextFreeSlot];
      [self animateCard:subview toFrame:frame];
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
  [self animateCard:cardAsView toFrame:frame];
  [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                  initWithTarget:self
                                  action:@selector(cardClicked:)]];
  
  [cardView addGestureRecognizer:[[UIPanGestureRecognizer alloc]
                                  initWithTarget:self
                                  action:@selector(panned:)]];
  return cardView;
}

- (void)animateCard:(UIView *)card toFrame:(CGRect)frame {
  [UIView animateWithDuration:0.5 animations:^{ card.frame = frame; }];
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
