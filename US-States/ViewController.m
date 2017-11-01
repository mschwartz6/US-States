//
//  ViewController.m
//  US-States
//
//  Created by alive on 10/31/17.
//  Copyright © 2017 Matthew Schwartz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSString *stateSelected;
    UIColor *mainColor;
}
@property(nonatomic, strong) NSArray *states;
@property(nonatomic, strong) NSArray *stateCapitals;
@property(nonatomic, strong) NSArray *statesAbrev;
@end




@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //set color to one variable so as not to repeat code
    mainColor = [UIColor colorWithRed:0.0 green:0.64 blue:.96 alpha:1.0];
    self.view.backgroundColor = mainColor;
    
    //populate array of States, State Capitals, and State's abbreviations
    _states = @[@"Alabama", @"Alaska", @"Arizona", @"Arkansas", @"California", @"Colorado", @"Connecticut", @"Delaware", @"Florida", @"Georgia", @"Hawaii", @"Idaho", @"Illinois", @"Indiana", @"Iowa", @"Kansas", @"Kentucky", @"Louisiana", @"Maine", @"Maryland", @"Massachusetts", @"Michigan", @"Minnesota", @"Mississippi", @"Missouri"];
    _stateCapitals = @[@"Montgomery",@"Juneau",@"Phoenix",@"Little Rock",@"Sacramento",@"Denver",@"Hartford",@"Dover",@"Tallahassee",@"Atlanta",@"Honolulu",@"Boise",@"Springfield",@"Indianapolis",@"Des Moines",@"Topeka",@"Frankfort",@"Baton Rouge",@"Augusta",@"Annapolis",@"Boston",@"Lansing",@"St. Paul",@"Jackson",@"Jefferson City"];
    _statesAbrev = @[@"al", @"ak", @"az", @"ar", @"ca", @"co", @"ct", @"de", @"fl", @"ga", @"hi", @"id", @"il", @"in", @"ia", @"ks", @"ky", @"la", @"me", @"md", @"ma", @"mi", @"mn", @"ms",@"mo"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/****  Table View Data Source Methods ****/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_states count];
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableIdentifier";
    NSString *stateFlag = self.statesAbrev[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if ( cell == nil )
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    //coordinate cell view
    cell.textLabel.text = self.states[indexPath.row];
    cell.detailTextLabel.text = self.stateCapitals[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:stateFlag];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:32];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:18];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //Round about way to set the selected cell's color
    
    UIView *backView = [[UIView alloc]initWithFrame:cell.frame];
    UIColor *white = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    backView.backgroundColor = white;
    cell.selectedBackgroundView = backView;
    cell.backgroundColor = mainColor;
    backView = nil;
    
    
    return cell;
}

/****  Table View Delegate Methods ****/

-(NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
        return nil;
    else
        return indexPath;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *state = _states[indexPath.row];
    NSString *stateCapital = _stateCapitals[indexPath.row];
    NSString *message = [NSString stringWithFormat:@"State: %@\nState Capital: %@\n",state,stateCapital ];
    stateSelected = [[NSString alloc]initWithString:state];
    
    //Print out State and State Capital information to debug window
    NSLog(@"%@", [NSString stringWithFormat:@"%@",message]);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //Once row is selected.. initiate segue to web view
    [self performSegueWithIdentifier:@"toStateInfoVC" sender:self];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  80;
}

/****  Navigation  ****/
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toStateInfoVC"])
    {
        //Avoid hassle of selecting between Georgia the country and Georgia the state
        if ([stateSelected isEqualToString:@"Georgia"])
        {
            stateSelected = @"Georgia_(US_state)";
        }
        StateInfoViewController *destination = [segue destinationViewController];
        //Send over selected state and the main color for continuity
        destination.stateName = [NSString stringWithFormat:@"%@",stateSelected];
        destination.mainColor = mainColor;
    }
}
-(IBAction)unwindAction:(UIStoryboardSegue *)unwindSegue
{
    //
}

@end
