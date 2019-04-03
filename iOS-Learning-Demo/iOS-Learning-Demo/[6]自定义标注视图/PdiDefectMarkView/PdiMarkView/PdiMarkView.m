//
//  PdiMarkView.m
//  VehicleService
//
//  Created by yuan on 2019/4/3.
//  Copyright © 2019 xince. All rights reserved.
//

#import "PdiMarkView.h"
#import "UIView+Draggable.h"

@interface PdiMarkView(){
    PdiMarkModel *_markModel;
}

@property (nonatomic,strong) UILabel *countLabel;
@property (nonatomic,strong) UIButton *removeButton;

@end

@implementation PdiMarkView

- (instancetype)initWithPointModel:(PdiMarkModel *)model{
    if (self = [super init]) {
        _markModel = model;
        
        self.frame = CGRectMake(0, 0, 40, 40);
        [self addSubview:self.countLabel];
        [self addSubview:self.removeButton];
        [self setEditStatus:model.edit];
        
        self.center = model.point;
        
        self.draggingType = DraggingTypeNormal;
        self.draggingInBounds = YES;
    }
    return self;
}

#pragma mark - *********** tool ***********

- (void)setEditStatus:(BOOL)edit{
    self.layer.borderWidth = 1;
    if (edit) {
        self.layer.borderColor = UIColor.redColor.CGColor;
        self.removeButton.hidden = NO;
    }else{
        self.layer.borderColor = UIColor.clearColor.CGColor;
        self.removeButton.hidden = YES;
    }
}

- (void)setCountNum:(int)count{
    _markModel.title = [NSString stringWithFormat:@"%d",count];
    self.countLabel = nil;
    [self addSubview:self.countLabel];
}

- (void)removeMark{
    if (_removeBlock) {
        _removeBlock(_markModel);
    }
}

#pragma mark - *********** lazy ***********

- (UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = UILabel.new;
        _countLabel.text = _markModel.title;
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.backgroundColor = UIColor.greenColor;
        _countLabel.font = [UIFont systemFontOfSize:12];
        
        float w = self.width/2;
        _countLabel.frame = CGRectMake((self.width - w)/2, (self.height - w)/2, w, w);
        _countLabel.layer.cornerRadius = w/2;
        _countLabel.layer.masksToBounds = YES;
    }
    return _countLabel;
}

- (UIButton *)removeButton{
    if (!_removeButton) {
        _removeButton = UIButton.new;
        _removeButton.frame = CGRectMake(self.width - 10, 0, 10, 10);
        _removeButton.backgroundColor = UIColor.redColor;
        [_removeButton addTarget:self action:@selector(removeMark) forControlEvents:UIControlEventTouchUpInside];
    }
    return _removeButton;
}

@end
