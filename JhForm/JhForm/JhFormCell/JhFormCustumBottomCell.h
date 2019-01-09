//
//  JhFormCustumBottomCell.h
//  JhForm
//
//  Created by Jh on 2019/1/8.
//  Copyright © 2019 Jh. All rights reserved.
//

#import "JhFormBaseCell.h"

@class JhFormItem;

@interface JhFormCustumBottomCell : JhFormBaseCell

/**
 自定义视图
 */
@property (nonatomic, strong) UIView *CustumBottomView;

@property (nonatomic, strong) JhFormItem *item;

@end


@interface UITableView (JhFormCustumBottomCell)

- (JhFormCustumBottomCell *)CustumBottomCellWithId:(NSString *)cellId;

@end
