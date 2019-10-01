//
//  AFORouterManager.m
//  AFORouter
//
//  Created by xueguang xian on 2017/12/18.
//  Copyright © 2017年 AFO. All rights reserved.
//

#import "AFORouterManager.h"
#import <UIKit/UIKit.h>
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
        ///------
        Class classPush = NSClassFromString(parameters[@"next"]);
        UIViewController *nextController = [[classPush alloc] init];
        nextController.hidesBottomBarWhenPushed = YES;
        UIViewController *currentController = [AFORouterManager currentViewController];
        [self addSenderControllerRouterManagerDelegate:nextController present:currentController parameters:parameters];
        AFORouterActionContext *action = [[AFORouterActionContext alloc] initAction:parameters[@"action"]];
        [action currentController:currentController nextController:nextController];
//        [currentController.navigationController pushViewController:nextController animated:YES];
        return YES;
    }];
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
#pragma mark ------ 当前Controller
+ (UIViewController *)currentViewController {
    UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentController = [self currentControllerFrom:controller];
    return currentController;
}
+ (UIViewController *)currentControllerFrom:(UIViewController *)controller{
    UIViewController *currentController;
    if ([controller presentedViewController]) {
        UIViewController *nextController = [controller presentedViewController];
        currentController = [self currentControllerFrom:nextController];
    } else if ([controller isKindOfClass:[UITabBarController class]]) {
        UIViewController *nextController = [(UITabBarController *)controller selectedViewController];
        currentController = [self currentControllerFrom:nextController];
    } else if ([controller isKindOfClass:[UINavigationController class]]){
        UIViewController *nextController = [(UINavigationController *)controller visibleViewController];
        currentController = [self currentControllerFrom:nextController];
    } else {
        currentController = controller;
    }
    return currentController;
}
#pragma mark ------ navigation last Controller
- (id)returnNavigationLastObject:(id)controller{
    UINavigationController  *navigation = (UINavigationController *)controller;
    return [[navigation viewControllers] lastObject];
}
#pragma mark ------ tabBarController select Controller
- (id)returnTabBarControllerSelect:(id)controller{
    UITabBarController *tabBar = controller;
    if ([tabBar.selectedViewController isKindOfClass:[UINavigationController class]]) {
        return [self returnNavigationLastObject:tabBar.selectedViewController];
    }else{
        return tabBar.selectedViewController;
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
#pragma mark ------
- (NSString *)settingRoutesParameters:(NSDictionary *)dictionary{
    NSString *strResult;
    NSString *strBase = [self.strScheme stringByAppendingString:@"://"];
    strBase = [strBase stringByAppendingString:dictionary[@"modelName"]];
    NSString *controller = dictionary[@"controller"];
    NSString *present = dictionary[@"present"];
    NSString *action = dictionary[@"action"];
    if (controller != nil && present != nil) {
        strResult = [[self slashString:strBase] stringByAppendingString:present];
        strResult = [[self slashString:strResult] stringByAppendingString:controller];
        strResult = [[self slashString:strResult] stringByAppendingString:action];
    }else{
        strResult = [strBase stringByAppendingString:controller];
        strResult = [[self slashString:strResult] stringByAppendingString:action];
    }
    if (dictionary.count > 0) {
        strResult = [self addQueryStringToUrl:strResult params:[self paramesDictionary:dictionary]];
    }
    return strResult;
}
- (NSString *)slashString:(NSString *)baseString{
    
    return [baseString stringByAppendingString:@"/"];
}
- (NSDictionary *)paramesDictionary:(NSDictionary *)dictionary{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:dictionary];
    [dic removeObjectsForKeys:@[@"modelName",@"action",@"present"]];
    return dic;
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
