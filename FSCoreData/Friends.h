//
//  Friends.h
//  FSCoreData
//
//  Created by Hari Krishna Palempati on 3/07/15.
//  Copyright (c) 2015 Hari Krishna Palempati. All rights reserved.
//

//#import <UIKit/UIKit.h>
//#import "ViewController.h"
//
//@interface Friends : UIViewController<UITableViewDelegate,UITableViewDataSource> {
//    
//    UITableView * table;
//    
//    NSMutableArray * Array;
//    
//    //ViewController * vc;
//    
//    //NSDictionary * friendCollection;
//    
//    //NSMutableArray * friendsArray;
//    
//}
//
//-(void)getFriendsArray;
//
////Declare the block that will execute after receiving success from the method
//
//typedef void (^FriendsCallbackSuccess)(NSArray *successArray);
//
////Declre the block that will execute after receiving error from the method
//
//typedef void (^FriendsCallbackError)(NSString *errorString);
//
//@property (strong,nonatomic)FriendsCallbackSuccess success;
//
//@property (strong,nonatomic)FriendsCallbackError error;
//
////Create an array that will be used for storing the dictionary of friends from facebook
//
//@property (strong, nonatomic)NSArray *theFriendsArray;
//
////@property (strong, nonatomic)NSMutableArray * friendsArray;
//
////@property (nonatomic, copy) ViewController *aReference;
//
///*
// #pragma mark - Navigation
// 
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
// }
// */
//
//@end


#import <UIKit/UIKit.h>

@interface Friends : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * table;
    NSMutableArray * dataSource;
}
@end

//@property (strong, nonatomic) NSString * colorString;
//@end
//
////Status API Training Shop Blog About Help


