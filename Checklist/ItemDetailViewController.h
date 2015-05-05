//
//  itemDetailViewContyrollerTableViewController.h
//  Checklist
//
//  Created by 洪磊 on 15/4/7.
//  Copyright (c) 2015年 honglei. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ItemDetailViewController;
@class ChecklistItem;

@protocol ItemDetailViewControllerDelegate <NSObject>
-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;
- (void)itemDetailViewController:(ItemDetailViewController *)controller
             didFinishAddingItem:(ChecklistItem *)item;
- (void)itemDetailViewController:(ItemDetailViewController *)controller
            didFinishEditingItem:(ChecklistItem *)item;
@end

@interface ItemDetailViewController : UITableViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property(nonatomic,weak) id <ItemDetailViewControllerDelegate> delegate;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property(nonatomic,strong) ChecklistItem *itemToEdit;
@end
