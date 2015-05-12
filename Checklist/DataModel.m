//
//  DataModel.m
//  Checklist
//
//  Created by Lei on 15/5/10.
//  Copyright (c) 2015年 honglei. All rights reserved.
//

#import "DataModel.h"
#import "Checklist.h"

@implementation DataModel

-(void)registerDefault{
    
    NSDictionary *dictionary =@{@"ChecklistIndex":@-1,@"FirstTime":@ YES};
    [[NSUserDefaults standardUserDefaults]registerDefaults:dictionary                   ];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        [self loadChecklists];
    }
    return self;
}
-(id)init{
    if ((self = [super init])) {
        [self loadChecklists];
        [self registerDefault];
        [self handleFirstTime];
    }
    return self;
}

-(void)handleFirstTime{
    BOOL firstTime = [[NSUserDefaults standardUserDefaults]boolForKey:@"FirstTime"];
    if (firstTime) {
        Checklist *checklist = [[Checklist alloc]init];
        checklist.name  = @"List";
        [self.lists addObject:checklist];
        [self setIndexOfSelectChecklist:0];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"FirstTime"];
        
    }
}


-(NSString*)documentsDirectory{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
     NSLog(@"file path is %@",documentsDirectory);
    return documentsDirectory;
   
}

-(NSString*)dataFilePath{
    
    return [[self documentsDirectory]stringByAppendingPathComponent:@"Checklists.plist"];
}

-(void)saveChecklists{
    
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    [archiver encodeObject:self.lists forKey:@"Checklists"];
    [archiver finishEncoding];
    
    [data writeToFile:[self dataFilePath] atomically:YES];
    
    
}

-(void)loadChecklists{
    
    NSString *path = [self dataFilePath];
    
    if([[NSFileManager defaultManager]fileExistsAtPath:path]){
        
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        
        self.lists = [unarchiver decodeObjectForKey:@"Checklists"];
        
        [unarchiver finishDecoding];
    }else{
        
        self.lists = [[NSMutableArray alloc]initWithCapacity:20];
    }
    NSLog(@"file path is %@",path);
    
}

-(NSInteger)indexOfSelectedChecklist{
    return [[NSUserDefaults standardUserDefaults]integerForKey:@"ChecklistIndex"];
    
}

-(void)setIndexOfSelectChecklist:(NSInteger)index{
    [[NSUserDefaults standardUserDefaults]setInteger:index forKey:@"ChecklistIndex"];
}

-(void)sortChecklists{
    [self.lists sortUsingSelector:@selector(compare:)];
}


@end
