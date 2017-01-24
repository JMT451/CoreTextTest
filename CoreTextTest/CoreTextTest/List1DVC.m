//
//  List1DVC.m
//  CoreTextTest
//
//  Created by I_MT on 2017/1/21.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

#import "List1DVC.h"
#import "CoreTextTest-Swift.h"

@interface List1DVC ()

@end

@implementation List1DVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    CTTextView1 *textView =[[CTTextView1 alloc]initWithFrame:CGRectMake(0, 64, Screen_W, Screen_W)];
    textView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:textView];
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
