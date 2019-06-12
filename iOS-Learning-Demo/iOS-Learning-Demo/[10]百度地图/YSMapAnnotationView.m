//
//  YSMapAnnotationView.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/10.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "YSMapAnnotationView.h"

@interface YSMapAnnotationView(){
    UILabel *_countLabel;
}

@end

@implementation YSMapAnnotationView

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 18, 24);
        UIImageView *img = [[UIImageView alloc] initWithFrame:self.frame];
        img.image = [UIImage imageNamed:@"Annotation"];
        [self addSubview:img];
        
        UILabel *label = UILabel.new;
        label.frame = CGRectMake(0, 0, 18, 18);
        label.font = [UIFont systemFontOfSize:12.f];
        label.textColor = UIColor.whiteColor;
        label.textAlignment = NSTextAlignmentCenter;
        [img addSubview:label];
        _countLabel = label;
    }
    return self;
}

- (void)setCount:(NSInteger)count{
    _countLabel.text = [NSString stringWithFormat:@"%@",@(count)];
}

@end
