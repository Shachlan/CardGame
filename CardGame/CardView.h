//
//  CardView.h
//  CardGame
//
//  Created by Shachar Langbeheim on 13/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView
- (void)matchCard;
- (void)chooseCard:(BOOL)choice;
- (void)setCard:(NSArray *)attributes;
@end