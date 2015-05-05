//
//  ViewController.m
//  Checklist
//
//  Created by 洪磊 on 15/4/4.
//  Copyright (c) 2015年 honglei. All rights reserved.
//

#import "ChecklistViewController.h"
#import "ChecklistItem.h"
#import "ItemDetailViewController.h"

@interface ChecklistViewController()

@end

@implementation ChecklistViewController
 {
     ChecklistItem *_row0Item;
     ChecklistItem *_row1Item;
     ChecklistItem *_row2Item;
     ChecklistItem *_row3Item;
     ChecklistItem *_row4Item;
     NSMutableArray *_items;
     /*
     BOOL _row0checked;
     BOOL _row1Item.checked;
     BOOL _row2checked;
     BOOL _row3Item.checked;
     BOOL _row4checked;
      */
}

-(void)loadChecklistItems
{
    NSString *path =[self dataFilePath];
    if([[NSFileManager defaultManager]fileExistsAtPath:path])
    {
        NSData *data = [[NSData alloc]initWithContentsOfFile:path ];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
     _items = [unarchiver decodeObjectForKey:@"ChecklistItems"]; [unarchiver finishDecoding];
    }
    else{
        _items = [[NSMutableArray alloc]initWithCapacity:20];
    }
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if((self =[super initWithCoder:aDecoder]))
    {
        [self loadChecklistItems];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"⽂文件夹的⺫⽬目录是:%@",[self documentsDirectory]);
    NSLog(@"数据⽂文件的最终路径是:%@",[self dataFilePath]);
    //_items = [[NSMutableArray alloc]initWithCapacity:20];

    
}

-(NSString*)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject]; return documentsDirectory;
}


-(NSString*)dataFilePath
{
    return [[self documentsDirectory]stringByAppendingPathComponent:@"Checklists.plist"];
}

-(void)saveChecklistItems
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:_items forKey:@"ChecklistItems"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
    
}


-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item
{
    NSInteger newRowIndex = [_items count]; [_items addObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self saveChecklistItems];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem: (ChecklistItem *)item{
    NSInteger index = [_items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self configureTextForCell:cell withChecklistItem:item]; [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)configureCheckmarkForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    if(item.checked)
    {
        label.text = @"√";
    }
    else
    {
        label.text = @"";
    }
}

- (void)configureTextForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = item.text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"ChecklistItem"]; ChecklistItem *item = _items[indexPath.row];
    [self configureTextForCell:cell withChecklistItem:item];
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath]; ChecklistItem *item = _items[indexPath.row];
    [item toggleChecked];
    //下面这个方法不知道干嘛的。。。解开注释就出
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    [self saveChecklistItems];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_items removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)itemDetailViewContyroller:(ItemDetailViewController *)controller didFinishAddingItem: (ChecklistItem *)item
{
    NSInteger newRowIndex = [_items count];
    [_items addObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddItem"])
    {
    //1
    UINavigationController *navigationController = segue.destinationViewController;
    //2
    ItemDetailViewController *controller = (ItemDetailViewController*) navigationController.topViewController;
    //3
    controller.delegate = self;
    }
    else if([segue.identifier isEqualToString:@"EditItem"])
    {
    UINavigationController *navigationController = segue.destinationViewController;
    ItemDetailViewController *controller = (ItemDetailViewController*) navigationController.topViewController;
    controller.delegate = self;
    NSIndexPath * indexPath = [self.tableView indexPathForCell:sender]; controller.itemToEdit = _items[indexPath.row];
} }@end
