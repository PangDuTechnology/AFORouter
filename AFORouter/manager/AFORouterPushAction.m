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
#pragma mark ------ AFORouterActionDelegate
- (void)currentController:(UIViewController *)current
           nextController:(UIViewController *)next{
    next.hidesBottomBarWhenPushed = YES;
    [current.navigationController pushViewController:next animated:YES];
}
@end
