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
#import <AFOUIKIT/UIViewController+CurrentController.h>
@implementation AFOSchedulerBaseClass (AFORouter)
+ (void)jumpPassingParameters:(NSDictionary *)parameters{
    NSArray *paraArray = @[[UIViewController currentViewController],[self nextController:parameters],parameters];
    Class class = NSClassFromString(@"AFORouterActionContext");
    id instance = [[class alloc] init];
//    [instance setValue:[UIViewController currentViewController] forKey:@"currentController"];
//    [instance setValue:[self nextController:parameters] forKey:@"nextController"];
    SEL sel = NSSelectorFromString(@"passingCurrentController:nextController:parameters:");
    if ([instance respondsToSelector:sel]) {
        [instance schedulerPerformSelector:sel params:paraArray];
    }
}
+ (UIViewController *)nextController:(NSDictionary *)parameters{
    Class class = NSClassFromString(parameters[@"next"]);
    UIViewController *controller = [[class alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    return controller;
}
@end
