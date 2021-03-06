//
//  HXCustomNavigationController.m
//  照片选择器
//
//  Created by 洪欣 on 2017/10/31.
//  Copyright © 2017年 洪欣. All rights reserved.
//

#import "HXCustomNavigationController.h"
#import "HXAlbumListViewController.h"
#import "HXDatePhotoViewController.h"
#import "HXPhotoTools.h"

@interface HXCustomNavigationController ()<HXAlbumListViewControllerDelegate, HXDatePhotoViewControllerDelegate>

@end

@implementation HXCustomNavigationController
- (instancetype)initWithManager:(HXPhotoManager *)manager {
    return [self initWithManager:manager delegate:nil doneBlock:nil allImageBlock:nil cancelBlock:nil];
}
- (instancetype)initWithManager:(HXPhotoManager *)manager
                       delegate:(id<HXCustomNavigationControllerDelegate>)delegate {
    return [self initWithManager:manager delegate:delegate doneBlock:nil allImageBlock:nil cancelBlock:nil];
}
- (instancetype)initWithManager:(HXPhotoManager *)manager
                      doneBlock:(viewControllerDidDoneBlock)doneBlock
                  allImageBlock:(viewControllerDidDoneAllImageBlock)allImageBlock
                    cancelBlock:(viewControllerDidCancelBlock)cancelBlock {
    return [self initWithManager:manager delegate:nil doneBlock:doneBlock allImageBlock:allImageBlock cancelBlock:cancelBlock];
}
- (instancetype)initWithManager:(HXPhotoManager *)manager
                       delegate:(id<HXCustomNavigationControllerDelegate>)delegate
                      doneBlock:(viewControllerDidDoneBlock)doneBlock
                  allImageBlock:(viewControllerDidDoneAllImageBlock)allImageBlock
                    cancelBlock:(viewControllerDidCancelBlock)cancelBlock {
    manager.selectPhotoing = YES;
    [manager selectedListTransformBefore];
    dispatch_async(manager.loadAssetQueue, ^{
        [manager preloadData];
    });
    
    if (manager.configuration.albumShowMode == HXPhotoAlbumShowModeDefault) {
        HXAlbumListViewController *vc = [[HXAlbumListViewController alloc] initWithManager:manager];
        self = [super initWithRootViewController:vc];
        if (self) {
            self.hx_delegate = delegate;
            self.manager = manager;
            self.doneBlock = doneBlock;
            self.allImageBlock = allImageBlock;
            self.cancelBlock = cancelBlock;
            vc.doneBlock = self.doneBlock;
            vc.allImageBlock = self.allImageBlock;
            vc.allAssetBlock = self.allAssetBlock;
            vc.cancelBlock = self.cancelBlock;
            vc.delegate = self;
            
        }
    }else if (manager.configuration.albumShowMode == HXPhotoAlbumShowModePopup) {
        HXDatePhotoViewController *vc = [[HXDatePhotoViewController alloc] init];
        vc.manager = manager;
        self = [super initWithRootViewController:vc];
        if (self) {
            self.hx_delegate = delegate;
            self.manager = manager;
            self.doneBlock = doneBlock;
            self.allImageBlock = allImageBlock;
            self.cancelBlock = cancelBlock;
            vc.doneBlock = self.doneBlock;
            vc.allImageBlock = self.allImageBlock;
            vc.allAssetBlock = self.allAssetBlock;
            vc.cancelBlock = self.cancelBlock;
            vc.delegate = self;
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - < HXAlbumListViewControllerDelegate >
- (void)albumListViewControllerDidCancel:(HXAlbumListViewController *)albumListViewController {
    if ([self.hx_delegate respondsToSelector:@selector(photoNavigationViewControllerDidCancel:)]) {
        [self.hx_delegate photoNavigationViewControllerDidCancel:self];
    }
}
- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllImage:(NSArray<UIImage *> *)imageList {
    if ([self.hx_delegate respondsToSelector:@selector(photoNavigationViewController:didDoneAllImage:)]) {
        [self.hx_delegate photoNavigationViewController:self didDoneAllImage:imageList];
    }
}
- (void)albumListViewControllerDidDone:(HXAlbumListViewController *)albumListViewController allAssetList:(NSArray<PHAsset *> *)allAssetList photoAssets:(NSArray<PHAsset *> *)photoAssetList videoAssets:(NSArray<PHAsset *> *)videoAssetList original:(BOOL)original {
    if ([self.hx_delegate respondsToSelector:@selector(photoNavigationViewControllerDidDone:allAssetList:photoAssets:videoAssets:original:)]) {
        [self.hx_delegate photoNavigationViewControllerDidDone:self allAssetList:allAssetList photoAssets:photoAssetList videoAssets:videoAssetList original:original];
    }
}
- (void)albumListViewController:(HXAlbumListViewController *)albumListViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original {
    if ([self.hx_delegate respondsToSelector:@selector(photoNavigationViewController:didDoneAllList:photos:videos:original:)]) {
        [self.hx_delegate photoNavigationViewController:self didDoneAllList:allList photos:photoList videos:videoList original:original];
    }
}
#pragma mark - < HXDatePhotoViewControllerDelegate >
- (void)datePhotoViewControllerDidCancel:(HXDatePhotoViewController *)datePhotoViewController {
    if ([self.hx_delegate respondsToSelector:@selector(photoNavigationViewControllerDidCancel:)]) {
        [self.hx_delegate photoNavigationViewControllerDidCancel:self];
    }
}
- (void)datePhotoViewController:(HXDatePhotoViewController *)datePhotoViewController didDoneAllList:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photoList videos:(NSArray<HXPhotoModel *> *)videoList original:(BOOL)original {
    if ([self.hx_delegate respondsToSelector:@selector(photoNavigationViewController:didDoneAllList:photos:videos:original:)]) {
        [self.hx_delegate photoNavigationViewController:self didDoneAllList:allList photos:photoList videos:videoList original:original];
    }
}
- (void)datePhotoViewController:(HXDatePhotoViewController *)datePhotoViewController didDoneAllImage:(NSArray<UIImage *> *)imageList original:(BOOL)original {
    if ([self.hx_delegate respondsToSelector:@selector(photoNavigationViewController:didDoneAllImage:)]) {
        [self.hx_delegate photoNavigationViewController:self didDoneAllImage:imageList];
    }
}
- (BOOL)shouldAutorotate{
    if (self.isCamera) {
        return NO;
    }
    if (self.manager.configuration.supportRotation) {
        return YES;
    }else {
        return NO;
    }
}

//支持的方向

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.isCamera) {
        return UIInterfaceOrientationMaskPortrait;
    }
    if (self.manager.configuration.supportRotation) {
        return UIInterfaceOrientationMaskAll;
    }else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)dealloc {
    self.manager.selectPhotoing = NO;
    if (HXShowLog) NSSLog(@"dealloc");
}

@end
