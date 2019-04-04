//
//  UIAlertView+Block.m
//  VehicleService
//
//  Created by yuan on 2019/4/4.
//  Copyright © 2019 xince. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>

static void *alertViewBlockKey = "alertViewBlockKey";

@implementation UIAlertView (Block)

- (void)showWithBlock:(UIAlertViewBlock)alertViewBlock {
    if (alertViewBlock) {
        objc_removeAssociatedObjects(self);
        objc_setAssociatedObject(self, alertViewBlockKey, alertViewBlock, OBJC_ASSOCIATION_COPY);
        self.delegate = self;
    }
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIAlertViewBlock alertBlock = objc_getAssociatedObject(self, alertViewBlockKey);
    if (alertBlock) {
        alertBlock(alertView,buttonIndex);
    }
}

@end
