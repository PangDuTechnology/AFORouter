//
//  AFORouting.m
//  AFORouter
//

#import "AFORouting.h"
#import <AFOSchedulerCore/AFOSchedulerBaseClass+AFORouter.h>

NSString * const AFORouteKeyModelName = @"modelName";
NSString * const AFORouteKeyCurrent = @"current";
NSString * const AFORouteKeyNext = @"next";
NSString * const AFORouteKeyAction = @"action";
NSString * const AFORouteKeyValue = @"value";
NSString * const AFORouteKeyTitle = @"title";
NSString * const AFORouteKeyDirection = @"direction";

void AFORoutingPerformWithParameters(NSDictionary *parameters) {
    [AFOSchedulerBaseClass schedulerRouterJumpPassingParameters:parameters];
}
