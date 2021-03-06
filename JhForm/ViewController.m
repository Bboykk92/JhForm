//
//  ViewController.m
//  JhForm
//
//  Created by Jh on 2019/1/9.
//  Copyright © 2019 Jh. All rights reserved.
//

#import "ViewController.h"
#import "FormDemo1VC.h"
#import "FormDemo2VC.h"

@interface ViewController ()
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    self.Jh_navTitle = @"JhForm";
    
    [self initModel];
    
}


#pragma mark - initModel
-(void)initModel{
    
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableArray *cellArr0 = [NSMutableArray array];
    
    JhFormCellModel *cell0 = JhFormCellModel_AddRightArrowCell(@"默认表单", nil);
    cell0.Jh_CellSelectCellBlock = ^(JhFormCellModel *cellModel) {
        FormDemo1VC *jumpVC= [[FormDemo1VC alloc]init];
        [weakSelf.navigationController pushViewController:jumpVC animated:YES];
    };
    
    
    JhFormCellModel *cell1 = JhFormCellModel_AddRightArrowCell(@"自定义view表单", nil);
    cell1.Jh_CellSelectCellBlock = ^(JhFormCellModel *cellModel) {
        FormDemo2VC *jumpVC= [[FormDemo2VC alloc]init];
        [weakSelf.navigationController pushViewController:jumpVC animated:YES];
    };
    
    [cellArr0 addObjectsFromArray: @[cell0,cell1]];
    
    JhFormSectionModel *section0= JhSectionModel_Add(cellArr0);
    
    [self.Jh_formModelArr addObject:section0];
    

    //隐藏默认的footerView
    self.Jh_defaultFooterViewHidden = YES;
    
}

@end
