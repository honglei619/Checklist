//
//  ChecklistItem.m
//  Checklist
//
//  Created by 洪磊 on 15/4/6.
//  Copyright (c) 2015年 honglei. All rights reserved.
//

#import "ChecklistItem.h"
#import "DataModel.h"

@implementation ChecklistItem

- (void)toggleChecked
{
    self.checked = !self.checked;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
    [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [aCoder encodeInteger:self.itemId forKey:@"ItemID"];
}
-(id)init{
    if((self =[super init])){
        self.itemId = [DataModel nextChecklistItemId];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self =[super init])) {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
        self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
        self.itemId = [aDecoder decodeIntegerForKey:@"ItemId"];
    }
    return self;
}


@end