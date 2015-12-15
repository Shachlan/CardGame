//
//  CardView.h
//  CardGame
//
//  Created by Shachar Langbeheim on 10/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "CardView.h"

#import <UIKit/UIKit.h>

#import "PlayingCardFaceView.h"
#import "PlayingCardBackView.h"

@interface PlayingCardView : UIView <CardView>
@property (nonatomic, strong) PlayingCardFaceView *faceView;
@property (nonatomic, strong) PlayingCardBackView *backView;
- (void)setup;
@end
