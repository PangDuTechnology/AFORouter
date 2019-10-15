//
//  AFOSchedulerBaseClass+AFORouter.h
//  AFORouter
//
//  Created by piccolo on 2019/10/13.
//  Copyright © 2019 AFO. All rights reserved.
//

#import <AFOSchedulerCore/AFOSchedulerBaseClass.h>
NS_ASSUME_NONNULL_BEGIN

@interface AFOSchedulerBaseClass (AFORouter)
+ (void)jumpPassingParameters:(NSDictionary *)parameters;
+ (void)jumpPassingParameters:(NSDictionary *)parameters
                        block:(void(^)(id target))block;
@end

NS_ASSUME_NONNULL_END
