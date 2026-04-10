//
//  AFORouting.h
//  AFORouter
//
//  与 AFORouterManager 注册的 `/:modelName/:current/:next/:action` 及常见业务扩展键一致，供各业务模块拼参时统一使用，避免魔法字符串。
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const AFORouteKeyModelName;
FOUNDATION_EXPORT NSString * const AFORouteKeyCurrent;
FOUNDATION_EXPORT NSString * const AFORouteKeyNext;
FOUNDATION_EXPORT NSString * const AFORouteKeyAction;
FOUNDATION_EXPORT NSString * const AFORouteKeyValue;
FOUNDATION_EXPORT NSString * const AFORouteKeyTitle;
FOUNDATION_EXPORT NSString * const AFORouteKeyDirection;

/// 应用内页面跳转，行为与经 URL scheme 匹配 JLRoutes 后一致（见 `AFORouterManager`）。
void AFORoutingPerformWithParameters(NSDictionary *parameters);
