//
//  IconPickerViewController.h
//  Checklist
//
//  Created by Lei on 15/5/12.
//  Copyright (c) 2015年 honglei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IconPickerViewController;
@protocol IconPickerViewControllerDelegate <NSObject>

-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName;

@end

@interface IconPickerViewController : UITableViewController
@property(nonatomic,weak)id<IconPickerViewControllerDelegate>delegate;

@end
