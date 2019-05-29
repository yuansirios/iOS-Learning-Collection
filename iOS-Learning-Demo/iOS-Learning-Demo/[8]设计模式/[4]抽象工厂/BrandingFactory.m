//
//  BrandingFactory.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/5/29.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "BrandingFactory.h"

#import "AcmeBrandingFactory.h"
#import "SierraBrandingFactory.h"

@implementation BrandingFactory

+ (BrandingFactory *)factory {
    
    if ([[self class] isSubclassOfClass:[AcmeBrandingFactory class]]) {
        
        return [AcmeBrandingFactory new];
        
    } else if ([[self class] isSubclassOfClass:[SierraBrandingFactory class]]) {
        
        return [SierraBrandingFactory new];
        
    } else {
        
        return nil;
    }
}

- (UIView *)brandedView {
    
    return nil;
}

- (UIButton *)brandedMainButton {
    
    return nil;
}

@end
