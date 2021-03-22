//
//  Student.h
//  KVO
//
//  Created by lzwk_lanlin on 2021/3/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject

@property(nonatomic,strong)NSString * name;

//- (void)ll_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end

NS_ASSUME_NONNULL_END
