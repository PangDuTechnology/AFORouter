//
//  AFOSchedulerBaseClass+AFORouter.m
//  AFORouter
//
//  Created by piccolo on 2019/10/13.
//  Copyright © 2019 AFO. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AFOSchedulerBaseClass+AFORouter.h"
#import <AFOSchedulerCore/NSObject+AFOScheduler.h>
@implementation AFOSchedulerBaseClass (AFORouter)
#pragma mark ------ router
+ (void)jumpPassingParameters:(NSDictionary *)parameters{
    SEL current = NSSelectorFromString(@"currentViewController");
    if ([UIViewController respondsToSelector:current]) {
        id controller = [UIViewController performSelector:current];
        NSArray *paraArray = @[controller,parameters[@"next"],parameters];
        Class class = NSClassFromString(@"AFORouterActionContext");
        id instance = [[class alloc] init];
        SEL sel = NSSelectorFromString(@"passingCurrentController:nextController:parameters:");
        if ([instance respondsToSelector:sel]) {
            [instance schedulerPerformSelector:sel params:paraArray];
        }
    }
}
+ (void)jumpPassingParameters:(NSDictionary *)parameters
                        block:(void(^)(id target))block{
    SEL current = NSSelectorFromString(@"currentViewController");
    id instance;
    if ([UIViewController respondsToSelector:current]) {
        id controller = [UIViewController performSelector:current];
        NSArray *paraArray = @[controller,parameters[@"next"],parameters];
        Class class = NSClassFromString(@"AFORouterActionContext");
        instance = [[class alloc] init];
        SEL sel = NSSelectorFromString(@"passingCurrentController:nextController:parameters:");
        if ([instance respondsToSelector:sel]) {
            [instance schedulerPerformSelector:sel params:paraArray];
        }
    }
    block(instance);
}
#pragma mark ------ pass value
+ (void)routerSchedulerPassValue:(UIViewController *)nextController
                      parameters:(NSDictionary *)parameters{
    
}
@end
