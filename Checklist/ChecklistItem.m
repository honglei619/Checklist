//
//  ChecklistItem.m
//  Checklist
//
//  Created by 洪磊 on 15/4/6.
//  Copyright (c) 2015年 honglei. All rights reserved.
//

#import "ChecklistItem.h"

@implementation ChecklistItem

- (void)toggleChecked
{
    self.checked = !self.checked;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self =[super init])) {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeObjectForKey:@"Checked"];
    }
    return self;
}

@end