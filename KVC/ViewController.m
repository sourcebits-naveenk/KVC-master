//
//  ViewController.m
//  KVC
//
//  Created by Naveen Katari on 14/10/15.
//  Copyright (c) 2015 Sourcebits. All rights reserved.
//

#import "ViewController.h"
#import "addViewController.h"

@interface ViewController () {
    NSArray *indexArray ;
    NSArray *tempStudentData;
    NSArray *searchResults;
    NSInteger *rowCount;
    NSMutableArray *arrayData;
}

@end
NSMutableArray *stu;

@implementation ViewController

- (void)viewDidLoad

{
    [super viewDidLoad];
    
    stu = [[NSMutableArray alloc]init];
    addViewController *addView = [[addViewController alloc] init ];
    addView.delegate = self;
    _tableViewStudentsList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableViewStudentsList.estimatedRowHeight = 44.0;
    _tableViewStudentsList.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    if (_tableViewStudentsList != nil) {
        [_tableViewStudentsList reloadData ];
    }
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ stu count ];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"addDetails"]) {
        addViewController *addVC = (addViewController*)[segue destinationViewController];
        //addVC = [segue destinationViewController];
        addVC.delegate = self;

    }
}
-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"transferCellData"])
    {
        //addViewController *addVC = [[addViewController alloc]init];
        addViewController *addVC = [self.storyboard instantiateViewControllerWithIdentifier:@"addViewController"];
        addVC.delegate = self;
        addVC.arrayHoldRowId = indexArray;
        [self.navigationController pushViewController:addVC animated:YES];
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *newCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (newCell == nil)
    {
        newCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    tempStudentData = [stu objectAtIndex:indexPath.row];
        [newCell.textLabel setText: tempStudentData[0]];
         newCell.textLabel.numberOfLines = 0;
         return newCell;
}

-(void)addItemViewController:(NSMutableArray *)studentData
{
    [stu addObject:studentData];
    [_tableViewStudentsList reloadData];
}

- (void)editItemViewController: (NSMutableArray *) studentData {
    //[stu setValue:studentData forKey:<#(NSString *)#>]
//    stu[(int)rowCount] = studentData;
//   [_tableViewStudentsList reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //rowCount = indexPath.row;
    indexArray = [stu objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"transferCellData" sender:self];
}

- (IBAction)buttonSearch:(id)sender
{
//    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"name %a", _searchField.text];
//    NSArray *filteredFiles = [[NSMutableArray alloc]init];
    
    //searchResults = [stu filteredArrayUsingPredicate:searchPredicate];
    [self.tableViewStudentsList reloadData];
    if (![_searchField.text isEqualToString:@""]) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"ANY SELF LIKE %@", _searchField.text];
        NSArray *filteredArr = [stu filteredArrayUsingPredicate:pred];
        arrayData = stu;
        [stu removeAllObjects];
        [stu addObject:filteredArr[0]];
        [self.tableViewStudentsList reloadData];
    }
}


- (IBAction)buttonAdd:(id)sender
{
   // [self performSegueWithIdentifier:@"addDetails" sender:self];
}
@end
