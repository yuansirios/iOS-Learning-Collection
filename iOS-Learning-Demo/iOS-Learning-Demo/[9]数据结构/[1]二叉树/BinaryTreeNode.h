//
//  BinaryTreeNode.h
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  二叉树节点
 */
@interface BinaryTreeNode : NSObject

/**
 *  值
 */
@property (nonatomic, assign) NSInteger value;
/**
 *  左节点
 */
@property (nonatomic, strong) BinaryTreeNode *leftNode;
/**
 *  右节点
 */
@property (nonatomic, strong) BinaryTreeNode *rightNode;

@end

NS_ASSUME_NONNULL_END
