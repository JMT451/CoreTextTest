//
//  OtherList1Detail.m
//  CoreTextTest
//
//  Created by I_MT on 2017/2/16.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

#import "OtherList1Detail.h"
#import "RSMaskedLabel.h"
#import "Masonry.h"
@interface OtherList1Detail ()

@end

@implementation OtherList1Detail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    RSMaskedLabel *label =[[RSMaskedLabel alloc]init];
    [self.view addSubview:label];
    [label  mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self.view);
       make.top.equalTo(self.view).offset(150);
    }];
    label.font =[UIFont systemFontOfSize:20.0];
    
    label.textColor = [UIColor redColor];
    label.text = @"Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch,Thanks a bunch!";
    
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
