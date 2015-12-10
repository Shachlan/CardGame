//
//  CardView.m
//  CardGame
//
//  Created by Shachar Langbeheim on 10/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation PlayingCardView

const float kCornerHeight = 180.0;
const float kCornerRadius = 18.0;
const float kCornerOffsetFactor = 3.0;
const float kDefaultFaceCardScaleFactor = 0.9;

- (CGFloat) cornerScaleFactor {return self.bounds.size.height / kCornerHeight;}
- (CGFloat) cornerRadius {return kCornerRadius * [self cornerScaleFactor]; }
- (CGFloat) cornerOffset {return [self cornerRadius] / kCornerOffsetFactor; }

- (void)drawRect:(CGRect)rect{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.cornerRadius];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", self.rank, self.suit]];
    if(faceImage){
        CGRect imageRect = CGRectInset(self.bounds,
                                       self.bounds.size.width * (1.0-self.faceCardScaleFactor),
                                       self.bounds.size.height * (1.0-self.faceCardScaleFactor));
        [self draw]
    }
    else {
        [self drawPipedCard];
    }
}

- (void) setup{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void) awakeFromNib{
    [self setup];
}

- (void) drawPipedCard
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", self.suit, self.rank] attributes:@{NSFontAttributeName : cornerFont,
                                                                                  NSParagraphStyleAttributeName: paragraphStyle}];
    
    
    
    CGRect textBounds;
    textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    textBounds.size = [cornerText size];
    [cornerText drawInRect:textBounds];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    [cornerText drawInRect:textBounds];
}

- (void) setSuit:(NSString *)suit{
    _suit = suit;
    [self setNeedsDisplay];
}

- (void) setRank:(NSString *)rank{
    _rank = rank;
    [self setNeedsDisplay];
}

- (void) setFaceUp:(BOOL)faceUp{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

- (CGFloat) faceCardScaleFactor{
    if(!_faceCardScaleFactor) _faceCardScaleFactor = kDefaultFaceCardScaleFactor;
    return _faceCardScaleFactor;
}

- (void) setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor {
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

@end
