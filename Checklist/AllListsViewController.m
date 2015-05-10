//
//  AllListsViewController.m
//  Checklists
//
//  Created by Matthijs on 02-10-13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "AllListsViewController.h"
#import "Checklist.h"
#import "ChecklistViewController.h"
#import "DataModel.h"
#import "ChecklistItem.h"

@interface AllListsViewController ()

@end

@implementation AllListsViewController



#pragma mark 获取沙盒地址
/*
-(NSString*)documentsDirectory{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    
    return documentsDirectory;
    NSLog(@"file path is %@",documentsDirectory);
}

-(NSString*)dataFilePath{
    
    return [[self documentsDirectory]stringByAppendingPathComponent:@"Checklists.plist"];
}

-(void)saveChecklists{
    
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    [archiver encodeObject:_lists forKey:@"Checklists"];
    [archiver finishEncoding];
    
    [data writeToFile:[self dataFilePath] atomically:YES];
    

}

-(void)loadChecklists{
    
    NSString *path = [self dataFilePath];
    
    if([[NSFileManager defaultManager]fileExistsAtPath:path]){
        
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        
        _lists = [unarchiver decodeObjectForKey:@"Checklists"];
        
        [unarchiver finishDecoding];
    }else{
        
        _lists = [[NSMutableArray alloc]initWithCapacity:20];
    }
    NSLog(@"file path is %@",path);
    
}

#pragma mark init


- (id)initWithCoder:(NSCoder *)aDecoder
{
  if ((self = [super initWithCoder:aDecoder]))
  {
      [self loadChecklists];
  }
  return self;
}

*/
- (void)viewDidLoad
{
    [super viewDidLoad];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.dataModel.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }

  Checklist *checklist = self.dataModel.lists[indexPath.row];
  cell.textLabel.text = checklist.name;
  cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.dataModel setIndexOfSelectChecklist:indexPath.row];
    
  Checklist *checklist = self.dataModel.lists[indexPath.row];

  [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self.dataModel.lists removeObjectAtIndex:indexPath.row];

  NSArray *indexPaths = @[indexPath];
  [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"ShowChecklist"]) {
    ChecklistViewController *controller = segue.destinationViewController;
    controller.checklist = sender;
  } else if ([segue.identifier isEqualToString:@"AddChecklist"]) {
    UINavigationController *navigationController = segue.destinationViewController;
    ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
    controller.delegate = self;
    controller.checklistToEdit = nil;
  }
}

- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(Checklist *)checklist
{
  NSInteger newRowIndex = [self.dataModel.lists count];
  [self.dataModel.lists addObject:checklist];

  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
  NSArray *indexPaths = @[indexPath];
  [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];

  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(Checklist *)checklist
{
  NSInteger index = [self.dataModel.lists indexOfObject:checklist];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
  UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
  cell.textLabel.text = checklist.name;

  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
  UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];

  ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
  controller.delegate = self;

  Checklist *checklist = self.dataModel.lists[indexPath.row];
  controller.checklistToEdit = checklist;

  [self presentViewController:navigationController animated:YES completion:nil];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self) {
        [self.dataModel setIndexOfSelectChecklist:-1];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    NSInteger index =[self.dataModel indexOfSelectedChecklist];
    if (index >=0 && index<[self.dataModel.lists count]) {
        Checklist *checklist = self.dataModel.lists[index];
        [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
    }else{
        NSLog(@"bad command Error");
    }
}

@end
