//
//  NSObject+CustomKVO.m
//  KVO
//
//  Created by lzwk_lanlin on 2021/3/15.
//

#import "NSObject+CustomKVO.h"
#import <objc/message.h>

@implementation NSObject (CustomKVO)

- (void)ll_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context

{
    ///1.动态创建一个子类
    //获取对象名
    NSString * oldName = NSStringFromClass([self class]);
    //生成新的类名
    NSString * newName = [NSString stringWithFormat:@"CustomKVO_%@",oldName];
    //分配空间,创建类(仅在 创建之后,注册之前 能够添加成员变量)
    Class customClass = objc_allocateClassPair([self class], newName.UTF8String,0);
    //注册类(注册后方可使用该类创建对象)
    objc_registerClassPair(customClass);
    
    ///2.修改对象的isa指针
    object_setClass(self, customClass);
    
    ///3.重写对象的set方法
    NSString * methodName = [NSString stringWithFormat:@"set%@:",keyPath.capitalizedString];//capitalizedString:首字母大写
    SEL sel = NSSelectorFromString(methodName);
    class_addMethod(customClass, sel, (IMP)setterMethod, "v@:@");
    
    ///关联对象
    objc_setAssociatedObject(self, (__bridge  const void *)@"ObserverKey", observer, OBJC_ASSOCIATION_ASSIGN);
}

void setterMethod(id self, SEL _cmd, NSString * name){
    id observer = objc_getAssociatedObject(self, (__bridge  const void *)@"ObserverKey");
    NSString *methodName = NSStringFromSelector(_cmd);
    NSString *getterName = getValueKey(methodName);
    //1.获取旧值
    NSString * oldValue = [self valueForKey:getterName];
    
    //2. 调用父类方法
    struct objc_super superClass = {
        self,
        class_getSuperclass([self class])
    };
    objc_msgSendSuper(&superClass ,_cmd , name);

    //3.发出通知
    NSDictionary<NSKeyValueChangeKey,id> *changeDict = oldValue ? @{NSKeyValueChangeNewKey : name, NSKeyValueChangeOldKey : oldValue} : @{NSKeyValueChangeNewKey : name};
    [observer observeValueForKeyPath:getterName ofObject:self change:changeDict context:NULL];

}

///通过方法名获取属性（字符串处理）
NSString * getValueKey(NSString * setter){
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *key = [setter substringWithRange:range];
    NSString *letter = [[key substringToIndex:1] lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:letter];
    return  key;
}


@end











