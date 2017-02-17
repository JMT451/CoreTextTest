//
//  OtherList1.m
//  CoreTextTest
//
//  Created by I_MT on 2017/2/16.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

#import "OtherList1.h"
#import "PerspectiveTextView.h"
#import "CoreTextTest-Swift.h"
#import "Masonry.h"
#import "OtherList1Detail.h"
@interface OtherList1 ()

@end

@implementation OtherList1

- (void)viewDidLoad {
    [super viewDidLoad];
    PerspectiveTextView *view = [[PerspectiveTextView alloc]initWithFrame:CGRectMake(70, 70, 250, 250)];
    view.backgroundColor = [UIColor clearColor];
    view.circleColor = [UIColor redColor];
    view.text = @"6😁厉害";
    [self.view addSubview:view];
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(view.mas_bottom).offset(20);
       make.width.mas_equalTo(120);
       make.height.mas_equalTo(40);
       make.centerX.equalTo(self.view);
    }];
    [btn setTitle:@"另一种方式" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];

}
-(void)action{
    OtherList1Detail *vc =[[OtherList1Detail alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor =[UIColor blueColor];
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
