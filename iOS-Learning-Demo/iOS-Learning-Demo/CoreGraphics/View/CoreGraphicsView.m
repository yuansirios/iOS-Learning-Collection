//
//  CoreGraphicsView.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/3/12.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "CoreGraphicsView.h"

@interface CoreGraphicsView()

@property (nonatomic,assign) CGPoint singleTouchPoint;

@end

@implementation CoreGraphicsView

//TODO:基本操作
- (void)drawRect:(CGRect)rect {
    
    [self drawChart:rect];
    
    return;
    //TODO:画一条线
    {
        //设置画布
        CGContextRef context = UIGraphicsGetCurrentContext();
        //设置线宽
        CGContextSetLineWidth(context, 1);
        //设置线的起始点
        CGContextMoveToPoint(context, 10, 20);
        //设置线的终点，形成一条绘制路径
        CGContextAddLineToPoint(context, 100, 100);
        //设置画笔的颜色
        CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
        //使用画笔画线
        CGContextStrokePath(context);
    }
    
    //TODO:画一个矩形
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        // 设置边框线宽
        CGContextSetLineWidth(context, 2);
        // 添加一个矩形路径
        CGContextAddRect(context, CGRectMake(100, 100, 50, 50));
        // 设置画笔颜色
        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
        // 绘制路径
        CGContextStrokePath(context);
    }
    
    //TODO:画一个圆弧或者圆
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        // 给定圆周率π
        CGFloat pi = 3.141592653f;
        // 添加一个圆
        /*
        CGContextAddArc(绘图上下文,圆心的X坐标,圆心的Y坐标,圆的半径,圆弧的起始弧度,圆弧的结束弧度,指定按照顺时针方向，1为顺时针，0为逆时针)
         */
        CGContextAddArc(context, 100, 100, 50, 0, pi/2, 0);
        // 设置画笔颜色
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        // 绘制圆弧
        CGContextStrokePath(context);
    }
    
    //TODO:画一个 1/4圆的扇形
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        // 给定圆周率π
        CGFloat pi = 3.141592653f;
        // 起始点移动到圆心
        CGContextMoveToPoint(context, 200, 100);
        // 添加一个圆
        CGContextAddArc(context, 200, 100, 50, 0, pi/2, 0);
        // 设置画笔颜色
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        // 闭合路径，让起点和终点连接起来
        CGContextClosePath(context);
        // 绘制圆弧
        CGContextStrokePath(context);
    }
    
    //TODO:填充指定区域
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        // 给定圆周率π
        CGFloat pi = 3.141592653f;
        // 起始点移动到圆心
        CGContextMoveToPoint(context, 300, 100);
        // 添加一个圆
        CGContextAddArc(context, 300, 100, 50, 0, pi/2, 0);
        // 设置填充颜色
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        // 填充
        CGContextFillPath(context);
    }
    
    //TODO:绘制文字
    {
        // 设置字体
        UIFont *textFont= [UIFont systemFontOfSize:15];
        // 设置属性
        NSDictionary *attrs = @{NSFontAttributeName:textFont,
                                NSForegroundColorAttributeName:[UIColor blackColor]};
        // 文字的绘制区域
        CGRect textRect = CGRectMake(20, 200, 100, 100);
        // 绘制文字
        [@"Hello World!" drawInRect:textRect withAttributes:attrs];
    }
}

//TODO:绘制图表
static CGFloat axisMarginBottom = 15;
static CGFloat axisMarginLeft = 15;
static CGFloat axisMarginRight = 3;
static CGFloat axisMarginTop = 3;

- (void)drawChart:(CGRect)rect{
    //绘制背景
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetLineWidth(context, 2);
    
    CGContextMoveToPoint(context, 0.0f, 0.0f);
    CGContextAddRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokePath(context);
    
    /********** 绘制X轴线 **********/
    // 重新设置X轴线宽
    CGContextSetLineWidth(context, 1);
    // 设置绘制X轴的起始点
    CGContextMoveToPoint(context, 0.0f, rect.size.height - axisMarginBottom);
    // 添加绘制X轴线的路径
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height - axisMarginBottom);
    // 设置画笔颜色
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    // 绘制路径
    CGContextStrokePath(context);
    
    /********** 绘制Y轴线 **********/
    CGContextMoveToPoint(context, axisMarginLeft, 0.0f);
    CGContextAddLineToPoint(context, axisMarginLeft, rect.size.height);
    CGContextStrokePath(context);
    
    [self drawLongitudeLines:rect];
    [self drawLatitudeLines:rect];
    
    [self drawXAxisTitles:rect];
    [self drawYAxisTitles:rect];
    
    [self drawCrossLines:rect];
}

//TODO:绘制经线（纵向刻度线、虚线）
- (void)drawLongitudeLines:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    
    if ([self.longitudeTitles count] <= 0) {
        return;
    }
    
    //设置线条为虚线
    CGFloat lengths[] = {3.0, 2.0};
    CGContextSetLineDash(context, 0.0, lengths, 2);
    
    CGFloat postOffset;
    CGFloat offset;
    
    postOffset = (rect.size.width - axisMarginLeft - axisMarginRight) / (self.longitudeTitles.count - 1);
    offset = axisMarginLeft;
    
    for (int i = 1; i < self.longitudeTitles.count ; i++) {
        CGContextMoveToPoint(context, offset + i * postOffset, 0);
        CGContextAddLineToPoint(context, offset + i * postOffset, rect.size.height - axisMarginBottom);
    }
    
    CGContextStrokePath(context);
    CGContextSetLineDash(context, 0, nil, 0);
}

//TODO:绘制纬线（横向刻度线、虚线）
- (void)drawLatitudeLines:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    
    if ([self.latitudeTitles count] <= 0){
        return ;
    }
    //设置线条为虚线
    CGFloat lengths[] = {3.0, 3.0}; // 线宽和间距，长短相间可以画两条虚线，然后拼接在一起
    CGContextSetLineDash(context, 0.0, lengths, 2);
    
    CGFloat postOffset; // 纬线之间的间距
    postOffset = (rect.size.height - axisMarginBottom - axisMarginTop) * 1.0 / ([self.latitudeTitles count] - 1);
    
    CGFloat offset = rect.size.height - axisMarginBottom;
    
    for (int i = 1; i < [self.latitudeTitles count]; i++) {
        CGContextMoveToPoint(context, 0, offset - i * postOffset);
        CGContextAddLineToPoint(context, rect.size.width , offset - i * postOffset);
    }
    CGContextStrokePath(context);
    //还原线条
    CGContextSetLineDash(context, 0, nil, 0);
}

//TODO:绘制X轴刻度
- (void)drawXAxisTitles:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5f);
    
    if ([self.longitudeTitles count] <= 0) {
        return;
    }
    
    CGFloat postOffset;
    CGFloat offset;
    
    postOffset = (rect.size.width - axisMarginLeft - axisMarginRight) / (self.longitudeTitles.count - 1);
    offset = axisMarginLeft;
    
    for (int i = 0; i < [self.longitudeTitles count]; i++) {
        
        // 绘制线条
        NSString *valueStr = (NSString *) [self.longitudeTitles objectAtIndex:i];
        UIFont *textFont= [UIFont systemFontOfSize:12]; //设置字体
        NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSDictionary *attrs = @{NSFontAttributeName:textFont,
                                NSParagraphStyleAttributeName:textStyle,
                                NSForegroundColorAttributeName:[UIColor blackColor]};
        CGSize textSize = [valueStr boundingRectWithSize:CGSizeMake(100, 100)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attrs
                                                 context:nil].size;
        
        // 调整X轴坐标位置
        // 第一个刻度的位置要绘制在Y轴线右侧
        if (i == 0) {
            CGRect textRect= CGRectMake(axisMarginLeft, rect.size.height - axisMarginBottom, textSize.width, textSize.height);
            textStyle.alignment=NSTextAlignmentLeft;
            // 绘制字体
            [valueStr drawInRect:textRect withAttributes:attrs];
            
        }
        // 最后一个刻度的位置要绘制在最后一条经线的左侧
        else if (i == self.longitudeTitles.count-1) {
            CGRect textRect= CGRectMake(rect.size.width - axisMarginRight - textSize.width, rect.size.height - axisMarginBottom, textSize.width, textSize.height);
            textStyle.alignment=NSTextAlignmentRight;
            // 绘制字体
            [valueStr drawInRect:textRect withAttributes:attrs];
        } else {
            CGRect textRect= CGRectMake(offset + (i-0.5) * postOffset, rect.size.height - axisMarginBottom, postOffset, textSize.height);
            textStyle.alignment=NSTextAlignmentCenter;
            // 绘制字体
            [valueStr drawInRect:textRect withAttributes:attrs];
        }
    }
}

//TODO:绘制Y轴刻度
- (void)drawYAxisTitles:(CGRect)rect {
    if ([self.latitudeTitles count] <= 0) {
        return;
    }
    
    CGFloat postOffset;
    postOffset = (rect.size.height - axisMarginBottom - axisMarginTop) * 1.0 / ([self.latitudeTitles count] - 1);
    
    CGFloat offset = rect.size.height - axisMarginBottom;
    
    for (int i = 0; i < [self.latitudeTitles count]; i++) {
        // 左侧
        // 绘制线条
        NSString *valueStr = (NSString *) [self.latitudeTitles objectAtIndex:i];
        UIFont *textFont= [UIFont systemFontOfSize:12]; //设置字体
        NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSDictionary *attrs = @{NSFontAttributeName:textFont,
                                NSParagraphStyleAttributeName:textStyle,
                                NSForegroundColorAttributeName:[UIColor blackColor]};
        CGSize textSize = [valueStr boundingRectWithSize:CGSizeMake(100, 100)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attrs
                                                 context:nil].size;
        /*
         显示左边
         */
        textStyle.alignment=NSTextAlignmentLeft;
        //调整Y轴坐标位置
        if (i == [self.latitudeTitles count] - 1) {
            CGRect textRect= CGRectMake(axisMarginLeft, offset - i * postOffset, textSize.width, textSize.height);
            //绘制字体
            [valueStr drawInRect:textRect withAttributes:attrs];
        } else {
            CGRect textRect= CGRectMake(axisMarginLeft, offset - i * postOffset - textSize.height - 1, textSize.width, textSize.height);
            //绘制字体
            [valueStr drawInRect:textRect withAttributes:attrs];
        }
    }
}

//TODO:绘制十字交叉线
- (void)drawCrossLines:(CGRect)rect {
    
    //过滤非显示区域的点
    if (self.singleTouchPoint.x < axisMarginLeft ||
        self.singleTouchPoint.y < axisMarginTop ||
        self.singleTouchPoint.x > rect.size.width - axisMarginRight ||
        self.singleTouchPoint.y > rect.size.height - axisMarginBottom) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    
    //设置线条为虚线
    CGFloat lengths[] = {2.0, 2.0};
    CGContextSetLineDash(context, 0.0, lengths, 1);
    
    
    // 绘制纵向刻度文字
    NSString *valueStr = [self calcAxisXGraduate:rect];
    if (![valueStr isEqualToString:@""]) {
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        
        //绘制纵线
        //还原半透明
        CGContextSetAlpha(context, 1);
        // 移动初始点
        CGContextMoveToPoint(context, self.singleTouchPoint.x, 0);
        // 添加line
        CGContextAddLineToPoint(context, self.singleTouchPoint.x, rect.size.height - axisMarginBottom);
        //绘制线条
        CGContextStrokePath(context);
        
        // 绘制字体
        UIFont *textFont= [UIFont systemFontOfSize:12]; //设置字体
        NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        textStyle.alignment=NSTextAlignmentCenter;
        
        NSDictionary *attrs = @{NSFontAttributeName:textFont,
                                NSParagraphStyleAttributeName:textStyle,
                                NSForegroundColorAttributeName:[UIColor whiteColor]};
        CGSize textSize = [valueStr boundingRectWithSize:CGSizeMake(100, 100)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attrs
                                                 context:nil].size;
        CGRect boxRect = CGRectMake(self.singleTouchPoint.x - textSize.width / 2.0, 1, textSize.width, textSize.height);
        
        CGContextAddRect(context,boxRect);
        CGContextFillPath(context);
        
        [valueStr drawInRect:boxRect withAttributes:attrs];
    }
    
    // 绘制横向刻度文字
    NSString *valueStr2 = [self calcAxisYGraduate:rect];
    if (![valueStr2 isEqualToString:@""]) {
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        
        //绘制横线
        //还原半透明
        CGContextSetAlpha(context, 1);
        
        CGContextMoveToPoint(context, 0, self.singleTouchPoint.y);
        CGContextAddLineToPoint(context, rect.size.width, self.singleTouchPoint.y);
        
        //绘制线条
        CGContextStrokePath(context);
        
        // 绘制字体
        UIFont *textFont2= [UIFont systemFontOfSize:12]; //设置字体
        NSMutableParagraphStyle *textStyle2 = [[NSMutableParagraphStyle alloc] init];//段落样式
        textStyle2.lineBreakMode = NSLineBreakByWordWrapping;
        textStyle2.alignment=NSTextAlignmentLeft;
        
        NSDictionary *attrs2 = @{NSFontAttributeName:textFont2,
                                 NSParagraphStyleAttributeName:textStyle2,
                                 NSForegroundColorAttributeName:[UIColor whiteColor]};
        CGSize textSize2 = [valueStr2 boundingRectWithSize:CGSizeMake(100, 100)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:attrs2
                                                   context:nil].size;
        CGRect boxRect2 = CGRectMake(1, self.singleTouchPoint.y - textSize2.height / 2.0, textSize2.width, textSize2.height);
        
        CGContextAddRect(context,boxRect2);
        CGContextFillPath(context);
        
        [valueStr2 drawInRect:boxRect2 withAttributes:attrs2];
    }
    
    CGContextSetLineDash(context, 0, nil, 0);
}

// 获取十字交叉线的X轴刻度
- (NSString *)calcAxisXGraduate:(CGRect)rect {
    return [NSString stringWithFormat:@"%f", [self touchPointAxisXValue:rect]];
}

// 获取十字交叉线的Y轴刻度
- (NSString *)calcAxisYGraduate:(CGRect)rect {
    return [NSString stringWithFormat:@"%f", [self touchPointAxisYValue:rect]];
}

// 计算触摸点X坐标值占坐标系宽度比例
- (CGFloat)touchPointAxisXValue:(CGRect)rect {
    CGFloat length = rect.size.width - axisMarginLeft - axisMarginRight;
    CGFloat valueLength = self.singleTouchPoint.x - axisMarginLeft ;
    return valueLength / length;
}

// 计算触摸点Y坐标值占坐标系高度比例
- (CGFloat)touchPointAxisYValue:(CGRect)rect {
    CGFloat length = rect.size.height - axisMarginBottom - axisMarginTop;
    CGFloat valueLength = length - (self.singleTouchPoint.y - axisMarginTop);
    
    return valueLength / length;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSArray *allTouches = [touches allObjects];
    //处理点击事件
    if ([allTouches count] == 1) {
        //获取选中点
        self.singleTouchPoint = [[allTouches objectAtIndex:0] locationInView:self];
        //重绘
        [self setNeedsDisplay];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSArray *allTouches = [touches allObjects];
    //处理点击事件
    if ([allTouches count] == 1) {
        //获取选中点
        self.singleTouchPoint = [[allTouches objectAtIndex:0] locationInView:self];
        //重绘
        [self setNeedsDisplay];
    }
}

@end
