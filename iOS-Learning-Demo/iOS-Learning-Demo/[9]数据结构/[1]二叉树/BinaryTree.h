//
//  BinaryTree.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinaryTreeNode.h"
#import "TreeNodeProperty.h"

NS_ASSUME_NONNULL_BEGIN

@interface BinaryTree : NSObject

/**
 *  //TODO:创建二叉排序树
 *  二叉排序树：左节点值全部小于根节点值，右节点值全部大于根节点值
 *
 *  @param values 数组
 *
 *  @return 二叉树根节点
 */
+ (BinaryTreeNode *)createTreeWithValues:(NSArray *)values;

/**
 *  //TODO:向二叉排序树节点添加一个节点
 *
 *  @param treeNode 根节点
 *  @param value    值
 *
 *  @return 根节点
 */
+ (BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode value:(NSInteger)value;

/**
 *  //TODO:二叉树中某个位置的节点（按层次遍历）
 *
 *  @param index    按层次遍历树时的位置(从0开始算)
 *  @param rootNode 树根节点
 *
 *  @return 节点
 */
+ (BinaryTreeNode *)treeNodeAtIndex:(NSInteger)index inTree:(BinaryTreeNode *)rootNode ;

/**
 *  //TODO:先序遍历
 *  先访问根，再遍历左子树，再遍历右子树
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)preOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler;

/**
 *  //TODO:中序遍历
 *  先遍历左子树，再访问根，再遍历右子树
 *  对于二叉排序树来说，中序遍历得到的序列是一个从小到大排序好的序列
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)inOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler;

/**
 *  //TODO:后序遍历
 *  先遍历左子树，再遍历右子树，再访问根
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)postOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler;

/**
 *  //TODO:层次遍历（广度优先）
 *  按照从上到下、从左到右的次序进行遍历。
 先遍历完一层，再遍历下一层，因此又叫广度优先遍历。
 需要用到队列，在OC里可以用可变数组来实现。
 
 *  @param rootNode 二叉树根节点
 *  @param handler  访问节点处理函数
 */
+ (void)levelTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler;

/**
 *  //TODO:二叉树的深度
 *
 *  @param rootNode 二叉树根节点
 *
 *  @return 二叉树的深度
 */
+ (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode;

/**
 *  //TODO:二叉树的宽度
 *  二叉树的宽度定义为各层节点数的最大值。
 
 *  @param rootNode 二叉树根节点
 *
 *  @return 二叉树宽度
 */
+ (NSInteger)widthOfTree:(BinaryTreeNode *)rootNode;

/**
 *  //TODO:二叉树的所有节点数
 *  递归思想：二叉树所有节点数=左子树节点数+右子树节点数+1
 
 *  @param rootNode 根节点
 *
 *  @return 所有节点数
 */
+ (NSInteger)numberOfNodesInTree:(BinaryTreeNode *)rootNode;

/**
 *  //TODO:二叉树某层中的节点数
 *
 *  @param level    层
 *  @param rootNode 根节点
 *
 *  @return 层中的节点数
 */
+ (NSInteger)numberOfNodesOnLevel:(NSInteger)level inTree:(BinaryTreeNode *)rootNode;

/**
 *  //TODO:二叉树叶子节点数
 *  叶子节点，又叫终端节点，是左右子树都是空的节点。
 *  @param rootNode 根节点
 *
 *  @return 叶子节点数
 */
+ (NSInteger)numberOfLeafsInTree:(BinaryTreeNode *)rootNode;

/**
 *  //TODO:二叉树最大距离（直径）
 *
 *  @param rootNode 根节点
 *
 *  @return 最大距离
 */
+ (NSInteger)maxDistanceOfTree:(BinaryTreeNode *)rootNode;
+ (NSInteger)maxDistanceOfTree2:(BinaryTreeNode *)rootNode;

/**
 *  //TODO:计算树节点的最大深度和最大距离
 *
 *  @param rootNode 根节点
 *
 *  @return TreeNodeProperty
 */
+ (TreeNodeProperty *)propertyOfTreeNode:(BinaryTreeNode *)rootNode;

/**
 *  //TODO:二叉树中某个节点到根节点的路径
 *
 *  @param treeNode 节点
 *  @param rootNode 根节点
 *
 *  @return 存放路径节点的数组
 */
+ (NSArray *)pathOfTreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode;

/**
 *  //TODO:查找某个节点是否在树中
 *
 *  @param treeNode 待查找的节点
 *  @param rootNode 根节点
 *  @param path  根节点到待查找节点的路径
 *
 *  @return YES：找到，NO：未找到
 */
+ (BOOL)isFoundTreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode routePath:(NSMutableArray *)path;

/**
 *  //TODO:二叉树中两个节点最近的公共父节点
 *
 *  @param nodeA    第一个节点
 *  @param nodeB    第二个节点
 *  @param rootNode 二叉树根节点
 *
 *  @return 最近的公共父节点
 */
+ (BinaryTreeNode *)parentOfNode:(BinaryTreeNode *)nodeA andNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode;

/**
 *  //TODO:二叉树中两个节点之间的路径
 *
 *  @param nodeA    第一个节点
 *  @param nodeB    第二个节点
 *  @param rootNode 二叉树根节点
 *
 *  @return 两个节点间的路径
 */
+ (NSArray *)pathFromNode:(BinaryTreeNode *)nodeA toNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode;

/**
 *  //TODO:二叉树两个节点之间的距离
 *
 *  @param nodeA    第一个节点
 *  @param nodeB    第二个节点
 *  @param rootNode 二叉树根节点
 *
 *  @return 两个节点间的距离（-1：表示没有找到路径）
 */
+ (NSInteger)distanceFromNode:(BinaryTreeNode *)nodeA toNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode;

/**
 *  //TODO:翻转二叉树（又叫：二叉树的镜像）
 *
 *  @param rootNode 根节点
 *
 *  @return 翻转后的树根节点（其实就是原二叉树的根节点）
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode;

/**
 *  //TODO:是否完全二叉树
 *  完全二叉树：若设二叉树的高度为h，除第h层外，其它各层的结点数都达到最大个数，第h层有叶子结点，并且叶子结点都是从左到右依次排布
 *
 *  @param rootNode 根节点
 *
 *  @return YES：是完全二叉树，NO：不是完全二叉树
 */
+ (BOOL)isCompleteBinaryTree:(BinaryTreeNode *)rootNode;

/**
 *  //TODO:是否满二叉树
 *  满二叉树：除了叶结点外每一个结点都有左右子叶且叶子结点都处在最底层的二叉树
 *  满二叉树的一个特性是：叶子数=2^(深度-1)，因此我们可以根据这个特性来判断二叉树是否是满二叉树。
 *  @param rootNode 根节点
 *
 *  @return YES：满二叉树，NO：非满二叉树
 */
+ (BOOL)isFullBinaryTree:(BinaryTreeNode *)rootNode;

/**
 *  //TODO:是否平衡二叉树
 *  平衡二叉树：即AVL树，它是一棵空树或它的左右两个子树的高度差的绝对值不超过1，并且左右两个子树都是一棵平衡二叉树
 *
 *  @param rootNode 根节点
 *
 *  @return YES：平衡二叉树，NO：非平衡二叉树
 */
+ (BOOL)isAVLBinaryTree:(BinaryTreeNode *)rootNode;

@end

NS_ASSUME_NONNULL_END
