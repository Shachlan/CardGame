//
//  SetCard.m
//  CardGame
//
//  Created by Shachar Langbeheim on 09/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "SetCard.h"

#import "../SetEnums.h"

@interface SetCard()
@property (nonatomic, strong, readwrite) NSNumber *fillLevel;
@property (nonatomic, strong, readwrite) UIColor *color;
@property (nonatomic, strong, readwrite) NSNumber *shape;
@property (nonatomic, readwrite) int number;
@end

@implementation SetCard

- (int)matchCards:(NSArray *)cards {
    
    NSMutableArray *numbers = [[NSMutableArray alloc] init];
    NSMutableArray *shapes = [[NSMutableArray alloc] init];
    NSMutableArray *fillLevels = [[NSMutableArray alloc] init];
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    for(SetCard *card in cards)
    {
        [numbers addObject: [[NSNumber alloc] initWithInt:card.number]];
        [colors addObject: card.color];
        [fillLevels addObject: card.fillLevel];
        [shapes addObject: card.shape];
    }
    
    BOOL matchNumbers = [SetCard matchingSet:numbers];
    BOOL matchShapes = [SetCard matchingSet:shapes];
    BOOL matchFill = [SetCard matchingSet:fillLevels];
    BOOL matchColors = [SetCard matchingSet:colors];
    
    return (matchNumbers &&
            matchShapes &&
            matchFill &&
            matchColors) ? 4 : 0;
}

+ (BOOL)matchingSet:(NSArray *)attributes {
    NSAssert([attributes count]  == 3, @"only sets of 3 are allowed");
    return ([[attributes objectAtIndex:0] isEqual:[attributes objectAtIndex:1]] &&
            [[attributes objectAtIndex:0] isEqual:[attributes objectAtIndex:2]]) ||
            (![[attributes objectAtIndex:0] isEqual:[attributes objectAtIndex:1]] &&
             ![[attributes objectAtIndex:1] isEqual:[attributes objectAtIndex:2]] &&
             ![[attributes objectAtIndex:0] isEqual:[attributes objectAtIndex:2]]);
}

-(void)setCard:(int)numOfChars color:(UIColor *)color fillLevel:(NSNumber *)fillLevel shape:(NSNumber *)shape{
    self.color = color;
    self.fillLevel = fillLevel;
    self.shape = shape;
    self.number = numOfChars;
}

@synthesize attributes = _attributes;

- (NSArray *) attributes
{
  if(!_attributes)
  {
    NSMutableArray *mutableAttributes = [[NSMutableArray alloc] init];
    [mutableAttributes addObject:[NSNumber numberWithInt: self.number]];
    [mutableAttributes addObject:self.color];
    [mutableAttributes addObject:self.shape];
    [mutableAttributes addObject:self.fillLevel];
    _attributes = mutableAttributes;
  }
  
  return _attributes;
}

+ (NSArray *)shapes
{
  return @[[NSNumber numberWithInt: SQUIGGLE],
           [NSNumber numberWithInt: DIAMOND],
           [NSNumber numberWithInt: OVAL]];
}

+ (NSArray *)colors
{
    return @[[UIColor greenColor], [UIColor redColor], [UIColor purpleColor]];
}

+ (NSArray *)fillLevels
{
  return @[[NSNumber numberWithInt: NO_FILL],
           [NSNumber numberWithInt: PARTIAL],
           [NSNumber numberWithInt: FULL]];
}

//@synthesize attributedContents = _attributedContents;

@end
