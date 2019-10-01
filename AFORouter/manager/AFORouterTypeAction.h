//
//  AFORouterTypeAction.h
//  AFORouter
//
//  Created by xianxueguang on 2019/10/1.
//  Copyright © 2019年 AFO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFORouterTypeAction.h"
NS_ASSUME_NONNULL_BEGIN
@interface AFORouterTypeAction : NSObject
- (void)currentController:(UIViewController *)current
           nextController:(UIViewController *)next;
@end

NS_ASSUME_NONNULL_END
