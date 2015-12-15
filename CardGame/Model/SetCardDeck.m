//
//  SetCardDeck.m
//  CardGame
//
//  Created by Shachar Langbeheim on 09/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "SetCardDeck.h"

#import "SetCard.h"

#import <UIKit/UIKit.h>

@implementation SetCardDeck

- (instancetype)init {
  self = [super init];
  if (self) {
    NSArray *colors = [SetCard colors];
    NSArray *shapes = [SetCard shapes];
    NSArray *fillLevels = [SetCard fillLevels];
    
    for(int numOfChars = 1 ; numOfChars <= 3; numOfChars++) {
      for (UIColor *color in colors) {
        for (NSNumber *fillLevel in fillLevels) {
          for(NSString *shape in shapes) {
            [self addCard:[self createCard:numOfChars color:color fillLevel:fillLevel shape:shape]];
          }
        }
      }
    }
  }
  
  return self;
}

- (SetCard *)createCard:(int)numOfChars
                  color:(UIColor *)color
              fillLevel:(NSNumber *)fillLevel
                  shape:(NSString *)shape {
  SetCard *card = [[SetCard alloc] init];
  [card setCard:numOfChars color:color fillLevel:fillLevel shape:shape];
  
  return card;
}


@end
