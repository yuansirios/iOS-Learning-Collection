//
//  SDTabelViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/2/26.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "SDTabelViewController.h"
#import "SDTabelViewCell.h"

@interface SDTabelViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_itemList;
}

@property (nonatomic,strong) UITableView *listTableView;

@end

@implementation SDTabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _itemList = @[@"发链接爱看的九分裤辣椒粉快乐撒减肥的快乐按实际付款了啥地方看了啥地方看了酒叟比如秋日哦啊ufioauweifuaw额发诶我日安慰无日晚锐欧片尾曲人皮欧千万我哦额如无穷二UI哦我去鄂锐二我埃尔文如你哦啊无二啊era",
                  @"乐撒减肥的快乐按实际付款了啥地方看了啥地方看了酒叟比如秋日哦啊ufioauweifuaw额发诶我日安慰无日晚锐欧片尾曲人皮欧千万我哦额如无穷二UI哦我去鄂锐二我埃尔文如你哦啊无二啊era乐撒减肥的快乐按实际付款了啥地方看了啥地方看了酒叟比如秋日哦啊ufioauweifuaw额发诶我日安慰无日晚锐欧片尾曲人皮欧千万我哦额如无穷二UI哦我去鄂锐二我埃尔文如你哦啊无二啊era乐撒减肥的快乐按实际付款了啥地方看了啥地方看了酒叟比如秋日哦啊ufioauweifuaw额发诶我日安慰无日晚锐欧片尾曲人皮欧千万我哦额如无穷二UI哦我去鄂锐二我埃尔文如你哦啊无二啊era",
                  @"乐撒减肥的快乐按实际付款了啥地方看了啥地方看了酒叟比如秋日哦啊ufioauweifuaw额发诶我日安慰无日晚锐欧片尾曲人皮欧千万我哦额如无穷二UI哦我去鄂锐二我埃尔文如你哦啊无二啊era乐撒减肥的快乐按实际付款了啥地方看了啥地方看了酒叟比如秋日哦啊ufioauweifuaw额发诶我日安慰无日晚锐欧片尾曲人皮欧千万我哦额如无穷二UI哦我去鄂锐二我埃尔文如你哦啊无二啊era乐撒减肥的快乐按实际付款了啥地方看了啥地方看了酒叟比如秋日哦啊ufioauweifuaw额发诶我日安慰无日晚锐欧片尾曲人皮欧千万我哦额如无穷二UI哦我去鄂锐二我埃尔文如你哦啊无二啊era乐撒减肥的快乐按实际付款了啥地方看了啥地方看了酒叟比如秋日哦啊ufioauweifuaw额发诶我日安慰无日晚锐欧片尾曲人皮欧千万我哦额如无穷二UI哦我去鄂锐二我埃尔文如你哦啊无二啊era",@"44444444",@"55555555555555555",@"66666666",@"乐撒减肥的快乐按实际付款了啥地方看了啥地方看了酒叟比如秋日哦啊ufioauweifuaw额发诶我日安慰无日晚锐欧片尾曲人皮欧千万我哦额如无穷二UI哦我去鄂锐二我埃尔文如你哦啊无二啊era乐撒减肥的快乐按实际付款了啥地方看了啥地方看了酒叟比如秋日哦啊ufioauweifuaw额发诶我日安慰无日晚锐欧片尾曲人皮欧千万我哦额如无穷二UI哦我去鄂锐二我埃尔文如你哦啊无二啊era",@"88888888888888888",@"999999999999999999",@"乐撒减肥的快乐按实际付款了啥地方看了啥地方看了酒叟比如秋日哦啊ufioauweifuaw额发诶我日安慰无日晚锐欧片尾曲人皮欧千万我哦额如无穷二UI哦我去鄂锐二我埃尔文如你哦啊无二啊era"];
    
    [self.view addSubview:self.listTableView];
    self.listTableView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}


#pragma mark - *********** delegate ***********

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _itemList.count;
}

 /* model 为模型实例， keyPath为 model的属性名，通过 kvc统一赋值接口 */
//keypath:比如你要显示的是str,str对应的model的属性是text

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.listTableView cellHeightForIndexPath:indexPath model:_itemList[indexPath.row] keyPath:@"title" cellClass:[SDTabelViewCell class] contentViewWidth:[self cellContentViewWith]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *string = @"cell";
    
    SDTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (cell == nil ) {
        cell = [[SDTabelViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    
    cell.title = _itemList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - *********** lazy ***********

- (UITableView *)listTableView{
    if (!_listTableView) {
        _listTableView = UITableView.new;
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.tableFooterView = UIView.new;
    }
    return _listTableView;
}

#pragma mark - *********** 旋转设置 ***********

- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

@end
