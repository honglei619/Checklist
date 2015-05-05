//
//  AddItemViewControllerTableViewController.m
//  Checklist
//
//  Created by 洪磊 on 15/4/7.
//  Copyright (c) 2015年 honglei. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ChecklistItem.h"

@interface ItemDetailViewController()

@end

@implementation ItemDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.itemToEdit != nil){ self.title = @"Edit Item";
        self.textField.text = self.itemToEdit.text;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.itemToEdit != nil)
    {
        self.title = @"Edit Item";
        self.textField.text = self.itemToEdit.text;
    }
    
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

-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (IBAction)cancel:(id)sender
{
    [self.delegate itemDetailViewControllerDidCancel:self];
}
- (IBAction)done:(id)sender
{
    if(self.itemToEdit == nil)
    {
        ChecklistItem *item = [[ChecklistItem alloc]init]; item.text = self.textField.text;
        item.checked = NO;
        [self.delegate itemDetailViewController:self didFinishAddingItem:item];
    }
    else{
            self.itemToEdit.text = self.textField.text;
            [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
        }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if([newText length]>0 && newText!=nil && newText!=NULL && [[newText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]!=0)   //判断输入的字符长度大于1，并且不能为空对象及空格
    {
        self.doneBarButton.enabled = YES;
    }else
    {
        self.doneBarButton.enabled = NO;
    }
    //self.doneBarButton.enabled = ([newText length]>0);
    return YES;
}


@end
