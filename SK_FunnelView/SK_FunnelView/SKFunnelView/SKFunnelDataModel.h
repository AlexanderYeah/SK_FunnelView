//
//  SKFunnelDataModel.h
//  SK_FunnelView
//
//  Created by coder on 2019/3/19.
//  Copyright © 2019 AlexanderYeah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SKFunnelDataModel : NSObject

@property (assign, nonatomic) CGFloat value;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) id object;
/** title */
@property (nonatomic,strong)NSString *title;


@end

NS_ASSUME_NONNULL_END
