//
//  GameViewController.m
//  CardGame
//
//  Created by Shachar Langbeheim on 09/12/2015.
//  Copyright © 2015 Shachar Langbeheim. All rights reserved.
//

#import "GameViewController.h"


#import "CardsContainerView.h"

@interface GameViewController()
@property (weak, nonatomic) IBOutlet CardsContainerView *cardContainmentView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation GameViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.cardContainmentView.scoreUpdater = self;
  [self.cardContainmentView reset];
}

- (IBAction)resetGame:(UIButton *)sender {
  [self.cardContainmentView reset];
}

- (void)updateScore:(int)score {
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", score];
}

@end
