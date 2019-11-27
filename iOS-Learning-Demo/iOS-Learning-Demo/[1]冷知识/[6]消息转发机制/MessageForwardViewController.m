//
//  MessageForwardViewController.m
//  iOS-Learning-Demo
//
//  Created by yuan on 2019/11/27.
//  Copyright © 2019 yuan. All rights reserved.
//

#import "MessageForwardViewController.h"
//#import "NSObject+CrashHandle.h"

@interface NewMessageObj : NSObject

- (void)sendNewMessage:(NSString *)message;

@end

@implementation NewMessageObj

- (void)sendNewMessage:(NSString *)message{
    NSLog(@"NewMessageObj --- %@",message);
}

@end

@interface MessageObj : NSObject

- (void)sendMessage:(NSString *)message;
- (void)sendNewMessage:(NSString *)message;
- (void)sendTestMessage:(NSString *)message;
+ (void)sendClassMessage:(NSString *)message;
+ (void)classTestMessage:(NSString *)message;

@end

@implementation MessageObj

#pragma mark - *********** 消息转发机制 ***********

/**
 第一阶段
 动态方法解析，
 动态添加方法，解决当前未添加的方法编号
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSString *methodName = NSStringFromSelector(sel);
    if ([methodName isEqualToString:@"sendMessage:"]) {
        class_addMethod([self class], @selector(sendMessage:), (IMP)sendMsg, "v@:@");
        return YES;
    }
    return NO;
}

+ (BOOL)resolveClassMethod:(SEL)sel{
    NSString *methodName = NSStringFromSelector(sel);
    if ([methodName isEqualToString:@"sendClassMessage:"]) {
        // 获取 MetaClass
        Class metaClass = objc_getMetaClass([NSStringFromClass(self) UTF8String]);
        // 动态添加类方法
        class_addMethod(metaClass, sel, (IMP)sendMsg, "v@:@");
        return YES;
    }else{
        return NO;
    }
}

void sendMsg(id self, SEL _cmd,NSString *msg){
    NSLog(@"MessageObj == %@",msg);
}

/**
 第二阶段
 快速转发
 找到一个备用的接受者，处理当前接受的消息
 */
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSString *methodName = NSStringFromSelector(aSelector);
    if ([methodName isEqualToString:@"sendNewMessage:"]) {
        return [NewMessageObj new];
    }else{
        return [super forwardingTargetForSelector:aSelector];
    }
}

/**
 第三阶段
 慢速转发，丢漂流瓶，消息中转中心
 NSInvocation需要找更广的范围

 sel -- sendMessage:
 sign -- v@:@(IMP) 返回值\方法名\参数
 
 获取方法签名的方法
 [NSMethodSignature signatureWithObjCTypes:"v@:@"]
 [self methodSignatureForSelector:(SEL)];
 [NSObject instanceMethodSignatureForSelector:(SEL)];
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSString *methodName = NSStringFromSelector(aSelector);
    if ([methodName isEqualToString:@"sendNewMessage:"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }else{
        return [super methodSignatureForSelector:aSelector];
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL sel = anInvocation.selector;
    NewMessageObj *n = NewMessageObj.new;
    if ([n respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:n];
    }else{
        [super forwardInvocation:anInvocation];
    }
}

@end

#pragma mark - *********** MessageForwardViewController ***********

@interface MessageForwardViewController ()

@end

@implementation MessageForwardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息转发机制";
    
    UIButton *btn = [self createBtn:@"对象方法消息转发" sel:@selector(objForward)];
    btn.frame = CGRectMake(0, 80, 200, 40);
    [self.view addSubview:btn];
    
    UIButton *btn1 = [self createBtn:@"类方法消息转发" sel:@selector(classForward)];
    btn1.frame = CGRectMake(0, CGRectGetMaxY(btn.frame)+20, 200, 40);
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [self createBtn:@"消息转发防闪退" sel:@selector(crashHandle)];
    btn2.frame = CGRectMake(0, CGRectGetMaxY(btn1.frame)+20, 200, 40);
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [self createBtn:@"NSInvocation" sel:@selector(testInvocation)];
    btn3.frame = CGRectMake(0, CGRectGetMaxY(btn2.frame)+20, 200, 40);
    [self.view addSubview:btn3];
}

- (void)objForward{
    [MessageObj.new sendMessage:@"hello!!!"];
    [MessageObj.new sendNewMessage:@"hello!!!"];
}

- (void)classForward{
    [MessageObj sendClassMessage:@"hello!!!"];
}

- (void)crashHandle{
    [MessageObj.new sendTestMessage:@"hello!!"];
    [MessageObj classTestMessage:@"hello!!!"];
}

- (void)testInvocation{
    [MessageObj.new sendMessage:@"hello!!!"];
    MessageObj *m = MessageObj.new;
//    [m performSelector:@selector(sendMessage:) withObject:@"hello!!!2"];
    
    //NSInvocation
    SEL sel = @selector(sendMessage:);
    NSMethodSignature  *signature = [MessageObj instanceMethodSignatureForSelector:sel];
    //2、创建NSInvocation对象
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    //设置方法调用者
    invocation.target = m;
    //注意：这里的方法名一定要与方法签名类中的方法一致
    invocation.selector = sel;
    NSString *str = @"hello!!!3";
    //这里的Index要从2开始，以为0跟1已经被占据了，分别是self（target）,selector(_cmd)
    [invocation setArgument:&str atIndex:2];
    //3、调用invoke方法
    [invocation invoke];
}

- (UIButton *)createBtn:(NSString *)title sel:(SEL)selector{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.blueColor;
    return btn;
}

@end
