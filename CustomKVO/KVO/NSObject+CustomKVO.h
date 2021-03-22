//
//  NSObject+CustomKVO.h
//  KVO
//
//  Created by lzwk_lanlin on 2021/3/15.
//

#import <Foundation/Foundation.h>

@interface NSObject (CustomKVO)

- (void)ll_addObserver:(NSObject *_Nullable)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end

