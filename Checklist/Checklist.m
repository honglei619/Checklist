//
//  Checklist.m
//  Checklist
//
//  Created by 洪磊 on 15/5/4.
//  Copyright (c) 2015年 honglei. All rights reserved.
//

#import "Checklist.h"
#import "ChecklistItem.h"

@implementation Checklist

-(id)init
{
    if ((self =[super init])) {
        self.items = [[NSMutableArray alloc]initWithCapacity:20];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super init])){
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.items = [aDecoder decodeObjectForKey:@"Items"];
    }
    return self;
}
-(int)countUncheckedItems{
    int count = 0;
    for (ChecklistItem *item in self.items){
        if(!item.checked){
            count+= 1;
        }
    }
    return count;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.items forKey:@"Items"];
}
@end

