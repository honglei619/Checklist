//
//  ChecklistItem.h
//  Checklist
//
//  Created by 洪磊 on 15/4/6.
//  Copyright (c) 2015年 honglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject<NSCoding>
@property(nonatomic,copy)   NSString    *text;
@property(nonatomic,assign) BOOL        checked;
@property(nonatomic,copy) NSDate  *dueDate;
@property(nonatomic,assign)BOOL shouldRemind;
@property(nonatomic,assign)NSInteger itemId;
- (void)toggleChecked;
@end