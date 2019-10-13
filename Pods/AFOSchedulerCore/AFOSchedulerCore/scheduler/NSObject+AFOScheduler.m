//
//  NSObject+AFOScheduler.m
//  AFORouter
//
//  Created by xianxueguang on 2019/10/9.
//  Copyright © 2019年 AFO. All rights reserved.
//

#import "NSObject+AFOScheduler.h"
#import "AFOSchedulerCore.h"
@implementation NSObject (AFOScheduler)
- (nullable id)schedulerPerformSelector:(SEL)selector{
    return [[AFOSchedulerCore shareSchedulerCore] schedulerInstanceMethod:selector target:self params:@[]];
}
- (nullable id)schedulerPerformSelector:(SEL)selector
                            params:(nullable NSArray *)params{
    return nil;
}
@end
