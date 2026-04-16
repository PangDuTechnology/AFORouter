//
//  AFORouterPushAction.m
//  AFORouter
//
//  Created by xianxueguang on 2019/10/1.
//  Copyright © 2019年 AFO. All rights reserved.
//

#import "AFORouterPushAction.h"
@interface AFORouterPushAction ()

@end

@implementation AFORouterPushAction
#pragma mark ------ 
- (void)currentController:(UIViewController *)current
           nextController:(NSString *)next
                parameter:(nonnull NSDictionary *)paramenter{
    Class class = NSClassFromString(next);
    UIViewController *controller = [[class alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    NSString *title = nil;
    id rawTitle = paramenter[@"title"];
    if ([rawTitle isKindOfClass:[NSString class]]) {
        title = (NSString *)rawTitle;
    }
    if (title.length > 0) {
        controller.title = title;
        controller.navigationItem.title = title;
        controller.navigationItem.titleView = nil;
        if (@available(iOS 11.0, *)) {
            controller.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeNever;
        }
    }
    [AFOSchedulerBaseClass schedulerController:current present:controller parameters:paramenter];
    UINavigationController *nav = current.navigationController ?: current.tabBarController.selectedViewController.navigationController;
    [nav pushViewController:controller animated:YES];
}
@end
