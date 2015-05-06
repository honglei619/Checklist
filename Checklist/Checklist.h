//
//  Checklist.h
//  Checklist
//
//  Created by 洪磊 on 15/5/4.
//  Copyright (c) 2015年 honglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject

@property(nonatomic,copy) NSString *name;
@property(nonatomic,strong)NSMutableArray *items;

@end
