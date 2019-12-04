//
//  AlgorithmViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/12/3.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "AlgorithmViewController.h"

#define TICK CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();

#define TOCK NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start);

@interface AlgorithmViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_itemList;
    NSMutableArray *sortArr;
}

@property (nonatomic,strong) UITableView *listTableView;

@end

@implementation AlgorithmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"常用算法";
    
    sortArr = @[].mutableCopy;
    for (int i = 0 ; i < 100 ; i ++){
        int randInt = [self getRandomNumber:0 to:1000];
        if (![sortArr containsObject:@(randInt)]) {
            [sortArr addObject:@(randInt)];
        }
    }
    
    _itemList = @[@{YSTitleKey:@"冒泡排序",YSEventKey:@"sort1"},
                  @{YSTitleKey:@"选择排序",YSEventKey:@"sort2"},
                  @{YSTitleKey:@"插入排序",YSEventKey:@"sort3"},
                  @{YSTitleKey:@"折半插入（二分法）",YSEventKey:@"sort4"},
                  @{YSTitleKey:@"希尔排序",YSEventKey:@"sort5"},
                  @{YSTitleKey:@"堆排序",YSEventKey:@"sort6"},
                  @{YSTitleKey:@"快速排序",YSEventKey:@"sort7"},
                  @{YSTitleKey:@"归并排序",YSEventKey:@"sort8"}
                ];
    
    
    [self.view addSubview:self.listTableView];
    [self layout];
}

#pragma mark - *********** Events ***********

- (void)sort1{
    TICK
    NSArray *arr = [self sortByMaoPao:sortArr desc:YES];
    NSLog(@"%@",arr);
    TOCK
}

- (void)sort2{
    TICK
    NSArray *arr = [self sortBySelect:sortArr desc:YES];
    NSLog(@"%@",arr);
    TOCK
}

- (void)sort3{
    TICK
    NSArray *arr = [self sortByInsert:sortArr desc:YES];
    NSLog(@"%@",arr);
    TOCK
}

- (void)sort4{
    TICK
    NSArray *arr = [self sortByHalf:sortArr desc:YES];
    NSLog(@"%@",arr);
    TOCK
}

- (void)sort5{
    TICK
    NSArray *arr = [self sortByShell:sortArr desc:YES];
    NSLog(@"%@",arr);
    TOCK
}

- (void)sort6{
    TICK
    NSArray *arr = [self sortByStack:sortArr desc:YES];
    NSLog(@"%@",arr);
    TOCK
}

- (void)sort7{
    TICK
    NSArray *arr = [self sortByQuite:sortArr desc:YES];
    NSLog(@"%@",arr);
    TOCK
}

- (void)sort8{
    TICK
    NSArray *arr = [self sortByMerge:sortArr desc:YES];
    NSLog(@"%@",arr);
    TOCK
}

#pragma mark - *********** 算法 ***********
/**
 //TODO:冒泡算法
 从大到小:4426.133037 ms
 从小到大:4434.162021 ms
 
 平均时间复杂度：O(n2)
 空间复杂度：O(1) (用于交换)
 稳定性：稳定
 */
- (NSArray *)sortByMaoPao:(NSArray *)arr desc:(BOOL)desc{
    NSMutableArray *origArr = [NSMutableArray arrayWithArray:arr];
    id temp;
    NSUInteger count = origArr.count;
    for (int i = 0; i < count; i++) {
        for (int j = 0; j < (count-1) - i; j++) {
            if (desc){
                if ([origArr[j+1] intValue] > [origArr[j] intValue]){
                    temp = origArr[j+1];
                    origArr[j+1] = origArr[j];
                    origArr[j] = temp;
                }
            }else{
                if ([origArr[j+1] intValue] < [origArr[j] intValue]){
                    temp = origArr[j];
                    origArr[j] = origArr[j+1];
                    origArr[j+1] = temp;
                }
            }
        }
    }
    return origArr.copy;
}

/**
 //TODO:直接选择排序
 从大到小:4389.441967 ms
 从小到大:4222.674012 ms
 
 时间复杂度：O(N^2)
 空间复杂度：O(1)
 稳定性：不稳定
 内部排序
 
 思想：第一次从 V[0]~V[n-1] 中选取最小值，与V[0]交换，第二次从 V[1]~V[n-1] 中选取最小值，与V[1]交换,...,第 i 次从 V[i-1]~V[n-1] 中选取最小值，与V[n-2]交换，总共通过 n-1 次，得到一个按从小到大的有序排列。
 */
- (NSArray *)sortBySelect:(NSArray *)arr desc:(BOOL)desc{
    NSMutableArray *origArr = [NSMutableArray arrayWithArray:arr];
    NSUInteger count = origArr.count;
    
    for (int i = 0; i < count - 1; i++) {
        for (int j = i + 1; j < count ; j++) {
            if (desc){
                if ([origArr[i] intValue] < [origArr[j] intValue]) {
                    id temp = origArr[j];
                    origArr[j] = origArr[i];
                    origArr[i] = temp;
                }
            }else{
                if ([origArr[i] intValue] > [origArr[j] intValue]) {
                    id temp = origArr[j];
                    origArr[j] = origArr[i];
                    origArr[i] = temp;
                }
            }
        }
    }
    
    return origArr.copy;
}

/**
 //TODO:直接插入排序
 从大到小:3537.160993 ms
 从小到大:3093.631983 ms
 
 时间复杂度O(n^2)
 控件复杂度O(1)
 稳定性： 稳定
 内部排序
 
 思想：当插入第i(i>=1)个元素时，前面的V[0],...,V[i-1]个元素已经有序。这时，将第i个元素和前i-1个元素V[i-1],...,V[0]依次比较，找到插入的位置即将V[i]插入，同时原来位置上的元素向后顺移。
 */
- (NSArray *)sortByInsert:(NSArray *)arr desc:(BOOL)desc{
    NSMutableArray *origArr = [NSMutableArray arrayWithArray:arr];
    NSUInteger count = origArr.count;
    
    for (int i = 0; i < count; i++) {
        for (int j = i; j > 0; j--) {
            if (desc){
                if ([origArr[j] intValue] > [origArr[j - 1] intValue]) {
                    [origArr exchangeObjectAtIndex:j withObjectAtIndex:j-1];
                }
            }else{
                if ([origArr[j] intValue] < [origArr[j - 1] intValue]) {
                    [origArr exchangeObjectAtIndex:j withObjectAtIndex:j-1];
                }
            }
        }
    }
    
    return origArr.copy;
}

/**
 //TODO:折半插入排序(二分法)
 从大到小:785.764933 ms
 从小到大:763.529897 ms
 
 时间复杂度：O(N^2)
 稳定性：稳定
 内部排序
 
 思想：当插入第 i (i >= 1)时，前面的V[0],...,V[i-1]等 i-1 个元素已经有序。这时，折半搜索第 i 个元素在前 i-1 个元素V[i-1],...V[0]中的插入位置，然后将V[i]插入，同时原来位置上的元素向后顺移。与直接插入排序不同的是，折半插入排序比直接插入排序明显减少了关键字之间的比较次数，但是移动次数是没有改变。所以，折半插入排序和插入排序的时间复杂度相同都是O（N^2），但其减少了比较次数，所以该算法仍然比直接插入排序好。折半插入排序是一种稳定的排序算法。实现如下：
 */
- (NSArray *)sortByHalf:(NSArray *)arr desc:(BOOL)desc{
    NSMutableArray *origArr = [NSMutableArray arrayWithArray:arr];
    NSUInteger count = origArr.count;
    
    for (NSInteger index = 0; index < count; index++) {
        NSInteger start, end, middle;
        start  = 0;
        end    = index - 1;
        middle = 0;
        NSInteger temp = [origArr[index] integerValue];
        while (start <= end) {
            middle = (start + end) / 2;
            
            if (desc) {
                if ([origArr[middle] integerValue] < temp) {
                    end = middle - 1;
                }else{
                    start = middle + 1;
                }
            }else{
                if ([origArr[middle] integerValue] > temp) {
                    end = middle - 1;
                }else{
                    start = middle + 1;
                }
            }
        }
        for (NSInteger j = index - 1; j > end; j--) {
            origArr[j+1] = origArr[j];
        }
        [origArr replaceObjectAtIndex:end+1 withObject:[NSNumber numberWithInteger:temp]];
    }
    
    return origArr.copy;
}

/**
 //TODO:希尔排序
 从大到小:5833.813071 ms
 从小到大:5741.113901 ms
 
 时间复杂度：O(n) ~ O(n^2)
 空间复杂度：O(1)
 稳定性：不稳定
 内部排序
 
 思想：假设待排序的元素共 N 个元素，首先取一个整数 i<n 作为间隔，将全部元素分为间隔为 i 的 i 个子序列并对每个子序列进行直接插入排序。然后缩小间隔 i ，重复上述操作，直至 i 缩小为1，此时所有的元素位于同一个序列且有序。由于刚开始时 i 较大， 每个子序列元素较少，排序速度较快。后期 i 变小，每个子序列元素较多，但大部分元素有序，所以排序速度仍然较快。一般 i 取 i/2。 希尔排序是一种不稳定的排序算法。实现如下
 */
- (NSArray *)sortByShell:(NSArray *)arr desc:(BOOL)desc{
    
    NSMutableArray *origArr = [NSMutableArray arrayWithArray:arr];
    NSUInteger count = origArr.count;
    
    for (int gap = (int)count / 2; gap > 0; gap /= 2){
        for (int i = gap; i < count; i++){
            for (int j = i - gap; j >= 0 ; j -= gap){
                if (desc) {
                    if ([origArr[j] intValue] < [origArr[j + gap] intValue]) {
                        [origArr exchangeObjectAtIndex:j withObjectAtIndex:(j + gap)];
                    }
                }else{
                    if ([origArr[j] intValue] > [origArr[j + gap] intValue]) {
                        [origArr exchangeObjectAtIndex:j withObjectAtIndex:(j + gap)];
                    }
                }
            }
        }
    }
    
    return origArr.copy;
}

/**
 //TODO:堆排序
 从大到小:37.944078 ms
 从小到大:47.698975 ms
 
 时间复杂度：O(n) ~ O(n^2)
 空间复杂度：O(1)
 稳定性：不稳定
 内部排序
 
 思想：堆排序是借助堆来实现的选择排序，思想同简单的选择排序，以下以大顶堆为例。注意：如果想升序排序就使用大顶堆，反之使用小顶堆。原因是堆顶元素需要交换到序列尾部
 */
- (NSArray *)sortByStack:(NSArray *)arr desc:(BOOL)desc{
    
    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:arr];
    
    /*
     从最后一个非叶子节点开始 自下而上进行调整堆
     */
    for (NSInteger i=(dataArr.count/2-1); i >= 0; --i) {
        dataArr = [self maxHeapAdjust:dataArr index:i length:dataArr.count desc:desc] ;
    }
    
    NSInteger num = dataArr.count;
    
    /*
     剩余的元素个数不为1时则继续调整，取出元素。取出的元素放在最后的一个节点。然后减小堆的元素的个数。所以大顶堆排序出来的是升序的。
     */
    while (num > 1) {
        [dataArr exchangeObjectAtIndex:0 withObjectAtIndex:num-1];
        dataArr=[self maxHeapAdjust:dataArr index:0 length:num-1 desc:desc];
        num--;
    }
    
    return dataArr.copy;
}

- (NSMutableArray*)maxHeapAdjust:(NSMutableArray *)array index:(NSInteger)index length:(NSInteger)length desc:(BOOL)desc{
    NSInteger leftChildIndex  = index*2+1;//获取该节点的左子节点索引
    NSInteger rightChildIndex = index*2+2;//获取该节点的右子节点索引
    NSInteger maxValueIndex = index;//暂时把该索引当做最大值所对应的索引
    
    // leftChildIndex < length
    // 判断左子节点的值是否大于当前最大值
    if (leftChildIndex < length) {
        if (desc) {
            if ([array[leftChildIndex] integerValue] < [array[maxValueIndex] integerValue]) {
                //把左子节点的索引作为最大值所对应的索引
                maxValueIndex = leftChildIndex;
            }
        }else{
            if ([array[leftChildIndex] integerValue] > [array[maxValueIndex] integerValue]) {
                //把左子节点的索引作为最大值所对应的索引
                maxValueIndex = leftChildIndex;
            }
        }
    }
    // rightChildIndex < length
    // 判断左子节点的值是否大于当前最大值
    if (rightChildIndex < length) {
        if (desc) {
            if ([array[rightChildIndex] integerValue] < [array[maxValueIndex] integerValue]) {
                maxValueIndex=rightChildIndex;
            }
        }else{
            if ([array[rightChildIndex] integerValue] > [array[maxValueIndex] integerValue]) {
                maxValueIndex=rightChildIndex;
            }
        }
    }
    
    //如果该节点不是最大值所在的节点 则将其和最大值节点进行交换
    if (maxValueIndex != index) {
        [array exchangeObjectAtIndex:maxValueIndex withObjectAtIndex:index];
        
        //递归乡下调整，此时maxValueIndex索引所对应的值是 刚才的父节点。
        array=[self maxHeapAdjust:array index:maxValueIndex length:length desc:desc];
    }
    
    return array;
}

/**
 //TODO:快速排序

 从大到小:11.417031 ms
 从小到大:12.031078 ms
 
 通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小(划分过程)，然后再按此方法对这两部分数据分别进行快速排序(快速排序过程)，整个排序过程可以递归进行，以此达到整个数据变成有序序列。快速排序是一种不稳定的排序算法
 */
- (NSArray *)sortByQuite:(NSArray *)arr desc:(BOOL)desc{
    
    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:arr];
    
    [self quickSortArray:dataArr withLeftIndex:0
           andRightIndex:dataArr.count-1
                    desc:desc];
    
    return dataArr.copy;
}

- (void)quickSortArray:(NSMutableArray *)array
         withLeftIndex:(NSInteger)leftIndex
         andRightIndex:(NSInteger)rightIndex
                  desc:(BOOL)desc{
    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
        return ;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    //记录比较基准数
    NSInteger key = [array[i] integerValue];
    
    if (desc) {
        while (i < j) {
            /**** 首先从右边j开始查找比基准数小的值 ***/
            while (i < j && [array[j] integerValue] <= key) {//如果比基准数大，继续查找
                j--;
            }
            //如果比基准数小，则将查找到的小值调换到i的位置
            array[i] = array[j];
            
            /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
            while (i < j && [array[i] integerValue] >= key) {//如果比基准数小，继续查找
                i++;
            }
            //如果比基准数大，则将查找到的大值调换到j的位置
            array[j] = array[i];
        }
    }else{
        while (i < j) {
            /**** 首先从右边j开始查找比基准数小的值 ***/
            while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
                j--;
            }
            //如果比基准数小，则将查找到的小值调换到i的位置
            array[i] = array[j];
            
            /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
            while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续查找
                i++;
            }
            //如果比基准数大，则将查找到的大值调换到j的位置
            array[j] = array[i];
        }
    }

    //将基准数放到正确位置
    array[i] = @(key);
    
    /**** 递归排序 ***/
    //排序基准数左边的
    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i - 1 desc:desc];
    //排序基准数右边的
    [self quickSortArray:array withLeftIndex:i + 1 andRightIndex:rightIndex desc:desc];
}

/**
 //TODO:归并排序
 
 从大到小:52.412987 ms ms
 从小到大:59.804082 ms
 
 思想：其中，”归”是指将原序列分成半子序列，分别对子序列进行递归排序；”并”是指将排好序的各子序列合并成原序列。归并排序算法是一个典型的递归算法，因此也是概念上最为简单的排序算法。与快速排序算法相比，归并排序算法不依赖于初始序列，并且是一种稳定的排序算法，但需要与原序列一样大小的辅助存储空间。
 
 */
- (NSArray *)sortByMerge:(NSArray *)arr desc:(BOOL)desc{
    
    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:arr];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    //将数组中的每一个元素放入一个数组中
    for (NSNumber *number in dataArr) {
        NSMutableArray *childArray = [NSMutableArray array];
        [childArray addObject:number];
        [tempArray addObject:childArray];
    }
    
    //对这个数组中的数组进行合并，直到合并完毕为止
    while (tempArray.count != 1) {
        NSUInteger i = 0;
        while (i < tempArray.count - 1) {
            tempArray[i] = [self mergeArray:tempArray[i] secondArray:tempArray[i+1] desc:desc];
            [tempArray removeObjectAtIndex:i+1];
            i += 1;
        }
    }
    
    return tempArray.copy;
}

// 归并排序中的“并”--合并：将两个有序数组进行合并
//
// - parameter firstList:  第一个有序数组
// - parameter secondList: 第二个有序数组
- (NSMutableArray *)mergeArray:(NSMutableArray *)firstArray
                   secondArray:(NSMutableArray *)secondArray
                          desc:(BOOL)desc{
    
    NSMutableArray *resultArray = [NSMutableArray array];
    NSUInteger firstIndex = 0;
    NSUInteger secondIndex = 0;
    while (firstIndex < firstArray.count && secondIndex < secondArray.count) {
        if (desc) {
            if ([firstArray[firstIndex] integerValue] > [secondArray[secondIndex] integerValue]) {
                [resultArray addObject:firstArray[firstIndex]];
                firstIndex += 1;
            }else {
                [resultArray addObject:secondArray[secondIndex]];
                secondIndex += 1;
            }
        }else{
            if ([firstArray[firstIndex] integerValue] < [secondArray[secondIndex] integerValue]) {
                [resultArray addObject:firstArray[firstIndex]];
                firstIndex += 1;
            }else {
                [resultArray addObject:secondArray[secondIndex]];
                secondIndex += 1;
            }
        }
    }
    while (firstIndex < firstArray.count) {
        [resultArray addObject:firstArray[firstIndex]];
        firstIndex += 1;
    }
    while (secondIndex < secondArray.count) {
        [resultArray addObject:secondArray[secondIndex]];
        secondIndex += 1;
    }
    return resultArray;
}

//TODO:随机数
- (int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % (to - from + 1)));
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
    cell.textLabel.text = [NSString stringWithFormat:@"[%zd] %@",indexPath.row,dic[YSTitleKey]];
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
