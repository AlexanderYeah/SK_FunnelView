//
//  ViewController.m
//  SK_FunnelView
//
//  Created by coder on 2019/3/19.
//  Copyright © 2019 AlexanderYeah. All rights reserved.
//

#import "ViewController.h"
#import "SKFunnelView.h"
#import "SKFunnelDataModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SKFunnelDataModel *model1 = [SKFunnelDataModel new];
    model1.value = 10.f;
    model1.color = [UIColor redColor];
    model1.title = @"欧莱雅";
    
    SKFunnelDataModel *model2 = [SKFunnelDataModel new];
    model2.value = 12.f;
    model2.color = [UIColor orangeColor];
    model2.title = @"欧诗漫";
    
    SKFunnelDataModel *model3 = [SKFunnelDataModel new];
    model3.value = 22.f;
    model3.color = [UIColor brownColor];
    model3.title = @"SKII";
    SKFunnelDataModel *model4 = [SKFunnelDataModel new];
    model4.value = 20.f;
    model4.color = [UIColor cyanColor];
    model4.title = @"DAAPPLE";
    SKFunnelDataModel *model5 = [SKFunnelDataModel new];
    model5.value = 20.f;
    model5.color = [UIColor redColor];
    model5.title = @"OTHER";
    NSMutableArray *data = [NSMutableArray new];
    
    [data addObject:model1];
    [data addObject:model2];
    [data addObject:model3];
    [data addObject:model4];
    [data addObject:model5];
    
    
    SKFunnelView *funnelView = [[SKFunnelView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/2 - 64.f) withDataArr:data];
    [self.view addSubview:funnelView];
    
    
}


@end
