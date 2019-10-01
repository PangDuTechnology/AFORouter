//
//  AFORouterTypeAction.h
//  AFORouter
//
//  Created by xianxueguang on 2019/10/1.
//  Copyright © 2019年 AFO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFORouterTypeAction.h"
#import "AFORouterActionDelegate.h"
NS_ASSUME_NONNULL_BEGIN
@interface AFORouterTypeAction : NSObject
@property (nonatomic, weak) id<AFORouterActionDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
