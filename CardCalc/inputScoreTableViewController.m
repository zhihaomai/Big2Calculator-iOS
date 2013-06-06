//
//  inputScoreTableViewController.m
//  CardCalc
//
//  Created by Zee on 2013-02-26.
//  Copyright (c) 2013 Zee. All rights reserved.
//

#import "inputScoreTableViewController.h"
#import "cardObject.h"
#import "cardCalcCell.h"

@interface inputScoreTableViewController ()

@end

@implementation inputScoreTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
};


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    static NSString *CellIdentifier = @"Cell";
    cardCalcCell *cell = [[cardCalcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell setPlayerNumber:indexPath.row];
    
    UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(75, 20, 100, 40)];
    [temp setText:[NSString stringWithFormat:@"Player %d", indexPath.row+1]];
    [temp sizeToFit];
    [cell setPlayerLabel:temp];
    [[cell contentView] addSubview:[cell playerLabel]];

    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, temp.frame.origin.y + temp.frame.size.height, 100, 40)];
    [scoreLabel setText:@"Score:"];
    [scoreLabel sizeToFit];
    [cell addSubview:scoreLabel];
    
    UITextField *numberField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 150, (CELL_HEIGHT - 30)/2, 80, 30)];
    [numberField setTag:[cell playerNumber]];
    [numberField setDelegate:self];
    [numberField setBorderStyle:UITextBorderStyleRoundedRect];
    //[numberField setReturnKeyType:UIReturnKeyDone];
    [numberField setKeyboardType:UIKeyboardTypePhonePad];
    //[numberField setKeyboardAppearance:UIKeyboardAppearanceAlert];
    [cell setScoreField:numberField];
    [[cell contentView] addSubview:[cell scoreField]];
    
//    cellSeparator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"col_screen_line.png"]];
//    [cellSeparator setTag:SEPARATOR_TAG];
//    cellSeparator = (UIImageView *)[cell viewWithTag:SEPARATOR_TAG];
    
    return cell;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField {
    
    // SUPPOSEDLY Scroll to the current text field
    
    CGRect textFieldRect = [textField frame];
    [self.tableView scrollRectToVisible:textFieldRect animated:YES];
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
