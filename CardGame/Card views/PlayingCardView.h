//
//  CardView.h
//  CardGame
//
//  Created by Shachar Langbeheim on 10/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView
@property (nonatomic) BOOL faceUp;
@property (nonatomic, strong) NSString *suit;
@property (nonatomic, strong) NSString *rank;
@end
