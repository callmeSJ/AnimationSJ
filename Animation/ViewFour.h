//
//  ViewFour.h
//  Animation
//
//  Created by SJ on 16/8/5.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SwipBlock)();

@interface ViewFour : UIView

- (void)createView;
@property (nonatomic, strong) SwipBlock swipBlock;

@end
