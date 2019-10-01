//
//  AFORouterActionDelegate.h
//  AFORouter
//
//  Created by xianxueguang on 2019/10/1.
//  Copyright © 2019年 AFO. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AFORouterActionDelegate <NSObject>
- (void)currentController:(UIViewController *)current
           nextController:(UIViewController *)next;
@end

NS_ASSUME_NONNULL_END
