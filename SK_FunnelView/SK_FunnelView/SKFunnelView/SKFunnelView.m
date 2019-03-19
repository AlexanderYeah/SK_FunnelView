//
//  SKFunnelView.m
//  SK_FunnelView
//
//  Created by coder on 2019/3/19.
//  Copyright © 2019 AlexanderYeah. All rights reserved.
//

#import "SKFunnelView.h"
#import "SKFunnelDataModel.h"
@interface SKFunnelView()

/** 数据源数组*/
@property (nonatomic,strong)NSArray *dataArr;

/**  */
@property (nonatomic,assign)CGPoint prePointA;
@property (nonatomic,assign)CGPoint prePointB;
@property (nonatomic,assign)CGPoint prePointC;
@property (nonatomic,assign)CGPoint prePointD;



@end


@implementation SKFunnelView

static const CGFloat kMargin = 10.f;
// 倾斜角度
static const CGFloat kCorner = .25f;


- (instancetype)initWithFrame:(CGRect)frame withDataArr:(NSArray *)dataArr
{
    if (self = [super initWithFrame:frame] ) {
        _dataArr = dataArr;
        self.backgroundColor = [UIColor whiteColor];
        
        if (dataArr.count == 0) {
            @throw [NSException exceptionWithName: NSInvalidArgumentException reason:@"invalid argument" userInfo:nil];
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

    _prePointA = CGPointZero;
    _prePointB = CGPointZero;
    _prePointC = CGPointZero;
    _prePointD = CGPointZero;
    
    CGFloat funnelMaxWidth = CGRectGetWidth(rect) * 0.7f;
    CGFloat funnelMaxHeight = CGRectGetHeight(rect) - kMargin * 2;
    CGFloat totalValue = 0.f;
    
    for (SKFunnelDataModel *model in _dataArr) {
        totalValue += model.value;
    }
    
    
    
    
    // 最小高度为2.f
    static CGFloat minHeight = 2.f;
    
    // 遍历
    __weak typeof(&*self) weakSelf = self;
    [_dataArr enumerateObjectsUsingBlock:^(SKFunnelDataModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 四个绘制点起点
        CGPoint pointA = CGPointZero;
        CGPoint pointB = CGPointZero;
        CGPoint pointC = CGPointZero;
        CGPoint pointD = CGPointZero;
        
        
        // 获取自己部分的高度
        CGFloat height = funnelMaxHeight * (obj.value / totalValue);
        // 如果最小高度小于2.f 则等于2.f
        if (height < minHeight) {
            height = minHeight;
        }
        
        // 如果是起点
        if (weakSelf.prePointA.x == 0.f && weakSelf.prePointA.y == 0.f) {
            // 左上角的点
            pointA = CGPointMake(kMargin, kMargin);
            // 右上角的点
            pointB = CGPointMake(funnelMaxWidth + kMargin, kMargin);
            // 右下角的点
            pointC = CGPointMake((funnelMaxWidth + kMargin) - (height * kCorner), kMargin + height);
            // 左下角的点
            pointD = CGPointMake(kMargin + (height * kCorner), kMargin + height);
        }else{
            // 非起点
            pointA = weakSelf.prePointD;
            pointB = weakSelf.prePointC;
            pointC = CGPointMake(pointB.x - (height * kCorner), weakSelf.prePointC.y + height);
            pointD = CGPointMake(pointA.x + (height * kCorner), weakSelf.prePointC.y + height);
            
        }
        
        weakSelf.prePointA = pointA;
        weakSelf.prePointB = pointB;
        weakSelf.prePointC = pointC;
        weakSelf.prePointD = pointD;
        
//        if (pointC.x < pointD.x) {
//            pointC.x = pointB.x;
//            pointD.x = pointA.x;
//        }
        
        
        
        [self drawRectWithColor:obj.color
                         pointA:pointA
                         pointB:pointB
                         pointC:pointC
                         pointD:pointD
                         title:obj.title];
        
        
        
        
        
    }];
    
}

// MARK:绘制文字
//- (void)drawText:(CGContextRef)context
//{
//    //英文中通常按照单词换行
//    NSString *string = @"hello world!";
//    //查看所有字体
//    NSLog(@"%@",[UIFont familyNames]);
//    UIFont *fount = [UIFont systemFontOfSize:13.f];
//    [string drawInRect:CGRectMake(self.frame.size.width - 60, 50, 60, 25)withFont:fount lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
//}

// MARK:绘制图形
- (void)drawRectWithColor:(UIColor*)color
                   pointA:(CGPoint)pA
                   pointB:(CGPoint)pB
                   pointC:(CGPoint)pC
                   pointD:(CGPoint)pD
                    title:(NSString *)title{
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //开始路径绘制
    CGContextBeginPath(context);
    
    //起点
    CGContextMoveToPoint(context,pA.x,pA.y);
    CGContextAddLineToPoint(context,pB.x, pB.y);
    CGContextAddLineToPoint(context,pC.x, pC.y);
    CGContextAddLineToPoint(context,pD.x, pD.y);
    //设置填充色
    [color setFill];
    //设置边框颜色
    [color setStroke];
    
    
    // 绘制文字 算出中心Y点
    
    CGFloat content_y = (pD.y -  pA.y)/2 + pA.y;
    
    UIFont *fount = [UIFont systemFontOfSize:12.f];
    [title drawInRect:CGRectMake(self.frame.size.width - 80, content_y - 10, 80, 30)withFont:fount lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    
    
    //绘制路径
    CGContextDrawPath(context,kCGPathFillStroke);
}


@end
