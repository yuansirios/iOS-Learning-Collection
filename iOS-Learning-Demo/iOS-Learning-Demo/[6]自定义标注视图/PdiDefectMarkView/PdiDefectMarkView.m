//
//  PdiDefectMarkView.m
//  VehicleService
//
//  Created by yuan on 2019/4/3.
//  Copyright © 2019 xince. All rights reserved.
//

#import "PdiDefectMarkView.h"
#import "PdiMarkView.h"
#import "PdiMarkModel.h"

@interface PdiDefectMarkView()

@property (nonatomic,strong) NSMutableDictionary *markViewDic;

@end

@implementation PdiDefectMarkView

- (instancetype)init{
    if (self = [super init]) {
        
        float viewPade = 20;
        float scaleValue = 259/333.;
        float viewW = SCREEN_WIDTH - viewPade*2;
        float viewH = viewW * scaleValue;
        
        self.frame = CGRectMake(viewPade, 0, viewW, viewH);
        
        UIImageView *bgImg = UIImageView.new;
        bgImg.image = [UIImage imageNamed:@"PDI"];
        bgImg.frame = self.bounds;
        bgImg.layer.borderColor = UIColor.grayColor.CGColor;
        bgImg.layer.borderWidth = 1;
        [self addSubview:bgImg];
    }
    return self;
}

/*
 判断一个点是否在这个rect区域中
 bool CGRectContainsPoint(CGRect rect,CGPoint point)
 
 判断一个rect是否在另一个rect中
 bool CGRectContainsRect(CGRect rect1, CGRect rect2)
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    NSLog(@"点击了：%@",NSStringFromCGPoint(point));
    
    //判断点击坐标是否在mark视图中
    BOOL isAdd = NO;
    
    NSMutableArray *activeArr = @[].mutableCopy;
    for (PdiMarkView *markView in [self.markViewDic allValues]){
        if (CGRectContainsPoint(markView.frame, point)) {
            [activeArr addObject:markView];
            isAdd = YES;
        }else{
            [markView setEditStatus:NO];
        }
    }
    
    //处理重复区域多个活动视图问题
    for (int i = 0 ; i < activeArr.count ;i++) {
        PdiMarkView *markView = activeArr[i];
        if (i == 0) {
            [markView setEditStatus:YES];
        }else{
            [markView setEditStatus:NO];
        }
    }
    
    //没有添加过，重新添加
    if (!isAdd) {
        PdiMarkModel *model = [self addMarkModel:point];
        
        NSString *key = model.title;
        
        if ([[self.markViewDic allKeys] containsObject:key]) {
            [self setActiveMark:key];
        }else{
            [self addMark:model];
        }
    }
}

- (PdiMarkModel *)addMarkModel:(CGPoint)point{
    PdiMarkModel *model = PdiMarkModel.new;
    model.point = point;
    model.title = [NSString stringWithFormat:@"%lu",self.markViewDic.count + 1];
    model.edit = YES;
    return model;
}

//设置当前活动标识，其他非活动
- (void)setActiveMark:(NSString *)key{
    PdiMarkView *current = [self.markViewDic valueForKey:key];
    for (PdiMarkView *item in [self.markViewDic allValues]) {
        if ([item isEqual:current]) {
            [item setEditStatus:YES];
        }else{
            [item setEditStatus:NO];
        }
    }
}

//TODO:添加mark
- (void)addMark:(PdiMarkModel *)model{
    @weakify(self)
    PdiMarkView *markView = [[PdiMarkView alloc]initWithPointModel:model];
    [markView setRemoveBlock:^(PdiMarkModel * _Nonnull model) {
        @strongify(self)
        [self removeMark:model];
    }];
    [self addSubview:markView];
    [self.markViewDic setObject:markView forKey:model.title];
    //设置其他非活跃
    [self setActiveMark:model.title];
}

//TODO:移除mark
- (void)removeMark:(PdiMarkModel *)model{
    //1、删除当前标记
    PdiMarkView *current = [self.markViewDic valueForKey:model.title];
    [current removeFromSuperview];
    [self.markViewDic removeObjectForKey:model.title];
    
    int currentCount = [model.title intValue];
    
    //需要重新排序
    NSArray *keyArr = [self.markViewDic allKeys];
    NSArray *resultArray = [keyArr sortedArrayUsingSelector:@selector(compare:)];
    
    //2、重新排序
    for (NSString *key in resultArray){
        int itemCount = [key intValue];
        if (itemCount > currentCount) {
            PdiMarkView *view = [self.markViewDic objectForKey:key];
            [view setCountNum:itemCount-1];
            
            //删除老数据
            [self.markViewDic removeObjectForKey:key];
            
            //设置新数据
            NSString *newKey = [NSString stringWithFormat:@"%d",itemCount-1];
            [self.markViewDic setObject:view forKey:newKey];
        }
    }
}

//字典排序
- (NSComparisonResult)compare:(NSDictionary *)otherDictionary{
    NSDictionary *tempDictionary = (NSDictionary *)self;
    NSNumber *number1 = [[tempDictionary allKeys] objectAtIndex:0];
    NSNumber *number2 = [[otherDictionary allKeys] objectAtIndex:0];
    NSComparisonResult result = [number1 compare:number2];
    return result == NSOrderedDescending;
}

- (UIImage *)screenShot{
    //取消活跃状态
    for (PdiMarkView *item in [self.markViewDic allValues]) {
        [item setEditStatus:NO];
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshotImage;
}

#pragma mark - *********** Lazy ***********

- (NSMutableDictionary *)markViewDic{
    if (!_markViewDic) {
        _markViewDic = @{}.mutableCopy;
    }
    return _markViewDic;
}

@end
