//
//  StructureViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "StructureViewController.h"
//二叉树
#import "BinaryTree.h"
//链表
#import "ListNode.h"

@interface StructureViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_itemList;
}

@property (nonatomic,strong) UITableView *listTableView;

@end

@implementation StructureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"数据结构";
    _itemList = @[@{YSTitleKey:@"[1]二叉树",YSEventKey:@"testBinaryTree"},
                  @{YSTitleKey:@"[2]链表",YSEventKey:@"testListNode"}];
    [self.view addSubview:self.listTableView];
    [self layout];
}

#pragma mark - *********** delegate ***********

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSDictionary *dic = _itemList[indexPath.row];
    cell.textLabel.text = dic[YSTitleKey];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = _itemList[indexPath.row];
    SEL selector = NSSelectorFromString(dic[YSEventKey]);
    if ([self respondsToSelector:selector]) {
        SafePerformSelector([self performSelector:selector]);
    }
}

#pragma mark - *********** event ***********

- (void)testBinaryTree{
    //1、构建二叉树
    BinaryTreeNode *rootNode = [BinaryTree createTreeWithValues:@[@(1),@(2),@(3),@(4),@(5),@(6)]];
    
    BinaryTreeNode *firstNode = [BinaryTree treeNodeAtIndex:5 inTree:rootNode];
    [BinaryTree addTreeNode:firstNode value:4];
    [BinaryTree addTreeNode:firstNode value:3];
    [BinaryTree addTreeNode:firstNode value:6];
    
    //先序遍历
    [BinaryTree preOrderTraverseTree:rootNode handler:^(BinaryTreeNode * _Nonnull treeNode) {
        NSLog(@"先序遍历 ---> %@",@(treeNode.value));
    }];
    
    NSLog(@"/*************************/");
    
    //中序遍历
    [BinaryTree inOrderTraverseTree:rootNode handler:^(BinaryTreeNode * _Nonnull treeNode) {
        NSLog(@"中序遍历 ---> %@",@(treeNode.value));
    }];
    
    NSLog(@"/*************************/");
    
    //后序遍历
    [BinaryTree postOrderTraverseTree:rootNode handler:^(BinaryTreeNode * _Nonnull treeNode) {
        NSLog(@"后序遍历 ---> %@",@(treeNode.value));
    }];
    
    NSLog(@"/*************************/");
    
    //层次遍历（广度优先）
    [BinaryTree levelTraverseTree:rootNode handler:^(BinaryTreeNode * _Nonnull treeNode) {
        NSLog(@"层次遍历 ---> %@",@(treeNode.value));
    }];
    
    NSLog(@"/*************************/");
    
    //二叉树的深度
    NSLog(@"二叉树的深度 ---> %@",@([BinaryTree depthOfTree:rootNode]));
    
    //二叉树的宽度
    NSLog(@"二叉树的宽度 ---> %@",@([BinaryTree widthOfTree:rootNode]));
    
    //二叉树的所有节点数
    NSLog(@"二叉树的所有节点数 ---> %@",@([BinaryTree numberOfNodesInTree:rootNode]));
    
    //二叉树某层中的节点数
    NSLog(@"二叉树某层中的节点数 ---> %@",@([BinaryTree numberOfNodesOnLevel:6 inTree:rootNode]));
    
    //二叉树叶子节点数
    NSLog(@"二叉树叶子节点数 ---> %@",@([BinaryTree numberOfLeafsInTree:rootNode]));
    
    //二叉树最大距离（直径）
    NSLog(@"二叉树最大距离（直径） ---> %@",@([BinaryTree maxDistanceOfTree:rootNode]));
    NSLog(@"二叉树最大距离（直径） ---> %@",@([BinaryTree maxDistanceOfTree2:rootNode]));
}

- (void)testListNode{
    ListNode *node;
    node = [ListNode addNode:node andVlaue:@(1)];
    node = [ListNode addNode:node andVlaue:@(2)];
    node = [ListNode addNode:node andVlaue:@(5)];
    node = [ListNode addNode:node andVlaue:@(3)];
    node = [ListNode addNode:node andVlaue:@(4)];
    node = [ListNode addNode:node andVlaue:@(5)];
    
    NSArray *nodeArr = [ListNode getLinkList:node];
    [nodeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    
    node = [ListNode reverseList:node];
    nodeArr = [ListNode getLinkList:node];
    [nodeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"单链表逆置 ---> %@",obj);
    }];
}

#pragma mark - *********** layout ***********

- (void)layout{
    self.listTableView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
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

@end
