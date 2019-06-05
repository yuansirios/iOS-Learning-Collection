//
//  WeakArray.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/20.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "WeakArray.h"
#import "WeakMutableArray.h"

@implementation WeakArray

- (void)run{
    
    //示例
    //NSArray *array = [NSArray arrayWithObject:obj];
    
    //1、NSValue
    //NSValue *value = [NSValue valueWithNonretainedObject:obj];
    
    //2、NSPointerArray
    //NSPointerArray *array = [NSPointerArray weakObjectsPointerArray];
    //[array addPointer:obj];
    
    //3、NSHashTable
    //NSHashTable *table = NSHashTable.weakObjectsHashTable;
    //[table addObject:obj];
    
    //4、NSMapTable
    //NSMapTable *map = [NSMapTable strongToWeakObjectsMapTable];
    //[map setObject:obj forKey:@"obj"];
    
    NSObject *obj = NSObject.new;
    
    WeakMutableArray *array = WeakMutableArray.new;
    
    [array addObject:obj];
    
    NSLog(@"arrayCount = %lu , objRetain = %d",(unsigned long)array.allCount,(unsigned int)obj.retainCount);
}

- (void)dealloc{
    NSLog(@">>>>>> %@ dealloc <<<<<<",NSStringFromClass([self class]));
    [super dealloc];
}

@end
