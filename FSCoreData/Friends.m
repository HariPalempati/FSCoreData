//
//  Friends.m
//  FSCoreData
//
//  Created by Hari Krishna Palempati on 3/07/15.
//  Copyright (c) 2015 Hari Krishna Palempati. All rights reserved.
//

//#import "Friends.h"
//#import "ViewController.h"
//#import <FBSDKCoreKit/FBSDKCoreKit.h>
//#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import <Accounts/Accounts.h>
//#import <Social/Social.h>
//
//@interface Friends ()
//{
//    NSMutableArray *friendsArray;
//    NSDictionary *friendCollection;
//}
//
//@end
//
//@implementation Friends
//
////@synthesize aReference = _aReference;
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
//    self.view.backgroundColor = [UIColor whiteColor];
//    [self getFriendsArray];
//    
//    table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
//    table.delegate = self;
//    table.dataSource = self;
//    [self.view addSubview:table];
//    
//    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
//    
//    //    [[SLRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *FBuser, NSError *error) {
//    //        if (error) {
//    //            // Handle error
//    //        }
//    //
//    //        else {
//    //            NSString *userName = [FBuser name];
//    //            NSString *userImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [FBuser objectID]];
//    //        }
//    //    }];
//    
//    //    if ([FBSDKAccessToken currentAccessToken]) {
//    //    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,name,picture.width(100).height(100)"
//    //                                                                      }]
//    //     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//    //         if (!error) {
//    //             NSString *nameOfLoginUser = [result valueForKey:@"userName"];
//    //             NSString *imageStringOfLoginUser = [[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"imageURL"];
//    //             NSURL *url = [[NSURL alloc] initWithString:(NSString *)url];
//    //
//    //             NSLog(@"Name of user is : %@", nameOfLoginUser);
//    //
//    //             //[self.view setImageWithURL:url placeholderImage: nil];
//    //
//    //         }
//    //     }];
//    //
//    //}
//    
//    NSLog(@"Name of user is :");
//    
//}
//-(void)getFacebookFriends: (FriendsCallbackSuccess)success error:(FriendsCallbackError)inError
//{
//    NSLog(@"getFacebookFriends");
//    ACAccountStore *store = [[ACAccountStore alloc]init];
//    //Specify the account that we're going to use, in this case Facebook
//    ACAccountType *facebookAccount = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
//    //Give the app ID (the one we copied before in our FB application at developer's site), permission keys and the audience that can see what we do (in case we do a POST)
//    NSDictionary *FacebookOptions = @{ACFacebookAppIdKey: @"960905807284267", ACFacebookPermissionsKey: @[@"public_profile",@"email",@"user_friends"],ACFacebookAudienceKey:ACFacebookAudienceFriends};
//    //Request access to the account with the options that we established before
//    [store requestAccessToAccountsWithType:facebookAccount options:FacebookOptions completion:^(BOOL granted, NSError *error) {
//        //Check if everything inside our app that we created at facebook developer is valid
//        if (granted)
//        {
//            NSArray *accounts = [store accountsWithAccountType:facebookAccount];
//            //Get the accounts linked to facebook in the device
//            if ([accounts count]>0) {
//                ACAccount *facebookAccount = [accounts lastObject];
//                
//                //Set the parameters that we require for our friend list
//                NSDictionary *param=[NSDictionary dictionaryWithObjectsAndKeys:@"picture.width(1000).height(1000),name,link",@"fields", nil];
//                //Generate the facebook request to the graph api, we'll call the taggle friends api, that will give us the details from our list of friends
//                SLRequest *facebookRequest = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://graph.facebook.com/v2.0/me/taggable_friends"] parameters:param];
//                //                SLRequest *facebookRequest = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://graph.facebook.com/USER_ID/friends?format=json&limit=25&offset=25&__after_id=LAST_ID"] parameters:param];
//                //
//                //Set the parameters and request to the FB account
//                [facebookRequest setAccount:facebookAccount];
//                
//                [facebookRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//                    // Read the returned response
//                    if(!error){
//                        self.success = success;
//                        //Read the response in a JSON format
//                        id json =[NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
//                        //NSLog(@"Dictionary contains data: %@", json );
//                        if([json objectForKey:@"error"]!=nil)
//                        {
//                        }
//                        //Get the data inside of the json in an array
//                        NSArray *allFriends = [json objectForKey:@"data"];
//                        //Prepare the array that we will send
//                        friendsArray = [[NSMutableArray alloc]init];
//                        //NSLog(@" allFriends Count is : %li", [allFriends count]);
//                        //NSLog(@"UserName & id is : ");
//                        for (NSDictionary *userInfo in allFriends)
//                        {
//                            
//                            NSString *userName = [userInfo objectForKey:@"name"];
//                            
//                            NSString *userID = [userInfo objectForKey:@"id"];
//                            
//                            NSLog(@"user_ID %@",userID);
//                            
//                            NSDictionary *pictureData = [[userInfo objectForKey:@"picture"] objectForKey:@"data"];
//                            NSString *imageUrl = [pictureData objectForKey:@"url"];
//                            //Save all the user information in a dictionary that will contain the basic info that we need
//                            friendCollection = [[NSDictionary alloc]initWithObjects:@[userName, imageUrl] forKeys:@[@"username", @"picURL"]];
//                            //Store each dictionary inside the array that we created
//                            [friendsArray addObject:friendCollection];
//                            NSLog(@"Friends Array is %@",friendsArray);
//                        }
//                        //NSLog(@" The total no. of friends is : %li",[friendsArray count]);
//                        //Send the array that we created to a success call
//                        success(friendsArray);
//                        
//                    }
//                    
//                    //NSLog(@"URL %@", urlResponse);
//                    //NSLog(@"%@", [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding]);
//                }];
//            }
//        }else{
//            //If there was an error, show in console the code number
//            NSLog(@"ERROR: %@", error);
//            self.error = inError;
//        }
//        
//    }];
//}
//
//-(void)getFriendsArray
//
//{
//    
//    //Call the method to get facebook friends declared below
//    
//    [self getFacebookFriends:^(NSArray *successArray) {
//        
//        //Receive the array that is generated after success
//        
//        self.theFriendsArray = successArray;
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [table reloadData];
//            
//        });
//        
//    } error:^(NSString *errorString) {
//        
//    }];
//    
//    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
//                                       parameters:@{@"fields": @"picture, email"}]
//     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//         if (!error) {
//             NSString *pictureURL = [NSString stringWithFormat:@"%@",[result objectForKey:@"imageURL"]];
//             
//             NSLog(@"email is %@", [result objectForKey:@"email"]);
//             
//             NSData  *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:pictureURL]];
//             UIImageView * Image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 300, 400)];
//             Image.image = [UIImage imageWithData:data];
//             
//         }
//         else{
//             NSLog(@"%@", [error localizedDescription]);
//         }
//     }];
//    NSLog(@"Friends Array is %@",friendsArray);
//    
//    //NSLog(@"friendsArray %@", _friendsArray);
//    
//}
//
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return [friendsArray count];
//    //return [self.aReference.friendsArray count];
//}
//
//// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
//// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    
//    if (cell == nil) {
//        
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
//    }
//    
//    //Contact * objContact = [dataSource objectAtIndex:indexPath.row];
//    //NSLog(@"friendsArray size is %li",[friendsArray count]);
//    NSDictionary * dict = [friendsArray objectAtIndex:indexPath.row];
//    UIImage *image;
//    //Get the image from the url received
//    NSURL *picUrl = [NSURL URLWithString:[dict objectForKey:@"picURL"]];
//    image = [UIImage imageWithData:[NSData dataWithContentsOfURL:picUrl]];
//    [cell.imageView setContentMode:UIViewContentModeScaleAspectFit];
//    //Hide the activity indicator
//    [cell.imageView setNeedsLayout];
//    cell.imageView.image = image;
//    
//    cell.textLabel.text = [dict objectForKey:@"username"];
//    return cell;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
//{
//    //NSLog(@"numberOfSectionsInTableView");
//    return 1;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end


#import "Friends.h"
#import "FSData.h"
#import "AppDelegate.h"

@interface Friends ()
{
    AppDelegate * appDel;
}
@end

@implementation Friends

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Core Data
    
    self.title = @" Friends List ";
    self.view.backgroundColor = [UIColor whiteColor];
    appDel = [[UIApplication sharedApplication] delegate];
    dataSource = [[NSMutableArray alloc] init];
    table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [self getEmployeeDataFromCoreData];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    //NSLog(@"numberOfSectionsInTableView");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [dataSource count];
    //return 25;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //NSLog(@" in cellForRowAtIndexPath start ");
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    UIImage * image;
    
    FSData * objEmployee = [dataSource objectAtIndex:indexPath.row];
    //    NSURL *picUrl = [NSURL URLWithString:objEmployee.url];
    //    image = [UIImage imageWithData:[NSData dataWithContentsOfURL:picUrl]];
    
    // retrieved stored data of the image from core data
    image = [UIImage imageWithData:objEmployee.pictureData];
    [cell.imageView setContentMode:UIViewContentModeScaleAspectFit];
    //Hide the activity indicator
    [cell.imageView setNeedsLayout];
    cell.imageView.image = image;
    
    cell.textLabel.text = objEmployee.userName;
    //cell.detailTextLabel.text = objEmployee.empId;
    return cell;
    
}

-(void)getEmployeeDataFromCoreData
{
    
    NSFetchRequest * fetch = [NSFetchRequest fetchRequestWithEntityName:@"FSData"];
    
    NSError * error;
    
    NSArray * results = [appDel.managedObjectContext executeFetchRequest:fetch error:&error];
    NSLog(@" results count in showingFriendsViewController is %li",[results count]);
    
    if (error == nil) {
        NSLog(@"error == nil");
        [dataSource removeAllObjects];
        [dataSource addObjectsFromArray:results];
        [table reloadData];
        
    }
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 60;
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
