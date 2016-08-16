//
//  ViewController.m
//  ButtonList
//
//  Created by Chan on 16/8/16.
//  Copyright © 2016年 Chan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>{
    UIView * _topView;
    UILabel *_naviLabel;
    UIScrollView *_contenScrollView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
- (void)setUI {
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 32)];
    CGFloat buttonW = self.view.frame.size.width / 5;
    CGFloat buttonH = 30;
    NSArray  *titles = @[@"item1",@"item2",@"item3",@"item4",@"item5"];
    for (int i = 0; i < 5; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
        button.tag = 100 + i;
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_topView addSubview:button];
    }
    _naviLabel = [UILabel new];
    _naviLabel.backgroundColor = [UIColor redColor];
    _naviLabel.frame = CGRectMake(0, 30, buttonW, 2);
    [_topView addSubview:_naviLabel];
    [self.view addSubview:_topView];
    
    _contenScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 + 32, [UIScreen  mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64 - 32 - 49)];
    _contenScrollView.contentSize = CGSizeMake([UIScreen  mainScreen].bounds.size.width * 5, 0);
    _contenScrollView.pagingEnabled = YES;
    _contenScrollView.delegate = self;
    for ( int i = 0; i< 5 ; i ++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, _contenScrollView.frame.size.height)];
        view.backgroundColor = [UIColor colorWithRed:(i+3)/10 green:(i+4)/10 blue:(i+2.5)/10 alpha:1.0];
        [_contenScrollView addSubview:view];
    }
    [self.view addSubview:_contenScrollView];
    
}

- (void) buttonClicked:(UIButton *)button {
    NSUInteger index = button.tag - 100;
    [UIView animateWithDuration:0.5 animations:^{
        _naviLabel.frame = CGRectMake(index * (self.view.frame.size.width/5.0), 30, self.view.frame.size.width / 5.0, 2);
    } completion:^(BOOL finished) {
    }];
    [_contenScrollView setContentOffset:CGPointMake(index * [UIScreen mainScreen].bounds.size.width, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset =scrollView.contentOffset;
    NSUInteger index = offset.x / [UIScreen mainScreen].bounds.size.width;
    [UIView animateWithDuration:0.25 animations:^{
        _naviLabel.frame = CGRectMake(index * (self.view.frame.size.width/5.0), 30, self.view.frame.size.width / 5.0, 2);
    } completion:^(BOOL finished) {
    }];
}

@end
