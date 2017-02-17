//
//  RootTVC.m
//  CoreTextTest
//
//  Created by I_MT on 2017/1/19.
//  Copyright © 2017年 jiuxiaoming. All rights reserved.
//

#import "RootTVC.h"
#import "CoreTextTest-Swift.h"
#import "List3.h"
#import "OtherList1.h"
#import <objc/runtime.h>
#import "TwoStyleTextVC.h"
#import "GradientTextVC.h"
@interface RootTVC ()

@end

@implementation RootTVC
{
    NSMutableArray *sources;
    NSArray *sections;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    sources=[NSMutableArray array];
    sources=[@[
         @[  //CoreText
           @"Swift之CoreText排版神器(长篇高能)",
           @"测试Ascent、Descent、Leading",
           @"CoreText实现图文混排",
           @"根据字体路径动画"
         ],
         @[   //TextKit
          @"Translucid文本内嵌图片",
          @"Swift3.0图文混排进阶（三）TextKit",
          @"文本动画"
         ],
         @[
          @"绘制文本，可以显示背景",//http://stackoverflow.com/questions/18716751/drawing-a-path-with-subtracted-text-using-core-graphics
          @"滑块展示两种字体！",//http://www.tuicool.com/articles/vq6ZZrM
          @"渐变颜色的字体的实现！！！"//http://www.tuicool.com/articles/rMfEN3
         ]
    ] mutableCopy];
    sections=@[@"C",@"T",@"O"];//C coretext  T textkit
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_reset];}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sources.count; // CoreText & TextKit
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr=sources[section];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSArray *arr=sources[indexPath.section];
    NSString *title = arr[indexPath.row];
    if ([title isKindOfClass:[NSString class]]) {
        cell.textLabel.text=title;
    }
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return sections[section];
}
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView __TVOS_PROHIBITED{
    return sections;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index __TVOS_PROHIBITED{
    return index;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr=sources[indexPath.section];
    NSString *title = arr[indexPath.row];
    UIViewController *vc;
     if (indexPath.section==0) {//CoreText
        switch (indexPath.row) {
            case 0:{
                    vc=[[List1 alloc]init];
                }
                break;
            case 1:{
                    vc=[[List2 alloc]init];
                }
                break;
            case 2:{
                vc=[[List3 alloc]init];
                }
                break;
            case 3:{
                vc =[[ListVC4 alloc]init];
            }
            default:
                break;
        }
    }else if (indexPath.section==1){//TextKit
        switch (indexPath.row) {
            case 0:
               vc = [[TextKitVC1 alloc]init];
                break;
             case 1:
                vc=[[TextKitVC2 alloc]init];
                break;
            case 2:
                vc=[[TextKitVC3 alloc]init];
            default:
                break;
        }
    }else if (indexPath.section ==2){
        switch (indexPath.row) { //Other
            case 0:
                vc =[[OtherList1 alloc]init];
                break;
             case 1:
             
                vc = [[TwoStyleTextVC alloc]init];
            case 2:
                vc = [[GradientTextVC alloc]init];
                break;
            default:
                break;
        }
    }
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
