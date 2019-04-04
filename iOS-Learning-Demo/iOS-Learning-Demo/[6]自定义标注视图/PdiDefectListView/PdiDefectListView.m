//
//  PdiDefectListView.m
//  VehicleService
//
//  Created by yuan on 2019/4/4.
//  Copyright © 2019 xince. All rights reserved.
//

#import "PdiDefectListView.h"
#import "UIGestureRecognizer+addtion.h"
#import "UIAlertView+Block.h"

@interface PdiDefectListView()

@end

@implementation PdiDefectListView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)loadWithModelArr:(NSArray <PdiMarkModel *> *)modelArr{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat topPade = 0;
    CGFloat pade = 10;
    
    for (PdiMarkModel *model in modelArr){
        
        UIView *cellView = UIView.new;
        cellView.backgroundColor = UIColor.whiteColor;
        cellView.frame = CGRectMake(0, topPade, self.width, 0);
        
        UILabel *countLabel = UILabel.new;
        countLabel.text = model.title;
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.backgroundColor = UIColor.greenColor;
        countLabel.font = [UIFont systemFontOfSize:12];
        countLabel.frame = CGRectMake(pade, pade, 20, 20);
        countLabel.layer.cornerRadius = countLabel.height/2;
        countLabel.layer.masksToBounds = YES;
        [cellView addSubview:countLabel];
        
        UILabel *contentLabel = UILabel.new;
        contentLabel.font = [UIFont systemFontOfSize:12];
        contentLabel.text = model.content;
        contentLabel.numberOfLines = 0;
        
        CGFloat contentLeft = countLabel.right + pade;
        contentLabel.frame = CGRectMake(contentLeft, countLabel.top, cellView.width - contentLeft, 0);
        [contentLabel sizeToFit];
        
        [cellView addSubview:contentLabel];
        
        //获取行数，显示优化
        CGFloat labelHeight = [contentLabel sizeThatFits:CGSizeMake(contentLabel.width, MAXFLOAT)].height;
        NSInteger count = (labelHeight) / contentLabel.font.lineHeight;
        if (count == 1){
            countLabel.centerY = contentLabel.centerY;
        }
        
        cellView.height = contentLabel.bottom + pade;
        
        [self addSubview:cellView];
        
        topPade = cellView.bottom;
        
        //点击手势
        @weakify(self)
        [cellView addGestureRecognizer:({
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
                @strongify(self)
                [self editContentInfo:model];
            }];
            tap;
        })];
    }
    
    self.height = topPade;
}

- (void)editContentInfo:(PdiMarkModel *)model{
    @weakify(self)
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"请输入缺陷原因" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alertView textFieldAtIndex:0];
    textField.text = model.content;
    [alertView showWithBlock:^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1){
            @strongify(self)
            UITextField *textField = [alertView textFieldAtIndex:0];
            if (textField.text.length == 0) {
                showAlertWithTitle(@"请输入原因");
            }else if([textField.text isEqualToString:model.content]){
                NSLog(@"内容没有发生改变");
            }else{
                model.content = textField.text;
                if (self.editBlock) {
                    self.editBlock(model);
                }
            }
        }
    }];
}

@end
