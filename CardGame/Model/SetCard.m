//
//  SetCard.m
//  CardGame
//
//  Created by Shachar Langbeheim on 09/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()
@property (nonatomic, strong, readwrite) NSNumber *fillLevel;
@property (nonatomic, strong, readwrite) UIColor *color;
@property (nonatomic, strong, readwrite) NSString *shape;
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

-(void)setCard:(int)numOfChars color:(UIColor *)color fillLevel:(NSNumber *)fillLevel shape:(NSString *)shape{
    self.color = color;
    self.fillLevel = fillLevel;
    self.shape = shape;
    self.number = numOfChars;
    
    NSString *str = [[NSString alloc] init];
    for(int i = 0; i < numOfChars; i++){
        str = [str stringByAppendingString:shape];
    }
    
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName: [color colorWithAlphaComponent:[fillLevel floatValue]],
                                 NSStrokeWidthAttributeName: @-3,
                                 NSStrokeColorAttributeName: color,
                                 };
    
    //self.attributedContents = [[NSMutableAttributedString alloc] initWithString:str attributes:attributes];
}

+ (NSArray *)shapes
{
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)colors
{
    return @[[UIColor blackColor], [UIColor redColor], [UIColor blueColor]];
}

+ (NSArray *)fillLevels
{
    return @[[NSNumber numberWithFloat: 0], [NSNumber numberWithFloat: 0.1], [NSNumber numberWithFloat: 1]];
}

//@synthesize attributedContents = _attributedContents;

@end
