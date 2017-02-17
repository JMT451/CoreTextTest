//
//  TwoStyleTextVC.m
//  CoreTextTest
//
//  Created by I_MT on 2017/2/17.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

#import "TwoStyleTextVC.h"
#import "JXTSlideClipLabel.h"
#import "ParallaxViewController.h"
#import "Masonry.h"
@interface TwoStyleTextVC ()
@property (nonatomic,strong)JXTSlideClipLabel *twoStyleLabel ;

@end

@implementation TwoStyleTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSlideClipLabel];

    UIButton *btn1 =[[UIButton alloc]init];
    [self.view addSubview:btn1];
    [btn1 setTitle:@"下一页" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor blackColor];
    [btn1 addTarget:self action:@selector(gotoNext) forControlEvents:UIControlEventTouchUpInside];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.width.mas_equalTo(120);
       make.height.mas_equalTo(40);
       make.centerX.equalTo(self.view);
       make.top.equalTo(self.twoStyleLabel.mas_bottom).offset(20);
    }];
    UIButton *btn2 =[[UIButton alloc]init];
    [self.view addSubview:btn2];
    [btn2 setTitle:@"下一页" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor blackColor];
    [btn2 addTarget:self action:@selector(gotoNext2) forControlEvents:UIControlEventTouchUpInside];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(self.view);
        make.top.equalTo(btn1.mas_bottom).offset(20);
    }];

}
#pragma mark - 切边字
- (void)createSlideClipLabel
{
    NSArray * titleArr = @[@"大哥", @"Two哥", @"三哥", @"四哥", @"五哥", @"6😁"];
    _twoStyleLabel= [[JXTSlideClipLabel alloc] initWithFrame:CGRectMake(0, 64 + 80, self.view.frame.size.width, 80) andTitleArray:titleArr];
    _twoStyleLabel.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_twoStyleLabel];
}
- (void)gotoNext
{
    ParallaxViewController * parallaxVC = [[ParallaxViewController alloc] init];
    parallaxVC.style = 1;
    [self.navigationController pushViewController:parallaxVC animated:YES];
}
- (void)gotoNext2
{
    ParallaxViewController * parallaxVC = [[ParallaxViewController alloc] init];
    parallaxVC.style = 2;
    [self.navigationController pushViewController:parallaxVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
