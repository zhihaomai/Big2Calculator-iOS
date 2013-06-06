//
//  settingViewController.m
//  CardCalc
//
//  Created by Zee on 2013-02-01.
//  Copyright (c) 2013 Zee. All rights reserved.
//

#import "settingViewController.h"
#import "cardObject.h"

@interface settingViewController ()

@end

@implementation settingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self resetButton] addTarget:self action:@selector(resetButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [[self numOfPlayerControl] addTarget:self action:@selector(changeNumberOfPlayers) forControlEvents:UIControlEventValueChanged];
    
    [[self amountBet] addTarget:self action:@selector(changeMonetaryValue) forControlEvents:UIControlEventValueChanged];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 234.0, 200.0)];
    [infoLabel setNumberOfLines:0];
    [infoLabel setBackgroundColor:[UIColor clearColor]];
    [infoLabel setText:@"Lorem boofron dolor sit amet, shut the shizzle up adipiscing boom shackalack. Nullizzle sapizzle velizzle, aliquet volutpizzle, suscipit quizzle, gravida vel, arcu. Pellentesque doggy black. Sed erizzle. Da bomb izzle dolor dapibizzle shizzlin dizzle tempizzle sure. For sure pellentesque nibh shizznit turpizzle. Check out this in tortizzle. Pellentesque dizzle rhoncizzle crazy. Hizzle yo mamma mah nizzle fo shizzle mah nizzle fo rizzle, mah home g-dizzle dictumst. Mammasay mammasa mamma oo sa dapibizzle. Curabitur tellus , shit phat, mattis sure, eleifend vitae, nunc. Things suscipizzle. Integer semper velit we gonna chung purus."];
    [infoLabel sizeToFit];
    [[self aboutView] addSubview:infoLabel];
    
    [[self aboutView] setContentSize:CGSizeMake(234.0, infoLabel.frame.size.height + 10)];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[self numOfPlayerControl] setSelectedSegmentIndex:[cardObject instance].numOfPlayers-3];
    [[self amountBet] setSelectedSegmentIndex:[self segmentIndexFromBetAmount:[cardObject instance].betAmount]];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) resetButtonPressed{
    [[cardObject instance] setBetAmount:1];
    [[cardObject instance] setNumOfPlayers:4];
    [[self numOfPlayerControl] setSelectedSegmentIndex:1];
    [[self amountBet] setSelectedSegmentIndex:0];
}

- (void) changeNumberOfPlayers{
    NSLog (@"Number of Players changed");
    [[cardObject instance] setNumOfPlayers:[self numOfPlayerControl].selectedSegmentIndex+3];
}

- (void) changeMonetaryValue{
    NSLog (@"Bet amount changed");
    [[cardObject instance] setBetAmount:[self betAmountFromSegmentIndex:[self amountBet].selectedSegmentIndex]];
}

- (NSInteger) betAmountFromSegmentIndex: (NSInteger) index{
    switch (index) {
        case 0:
            return 1;
            break;
        case 1:
            return 5;
            break;
        case 2:
            return 10;
            break;
        case 3:
            return 25;
            break;
        case 4:
            return 100;
            break;
        default:
            return -1;
            break;
    }
}

- (NSInteger) segmentIndexFromBetAmount: (NSInteger) bet{
    switch (bet) {
        case 1:
            return 0;
            break;
        case 5:
            return 1;
            break;
        case 10:
            return 2;
            break;
        case 25:
            return 3;
            break;
        case 100:
            return 4;
            break;
        default:
            return -1;
            break;
    }
}

@end
