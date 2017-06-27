//
//  SJAvatarBrowser.m
//  NDRCApp
//
//  Created by vp on 2017/5/23.
//  Copyright © 2017年 vp. All rights reserved.
//

#import "SJAvatarBrowser.h"
static CGRect oldframe;

@implementation SJAvatarBrowser
+(void)showImage:(UIImageView *)avatarImageView{
    UIImage *image=avatarImageView.image;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    imageView.userInteractionEnabled=YES;
    [imageView setMultipleTouchEnabled:YES];

    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [imageView addGestureRecognizer:pinchGestureRecognizer];
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [imageView addGestureRecognizer:panGestureRecognizer];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}
+ (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIImageView *view = (UIImageView *)pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        if (view.frame.size.width < [UIScreen mainScreen].bounds.size.width) {
            CGRect tempFrame=view.frame;
            tempFrame.size.width=k_ScreenWidth;
            tempFrame.size.height=CGRectGetHeight(view.frame)/CGRectGetWidth(view.frame)*[UIScreen mainScreen].bounds.size.width;
            view.frame = tempFrame;
            //让图片无法缩得比原图小
        }
//        if (view.frame.size.width > 3 * oldframe.size.width) {
//            view.frame = largeFrame;
//        }
        pinchGestureRecognizer.scale = 1;
    }
}
// 处理拖拉手势
+(void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIImageView *view = (UIImageView *) panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
    
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        
//        if ((view.center.x )>(CGRectGetWidth(view.frame)*0.5) || (view.center.x )<(CGRectGetWidth(view.frame)*0.5)) {
//            [view setCenter:(CGPoint){CGRectGetWidth(view.frame)*0.5+translation.x, view.center.y + translation.y}];
//        }

        
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}
@end
