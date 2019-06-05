//
//  BinaryTree.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/6/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "BinaryTree.h"

@implementation BinaryTree

#pragma mark - *********** 创建二叉排序树 ***********

/**
 *  创建二叉排序树
 *  二叉排序树：左节点值全部小于根节点值，右节点值全部大于根节点值
 *
 *  @param values 数组
 *
 *  @return 二叉树根节点
 */
+ (BinaryTreeNode *)createTreeWithValues:(NSArray *)values {
    
    BinaryTreeNode *root = nil;
    for (NSInteger i=0; i<values.count; i++) {
        NSInteger value = [(NSNumber *)[values objectAtIndex:i] integerValue];
        root = [BinaryTree addTreeNode:root value:value];
    }
    return root;
}

#pragma mark - *********** 向二叉排序树节点添加一个节点 ***********
/**
 *  向二叉排序树节点添加一个节点
 *
 *  @param treeNode 根节点
 *  @param value    值
 *
 *  @return 根节点
 */
+ (BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode value:(NSInteger)value {
    //根节点不存在，创建节点
    if (!treeNode) {
        treeNode = [BinaryTreeNode new];
        treeNode.value = value;
//        NSLog(@"node:%@", @(value));
    }
    else if (value <= treeNode.value) {
//        NSLog(@"to left");
        //值小于根节点，则插入到左子树
        treeNode.leftNode = [BinaryTree addTreeNode:treeNode.leftNode value:value];
    }
    else {
//        NSLog(@"to right");
        //值大于根节点，则插入到右子树
        treeNode.rightNode = [BinaryTree addTreeNode:treeNode.rightNode value:value];
    }
    
    return treeNode;
}

#pragma mark - *********** 二叉树中某个位置的节点（按层次遍历） ***********

/**
 *  二叉树中某个位置的节点（按层次遍历）
 *
 *  @param index    按层次遍历树时的位置(从0开始算)
 *  @param rootNode 树根节点
 *
 *  @return 节点
 */
+ (BinaryTreeNode *)treeNodeAtIndex:(NSInteger)index inTree:(BinaryTreeNode *)rootNode {
    //按层次遍历
    if (!rootNode || index < 0) {
        return nil;
    }
    
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode]; //压入根节点
    while (queueArray.count > 0) {
        
        BinaryTreeNode *node = [queueArray firstObject];
        if (index == 0) {
            return node;
        }
        [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
        index--; //移除节点，index减少
        
        if (node.leftNode) {
            [queueArray addObject:node.leftNode]; //压入左节点
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode]; //压入右节点
        }
    }
    //层次遍历完，仍然没有找到位置，返回nil
    return nil;
}

#pragma mark - *********** 先序遍历 ***********
/**
 *  先序遍历
 *  先访问根，再遍历左子树，再遍历右子树
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 
 NSMutableArray *orderArray = [NSMutableArray array];
 [BinaryTree preOrderTraverseTree:root handler:^(BinaryTreeNode *treeNode) {
 [orderArray addObject:@(treeNode.value)];
 }];
 NSLog(@"先序遍历结果：%@", [orderArray componentsJoinedByString:@","]);
 
 */
+ (void)preOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler {
    if (rootNode) {
        
        if (handler) {
            handler(rootNode);
        }
        
        [self preOrderTraverseTree:rootNode.leftNode handler:handler];
        [self preOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}

#pragma mark - *********** 中序遍历 ***********
/**
 *  中序遍历
 *  先遍历左子树，再访问根，再遍历右子树
 *  对于二叉排序树来说，中序遍历得到的序列是一个从小到大排序好的序列
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)inOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler {
    if (rootNode) {
        [self inOrderTraverseTree:rootNode.leftNode handler:handler];
        
        if (handler) {
            handler(rootNode);
        }
        
        [self inOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}

#pragma mark - *********** 后序遍历 ***********
/**
 *  后序遍历
 *  先遍历左子树，再遍历右子树，再访问根
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)postOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler {
    if (rootNode) {
        [self postOrderTraverseTree:rootNode.leftNode handler:handler];
        [self postOrderTraverseTree:rootNode.rightNode handler:handler];
        
        if (handler) {
            handler(rootNode);
        }
    }
}

#pragma mark - *********** 层次遍历（广度优先） ***********
/**
 *  层次遍历（广度优先）
 *  按照从上到下、从左到右的次序进行遍历。
    先遍历完一层，再遍历下一层，因此又叫广度优先遍历。
    需要用到队列，在OC里可以用可变数组来实现。
 
 *  @param rootNode 二叉树根节点
 *  @param handler  访问节点处理函数
 */
+ (void)levelTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler {
    if (!rootNode) {
        return;
    }
    
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode]; //压入根节点
    while (queueArray.count > 0) {
        
        BinaryTreeNode *node = [queueArray firstObject];
        
        if (handler) {
            handler(node);
        }
        
        [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
        if (node.leftNode) {
            [queueArray addObject:node.leftNode]; //压入左节点
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode]; //压入右节点
        }
    }
}

#pragma mark - *********** 二叉树的深度 ***********
/**
 *  二叉树的深度
 *
 二叉树的深度定义为：从根节点到叶子结点依次经过的结点形成树的一条路径,最长路径的长度为树的深度。
 
 1）如果根节点为空，则深度为0；
 
 2）如果左右节点都是空，则深度为1；
 
 3）递归思想：二叉树的深度=max（左子树的深度，右子树的深度）+ 1
 
 *  @param rootNode 二叉树根节点
 *
 *  @return 二叉树的深度
 */
+ (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }
    
    //左子树深度
    NSInteger leftDepth = [self depthOfTree:rootNode.leftNode];
    //右子树深度
    NSInteger rightDepth = [self depthOfTree:rootNode.rightNode];
    
    return MAX(leftDepth, rightDepth) + 1;
}

#pragma mark - *********** 二叉树的宽度 ***********
/**
 *  二叉树的宽度
 *  二叉树的宽度定义为各层节点数的最大值。
 
 *  @param rootNode 二叉树根节点
 *
 *  @return 二叉树宽度
 */
+ (NSInteger)widthOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode]; //压入根节点
    NSInteger maxWidth = 1; //最大的宽度，初始化为1（因为已经有根节点）
    NSInteger curWidth = 0; //当前层的宽度
    
    while (queueArray.count > 0) {
        
        curWidth = queueArray.count;
        //依次弹出当前层的节点
        for (NSInteger i=0; i<curWidth; i++) {
            BinaryTreeNode *node = [queueArray firstObject];
            [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
            //压入子节点
            if (node.leftNode) {
                [queueArray addObject:node.leftNode];
            }
            if (node.rightNode) {
                [queueArray addObject:node.rightNode];
            }
        }
        //宽度 = 当前层节点数
        maxWidth = MAX(maxWidth, queueArray.count);
    }
    
    return maxWidth;
}

#pragma mark - *********** 二叉树的所有节点数 ***********
/**
 *  二叉树的所有节点数
 *  递归思想：二叉树所有节点数=左子树节点数+右子树节点数+1
 
 *  @param rootNode 根节点
 *
 *  @return 所有节点数
 */
+ (NSInteger)numberOfNodesInTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    //节点数=左子树节点数+右子树节点数+1（根节点）
    return [self numberOfNodesInTree:rootNode.leftNode] + [self numberOfNodesInTree:rootNode.rightNode] + 1;
}

#pragma mark - *********** 二叉树某层中的节点数 ***********
/**
 *  二叉树某层中的节点数
 *
 1）根节点为空，则节点数为0；
 
 2）层为1，则节点数为1（即根节点）
 
 3）递归思想：二叉树第k层节点数=左子树第k-1层节点数+右子树第k-1层节点数
 
 *  @param level    层
 *  @param rootNode 根节点
 *
 *  @return 层中的节点数
 */
+ (NSInteger)numberOfNodesOnLevel:(NSInteger)level inTree:(BinaryTreeNode *)rootNode {
    if (!rootNode || level < 1) { //根节点不存在或者level<0
        return 0;
    }
    if (level == 1) { //level=1，返回1（根节点）
        return 1;
    }
    //递归：level层节点数 = 左子树level-1层节点数+右子树level-1层节点数
    return [self numberOfNodesOnLevel:level-1 inTree:rootNode.leftNode] + [self numberOfNodesOnLevel:level-1 inTree:rootNode.rightNode];
}

#pragma mark - *********** 二叉树叶子节点数 ***********
/**
 *  二叉树叶子节点数
 *  叶子节点，又叫终端节点，是左右子树都是空的节点。
 *  @param rootNode 根节点
 *
 *  @return 叶子节点数
 */
+ (NSInteger)numberOfLeafsInTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    //左子树和右子树都是空，说明是叶子节点
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }
    //递归：叶子数 = 左子树叶子数 + 右子树叶子数
    return [self numberOfLeafsInTree:rootNode.leftNode] + [self numberOfLeafsInTree:rootNode.rightNode];
}

#pragma mark - *********** 二叉树最大距离（直径） ***********
/*
 二叉树中任意两个节点都有且仅有一条路径，这个路径的长度叫这两个节点的距离。二叉树中所有节点之间的距离的最大值就是二叉树的直径。
 
 有一种解法，把这个最大距离划分了3种情况：
 
 1）这2个节点分别在根节点的左子树和右子树上，他们之间的路径肯定经过根节点，而且他们肯定是根节点左右子树上最远的叶子节点（他们到根节点的距离=左右子树的深度）。
 
 2）这2个节点都在左子树上
 
 3）这2个节点都在右子树上
 
 综上，只要取这3种情况中的最大值，就是二叉树的直径。
 */

/**
 *  二叉树最大距离（直径）
 *  
 *  @param rootNode 根节点
 *
 *  @return 最大距离
 */
+ (NSInteger)maxDistanceOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    //    方案一：（递归次数较多，效率较低）
    //分3种情况：
    //1、最远距离经过根节点：距离 = 左子树深度 + 右子树深度
    NSInteger distance = [self depthOfTree:rootNode.leftNode] + [self depthOfTree:rootNode.rightNode];
    //2、最远距离在根节点左子树上，即计算左子树最远距离
    NSInteger disLeft = [self maxDistanceOfTree:rootNode.leftNode];
    //3、最远距离在根节点右子树上，即计算右子树最远距离
    NSInteger disRight = [self maxDistanceOfTree:rootNode.rightNode];
    
    return MAX(MAX(disLeft, disRight), distance);
}

//这个方案效率较低，因为计算子树的深度和最远距离是分开递归的，存在重复递归遍历的情况。其实一次递归，就可以分别计算出深度和最远距离，于是有了第二种方案：

/**
 *  二叉树最大距离（直径）
 *
 *  @param rootNode 根节点
 *
 *  @return 最大距离
 */
+ (NSInteger)maxDistanceOfTree2:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    //    方案2：将计算节点深度和最大距离放到一次递归中计算，方案一是分别单独递归计算深度和最远距离
    TreeNodeProperty *p = [self propertyOfTreeNode:rootNode];
    return p.distance;
}

#pragma mark - *********** 计算树节点的最大深度和最大距离 ***********
/**
 *  计算树节点的最大深度和最大距离
 *
 *  @param rootNode 根节点
 *
 *  @return TreeNodeProperty
 */
+ (TreeNodeProperty *)propertyOfTreeNode:(BinaryTreeNode *)rootNode {
    
    if (!rootNode) {
        return nil;
    }
    
    TreeNodeProperty *left = [self propertyOfTreeNode:rootNode.leftNode];
    TreeNodeProperty *right = [self propertyOfTreeNode:rootNode.rightNode];
    TreeNodeProperty *p = [TreeNodeProperty new];
    //节点的深度depth = 左子树深度、右子树深度中最大值+1（+1是因为根节点占了1个depth）
    p.depth = MAX(left.depth, right.depth) + 1;
    //最远距离 = 左子树最远距离、右子树最远距离和横跨左右子树最远距离中最大值
    p.distance = MAX(MAX(left.distance, right.distance), left.depth+right.depth);
    
    return p;
}

#pragma mark - ***********  二叉树中某个节点到根节点的路径 ***********
/*
 既是寻路问题，又是查找节点问题。
 
 定义一个存放路径的栈（不是队列了，但是还是用可变数组来实现的）
 
 1）压入根节点，再从左子树中查找（递归进行的），如果未找到，再从右子树中查找，如果也未找到，则弹出根节点，再遍历栈中上一个节点。
 
 2）如果找到，则栈中存放的节点就是路径所经过的节点。
 */

/**
 *  二叉树中某个节点到根节点的路径
 *
 *  @param treeNode 节点
 *  @param rootNode 根节点
 *
 *  @return 存放路径节点的数组
 */
+ (NSArray *)pathOfTreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode {
    NSMutableArray *pathArray = [NSMutableArray array];
    [self isFoundTreeNode:treeNode inTree:rootNode routePath:pathArray];
    return pathArray;
}

#pragma mark - *********** 查找某个节点是否在树中 ***********
/**
 *  查找某个节点是否在树中
 *
 *  @param treeNode 待查找的节点
 *  @param rootNode 根节点
 *  @param path  根节点到待查找节点的路径
 *
 *  @return YES：找到，NO：未找到
 */
+ (BOOL)isFoundTreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode routePath:(NSMutableArray *)path {
    
    if (!rootNode || !treeNode) {
        return NO;
    }
    
    //找到节点
    if (rootNode == treeNode) {
        [path addObject:rootNode];
        return YES;
    }
    //压入根节点，进行递归
    [path addObject:rootNode];
    //先从左子树中查找
    BOOL find = [self isFoundTreeNode:treeNode inTree:rootNode.leftNode routePath:path];
    //未找到，再从右子树查找
    if (!find) {
        find = [self isFoundTreeNode:treeNode inTree:rootNode.rightNode routePath:path];
    }
    //如果2边都没查找到，则弹出此根节点
    if (!find) {
        [path removeLastObject];
    }
    
    return find;
}

#pragma mark - *********** 二叉树中两个节点最近的公共父节点 ***********

/*
 首先需要明白，根节点肯定是二叉树中任意两个节点的公共父节点（不一定是最近的），因此二叉树中2个节点的最近公共父节点一定在从根节点到这个节点的路径上。
 因此我们可以先分别找到从根节点到这2个节点的路径，再从这两个路径中找到最近的公共父节点。
 */

/**
 *  二叉树中两个节点最近的公共父节点
 *
 *  @param nodeA    第一个节点
 *  @param nodeB    第二个节点
 *  @param rootNode 二叉树根节点
 *
 *  @return 最近的公共父节点
 */
+ (BinaryTreeNode *)parentOfNode:(BinaryTreeNode *)nodeA andNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode {
    if (!rootNode || !nodeA || !nodeB) {
        return nil;
    }
    if (nodeA == nodeB) {
        return nodeA;
    }
    //从根节点到节点A的路径
    NSArray *pathA = [self pathOfTreeNode:nodeA inTree:rootNode];
    //从根节点到节点B的路径
    NSArray *pathB = [self pathOfTreeNode:nodeB inTree:rootNode];
    //其中一个节点不在树中，则没有公共父节点
    if (pathA.count == 0 || pathB == 0) {
        return nil;
    }
    //从后往前推，查找第一个出现的公共节点
    for (NSInteger i = pathA.count-1; i>=0; i--) {
        for (NSInteger j = pathB.count - 1; j>=0; j--) {
            if ([pathA objectAtIndex:i] == [pathB objectAtIndex:j]) {
                //找到
                return [pathA objectAtIndex:i];
            }
        }
    }
    return nil;
}

#pragma mark - *********** 二叉树中两个节点之间的路径 ***********
/**
 *  二叉树中两个节点之间的路径
 *
 *  @param nodeA    第一个节点
 *  @param nodeB    第二个节点
 *  @param rootNode 二叉树根节点
 *
 *  @return 两个节点间的路径
 */
+ (NSArray *)pathFromNode:(BinaryTreeNode *)nodeA toNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode {
    if (!rootNode || !nodeA || !nodeB) {
        return nil;
    }
    NSMutableArray *path = [NSMutableArray array];
    if (nodeA == nodeB) {
        [path addObject:nodeA];
        [path addObject:nodeB];
        return path;
    }
    //从根节点到节点A的路径
    NSArray *pathA = [self pathOfTreeNode:nodeA inTree:rootNode];
    //从根节点到节点B的路径
    NSArray *pathB = [self pathOfTreeNode:nodeB inTree:rootNode];
    //其中一个节点不在树中，则没有路径
    if (pathA.count == 0 || pathB == 0) {
        return nil;
    }
    //从后往前推，查找第一个出现的公共节点
    for (NSInteger i = pathA.count-1; i>=0; i--) {
        [path addObject:[pathA objectAtIndex:i]];
        for (NSInteger j = pathB.count - 1; j>=0; j--) {
            //找到公共父节点，则将pathB中后面的节点压入path
            if ([pathA objectAtIndex:i] == [pathB objectAtIndex:j]) {
                j++; //j++是为了避开公共父节点
                while (j<pathB.count) {
                    [path addObject:[pathB objectAtIndex:j]];
                    j++;
                }
                
                return path;
            }
        }
    }
    return nil;
}

#pragma mark - *********** 二叉树两个节点之间的距离 ***********

/**
 *  二叉树两个节点之间的距离
 *
 *  @param nodeA    第一个节点
 *  @param nodeB    第二个节点
 *  @param rootNode 二叉树根节点
 *
 *  @return 两个节点间的距离（-1：表示没有找到路径）
 */
+ (NSInteger)distanceFromNode:(BinaryTreeNode *)nodeA toNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode {
    if (!rootNode || !nodeA || !nodeB) {
        return -1;
    }
    if (nodeA == nodeB) {
        return 0;
    }
    //从根节点到节点A的路径
    NSArray *pathA = [self pathOfTreeNode:nodeA inTree:rootNode];
    //从根节点到节点B的路径
    NSArray *pathB = [self pathOfTreeNode:nodeB inTree:rootNode];
    //其中一个节点不在树中，则没有路径
    if (pathA.count == 0 || pathB == 0) {
        return -1;
    }
    //从后往前推，查找第一个出现的公共节点
    for (NSInteger i = pathA.count-1; i>=0; i--) {
        for (NSInteger j = pathB.count - 1; j>=0; j--) {
            //找到公共父节点
            if ([pathA objectAtIndex:i] == [pathB objectAtIndex:j]) {
                //距离=路径节点数-1 （这里要-2，因为公共父节点重复了一次）
                return (pathA.count - i) + (pathB.count - j) - 2;
            }
        }
    }
    return -1;
}

#pragma mark - *********** 翻转二叉树 ***********
/**
 *  翻转二叉树（又叫：二叉树的镜像）
 *
 *  @param rootNode 根节点
 *
 *  @return 翻转后的树根节点（其实就是原二叉树的根节点）
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return nil;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return rootNode;
    }
    
    [self invertBinaryTree:rootNode.leftNode];
    [self invertBinaryTree:rootNode.rightNode];
    
    BinaryTreeNode *tempNode = rootNode.leftNode;
    rootNode.leftNode = rootNode.rightNode;
    rootNode.rightNode = tempNode;
    
    return rootNode;
}

#pragma mark - *********** 判断二叉树是否完全二叉树 ***********
/*
 完全二叉树定义为：若设二叉树的高度为h，除第h层外，其它各层的结点数都达到最大个数，第h层有叶子结点，并且叶子结点都是从左到右依次排布。
 
 完全二叉树必须满足2个条件：
 
 1）如果某个节点的右子树不为空，则它的左子树必须不为空
 
 2）如果某个节点的右子树为空，则排在它后面的节点必须没有孩子节点
 
 这里还需要理解“排在它后面的节点”，回头看看层次遍历算法，我们就能知道在层次遍历时，是从上到下从左到右遍历的，先将根节点弹出队列，再压入孩子节点，因此“排在它后面的节点”有2种情况：
 
 1）同层次的后面的节点
 
 2）同层次的前面的节点的孩子节点（因为遍历前面的节点时，会弹出节点，同时将孩子节点压入队列）
 
 通过上面的分析，我们可以设置一个标志位flag，当子树满足完全二叉树时，设置flag=YES。当flag=YES而节点又破坏了完全二叉树的条件，那么它就不是完全二叉树。
 */
/**
 *  是否完全二叉树
 *  完全二叉树：若设二叉树的高度为h，除第h层外，其它各层的结点数都达到最大个数，第h层有叶子结点，并且叶子结点都是从左到右依次排布
 *
 *  @param rootNode 根节点
 *
 *  @return YES：是完全二叉树，NO：不是完全二叉树
 */
+ (BOOL)isCompleteBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return NO;
    }
    //左子树和右子树都是空，则是完全二叉树
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return YES;
    }
    //左子树是空，右子树不是空，则不是完全二叉树
    if (!rootNode.leftNode && rootNode.rightNode) {
        return NO;
    }
    
    //按层次遍历节点，找到满足完全二叉树的条件：
    //条件1：如果某个节点的右子树不为空，则它的左子树必须不为空
    //条件2：如果某个节点的右子树为空，则排在它后面的节点必须没有孩子节点
    //排在该节点后面的节点有2种：1）同层次的后面的节点 2）同层次的前面的节点的孩子节点（因为遍历前面的节点的时候，会将节点从队列里pop，同时把它的孩子节点push到队列里）
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:rootNode];
    BOOL isComplete = NO; //是否已经满足完全二叉树
    while (queue.count > 0) {
        BinaryTreeNode *node = [queue firstObject];
        [queue removeObjectAtIndex:0];
        
        //左子树为空且右子树不为空，则不是完全二叉树
        if (!node.leftNode && node.rightNode) {
            return NO;
        }
        if (isComplete && (node.leftNode || node.rightNode)) {
            //前面的节点已满足完全二叉树,如果还有孩子节点，则不是完全二叉树
            return NO;
        }
        
        //右子树为空，则已经满足完全二叉树
        if (!node.rightNode) {
            isComplete = YES;
        }
        
        //压入
        if (node.leftNode) {
            [queue addObject:node.leftNode];
        }
        if (node.rightNode) {
            [queue addObject:node.rightNode];
        }
    }
    return isComplete;
}

#pragma mark - *********** 是否满二叉树 ***********
/**
 *  是否满二叉树
 *  满二叉树：除了叶结点外每一个结点都有左右子叶且叶子结点都处在最底层的二叉树
 *  满二叉树的一个特性是：叶子数=2^(深度-1)，因此我们可以根据这个特性来判断二叉树是否是满二叉树。
 *  @param rootNode 根节点
 *
 *  @return YES：满二叉树，NO：非满二叉树
 */
+ (BOOL)isFullBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return NO;
    }
    
    //二叉树深度
    NSInteger depth = [self depthOfTree:rootNode];
    //二叉树叶子节点数
    NSInteger leafNum = [self numberOfLeafsInTree:rootNode];
    
    //满二叉树特性：叶子数=2^(深度-1)
    if (leafNum == pow(2, (depth - 1))) {
        return YES;
    }
    return NO;
}

#pragma mark - *********** 是否平衡二叉树 ***********
/**
 *  是否平衡二叉树
 *  平衡二叉树：即AVL树，它是一棵空树或它的左右两个子树的高度差的绝对值不超过1，并且左右两个子树都是一棵平衡二叉树
 *
 *  @param rootNode 根节点
 *
 *  @return YES：平衡二叉树，NO：非平衡二叉树
 */
+ (BOOL)isAVLBinaryTree:(BinaryTreeNode *)rootNode {
    static NSInteger height;
    if (!rootNode) {
        height = 0;
        return YES;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        height = 1;
        return YES;
    }
    
    BOOL isAVLLeft = [self isAVLBinaryTree:rootNode.leftNode];
    NSInteger heightLeft = height;
    BOOL isAVLRight = [self isAVLBinaryTree:rootNode.rightNode];
    NSInteger heightRight = height;
    
    height = MAX(heightLeft, heightRight)+1;
    
    if (isAVLLeft && isAVLRight && ABS(heightLeft-heightRight) <= 1) {
        return YES;
    }
    return NO;
}

@end
