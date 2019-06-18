//
//  YSMarkView.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/14.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSMarkView.h"
#import "NSString+addtion.h"

@implementation YSMarkView

- (void)loadItems:(NSArray <NSString *>*)itemArr{
    
    UIView *lastItem;
    CGFloat padding = 12;
    CGFloat itemTop = 0;
    for (NSString *title in itemArr){
        
        UIFont *font = [UIFont systemFontOfSize:14];
        CGFloat itemW = [title ys_widthForFont:font] + 30;
        
        CGFloat itemLeft = lastItem.right + padding;
        if (itemLeft + itemW > self.width) {
            itemLeft = padding;
            itemTop = lastItem.bottom + padding;
        }
        
        UIButton *btn = UIButton.new;
        btn.frame = CGRectMake(itemLeft, itemTop, itemW, 40);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn.titleLabel setFont:font];
        [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        btn.backgroundColor = UIColorRandom;
        
        //图片设置
        btn.adjustsImageWhenHighlighted = NO;
        [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        UIImage *icon = createImageWithColor(UIColorRandom, 20, 20);
        [btn setImage:icon forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
        
        lastItem = btn;
        [self addSubview:btn];
    }
    
    self.height = lastItem.bottom;
    
}

@end
