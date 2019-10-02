//
//  AFORouterManager.m
//  AFORouter
//
//  Created by xueguang xian on 2017/12/18.
//  Copyright © 2017年 AFO. All rights reserved.
//

#import "AFORouterManager.h"
#import <UIKit/UIKit.h>
#import <AFOUIKIT/UIViewController+CurrentController.h>
#import <AFOFoundation/AFOFoundation.h>
#import "JLRoutes.h"
#import "AFORouterManager+StringManipulation.h"
#import "AFORouterManagerDelegate.h"
#import "AFORouterActionContext.h"
@interface AFORouterManager ()<AFORouterManagerDelegate,UIApplicationDelegate>
@property (nonatomic, strong) JLRoutes                  *routes;
@property (nonatomic, copy)   NSString                  *strScheme;
@property (nonatomic, strong)       id                   valueModel;
@end

@implementation AFORouterManager
#pragma mark ------ shareInstance
+ (instancetype)shareInstance{
    static AFORouterManager<UIApplicationDelegate> *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[[self class] alloc] init];
    });
    return shareInstance;
}
#pragma mark ------
- (void)loadNotification{
    [self readRouterScheme];
    [self loadRotesFile];
}
#pragma mark ------ 设置Schemes
- (void)readRouterScheme{
    self.strScheme = [NSString readSchemesFromInfoPlist];
    self.routes = [JLRoutes routesForScheme:self.strScheme];
}
#pragma mark ------ 添加跳转规则
- (void)loadRotesFile{
    WeakObject(self);
    [self.routes addRoute:@"/:modelName/:current/:next/:action"handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        StrongObject(self)
        AFORouterActionContext *action = [[AFORouterActionContext alloc] initAction:parameters[@"action"]];
        [action currentController:[UIViewController currentViewController] nextController:[self nextController:parameters] parameter:parameters];
//        [self addSenderControllerRouterManagerDelegate:[self nextController:parameters] present:[UIViewController currentViewController] parameters:parameters];
        return YES;
    }];
}
- (UIViewController *)nextController:(NSDictionary *)parameters{
    Class class = NSClassFromString(parameters[@"next"]);
    UIViewController *controller = [[class alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    return controller;
}
#pragma mark ------------
- (void)addSenderControllerRouterManagerDelegate:(id)pushController
                                         present:(id)presentController
                                      parameters:(NSDictionary *)parameters{
    ///------ 传递值
    if ([presentController respondsToSelector:@selector(didSenderRouterManagerDelegate)]) {
        self.valueModel = [presentController performSelector:@selector(didSenderRouterManagerDelegate)];
    }
    ///------ 获取值
    if ([pushController respondsToSelector:@selector(didReceiverRouterManagerDelegate:)]) {
        [pushController performSelector:@selector(didReceiverRouterManagerDelegate:) withObject:parameters];
    }
    ///------ 获取值
    if ([pushController respondsToSelector:@selector(didReceiverRouterManagerDelegate:parameters:)] && self.valueModel) {
        [pushController performSelector:@selector(didReceiverRouterManagerDelegate:parameters:) withObject:self.valueModel withObject:parameters];
    }
}
#pragma mark ------ 匹配URL
- (BOOL)routeURL:(NSURL *)url{
    return [self.routes routeURL:url];
}
#pragma mark ------ 不带参数URL
- (NSString *)settingPushControllerRouter:(id)controller{
    return [self settingPushControllerRouter:controller scheme:self.strScheme params:nil];
}
#pragma mark ------ 带参数URL
- (NSString *)settingPushControllerRouter:(id)controller params:(NSDictionary *)dictionary{
    return [self settingPushControllerRouter:controller scheme:self.strScheme params:dictionary];
}
#pragma mark ------
- (NSString *)settingPushControllerRouter:(id)controller
                                  present:(id)present
                                   params:(NSDictionary *)dictionary{
    return [self settingPushControllerRouter:controller present:present scheme:self.strScheme params:dictionary];
}
#pragma mark ------ UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self loadNotification];
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation{
    return [self routeURL:url];
}
#pragma mark ------ dealloc
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark ------ property
@end
