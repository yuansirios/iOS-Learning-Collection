//
//  A.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/9/10.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "A.h"

@interface A()

@property (nonatomic,strong) NSMutableString  *strongStr;

@property (nonatomic,copy  ) NSMutableString  *copyssStr;

@end

@implementation A

- (void)show{
    NSLog(@"%@",NSStringFromClass(super.class));
}

- (void)testCopy{
    NSMutableString *string = [NSMutableString stringWithFormat:@"测试文字"];
    self.strongStr = string;
    self.copyssStr = string;

    //输出内存地址
    //前者是字符串内存首地址
    //后者是指针内存首地址
    NSLog(@"测试文字   String: %p, %p", string, &string);
    NSLog(@"Strong属性 String: %p, %p",_strongStr, &_strongStr);
    NSLog(@"Copy  属性 String: %p, %p",_copyssStr, &_copyssStr);
    
    /*
     NSString
     测试文字    String: 0x60000186c940, 0x7ffeeeb74a88
     Strong属性 String: 0x60000186c940, 0x60000186cbe8
     Copy  属性 String: 0x60000186c940, 0x60000186cbf0
     
     NSMutableString
     测试文字   String: 0x600003bfd410, 0x7ffeef8e6a88
     Strong属性 String: 0x600003bfd410, 0x6000035c5e68
     Copy  属性 String: 0x6000035c63e0, 0x6000035c5e70
     
     1) 当原字符串是NSString时，字符串是不可变的，不管是Strong还是Copy属性的对象，都是指向原对象，Copy操作只是做了次浅拷贝。
     2) 当原字符串是NSMutableString时，Strong属性只是增加了原字符串的引用计数，而Copy属性则是对原字符串做了次深拷贝，产生一个新的对象，且Copy属性对象指向这个新的对象,且这个Copy属性对象的类型始终是NSString，而不是NSMutableString，因此其是不可变的。
     3) 这里还有一个性能问题，即在原字符串是NSMutableString，Strong是单纯的增加对象的引用计数，而Copy操作是执行了一次深拷贝，所以性能上会有所差异(虽然不大)。如果原字符串是NSString时，则没有这个问题。
     所以，在声明NSString属性时，到底是选择strong还是copy，可以根据实际情况来定。不过，一般我们将对象声明为NSString时，都不希望它改变，所以大多数情况下，我们建议用copy，以免因可变字符串的修改导致的一些非预期问题。
     
     */
}

@end
