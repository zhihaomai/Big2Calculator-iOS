//
//  winningsViewController.m
//  CardCalc
//
//  Created by Zee on 2013-02-01.
//  Copyright (c) 2013 Zee. All rights reserved.
//

#import "winningsViewController.h"
#import "cardObject.h"
#import "cardCalcCell.h"

@interface winningsViewController ()

@end

@implementation winningsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Winnings"];
    
    [[cardObject instance] calculatePayout];
    
    [resultsTable setDelegate:self];
    [resultsTable setDataSource:self];
    resultsTable.contentInset=UIEdgeInsetsMake(0,0,274,0);

    [doneButton addTarget:self action:@selector(doneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) doneButtonPressed{
    NSLog(@"Done button pressed.");
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

#pragma mark - Tableview data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cardObject instance].numOfPlayers;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.row];
    cardCalcCell *cell = (cardCalcCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell){
        cell = [[cardCalcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [cell setPlayerNumber:indexPath.row];
        
        UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(75, 20, 100, 40)];
        [temp setText:[NSString stringWithFormat:@"Player %d's", indexPath.row+1]];
        [temp sizeToFit];
        [cell setPlayerLabel:temp];
        [[cell contentView] addSubview:[cell playerLabel]];
        
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, temp.frame.origin.y + temp.frame.size.height, 100, 40)];
        [scoreLabel setText:@"Payout:"];
        [scoreLabel sizeToFit];
        [cell addSubview:scoreLabel];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
        [formatter setGroupingSeparator:groupingSeparator];
        [formatter setGroupingSize:3];
        [formatter setAlwaysShowsDecimalSeparator:NO];
        [formatter setUsesGroupingSeparator:YES];
        [formatter setNegativeFormat:@"-¤#,##0.00"];
        
        NSString *formattedString = [formatter stringFromNumber:[NSNumber numberWithFloat:((NSNumber*)[[[cardObject instance] playerPayouts] objectAtIndex:indexPath.row]).floatValue/100.0f]];
        
        UILabel *payLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, temp.frame.origin.y + temp.frame.size.height/2, 100, 40)];
        [payLabel setText:formattedString];
        [payLabel sizeToFit];
        [cell setPayoutLabel:payLabel];
        [[cell contentView] addSubview:[cell payoutLabel]];
    }
    
    return cell;
}

@end
