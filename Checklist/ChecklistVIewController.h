//
//  ViewController.h
//  Checklist
//
//  Created by 洪磊 on 15/4/4.
//  Copyright (c) 2015年 honglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChecklistItem.h"
#import "ItemDetailViewController.h"

@interface ChecklistViewController: UITableViewController<ItemDetailViewControllerDelegate>

-(void) configureTextForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item;
-(void)configureCheckmarkForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item;

@end