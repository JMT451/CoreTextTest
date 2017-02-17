//
//  List3VC.m
//  CoreTextTest
//
//  Created by I_MT on 2017/1/25.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

#import "List3.h"
#import "List3TextView.h"
@interface List3 ()

@end

@implementation List3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    List3TextView *textView=[[List3TextView alloc]   initWithFrame:CGRectMake(0, 64, Screen_W, Screen_W)];
    textView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:textView];
    // Do any additional setup after loading the view.
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
