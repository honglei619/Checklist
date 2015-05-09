//
//  DataModel.h
//  Checklist
//
//  Created by Lei on 15/5/10.
//  Copyright (c) 2015年 honglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
@property(nonatomic,strong)NSMutableArray *lists;

-(void)saveChecklists;

@end
