//
//  AFORouterActionContext.h
//  AFORouter
//
//  Created by xianxueguang on 2019/10/1.
//  Copyright © 2019年 AFO. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface AFORouterActionContext : NSObject
- (instancetype)initAction:(NSString *)strAction;
- (void)viewControllerAction;
@end

NS_ASSUME_NONNULL_END
