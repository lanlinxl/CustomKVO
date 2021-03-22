//
//  ViewController.m
//  KVO
//
//  Created by lzwk_lanlin on 2021/3/15.
//

#import "ViewController.h"
#import "Student.h"
#import "NSObject+CustomKVO.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Student *student = [[Student alloc] init];
    student.name = @"1111";
    
    [student ll_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    [student addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    student.name = @"lanlin";
    
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"\nkeyPath：%@\nobject:%@\nchange:%@\ncontext:%@",keyPath,object,change,context);
}

@end
