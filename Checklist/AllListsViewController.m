//
//  AllListsViewController.m
//  Checklist
//
//  Created by 洪磊 on 15/5/4.
//  Copyright (c) 2015年 honglei. All rights reserved.
//

#import "AllListsViewController.h"
#import "Checklist.h"

@interface AllListsViewController ()

@end

@implementation AllListsViewController
{
    NSMutableArray *_lists;
}

-(id)initWithCoder:(NSCoder *)aDecoder{ if((self =[super initWithCoder:aDecoder]))
{
    _lists = [[NSMutableArray alloc]initWithCapacity:20];
    Checklist *list;
    list = [[Checklist alloc]init]; list.name = @"娱乐";
    [_lists addObject:list];
    list = [[Checklist alloc]init]; list.name = @"工作"; [_lists addObject:list];
    list = [[Checklist alloc]init]; list.name = @"学习"; [_lists addObject:list];
    list = [[Checklist alloc]init]; list.name = @"家庭"; [_lists addObject:list];
}
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_lists count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell... if(cell == nil){
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
Checklist *checklist = _lists[indexPath.row];
cell.textLabel.text = checklist.name;
cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowChecklist" sender:nil];
}


@end
