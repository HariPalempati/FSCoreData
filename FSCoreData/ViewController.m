//
//  ViewController.m
//  FSCoreData
//
//  Created by Hari Krishna Palempati on 3/07/15.
//  Copyright (c) 2015 Hari Krishna Palempati. All rights reserved.
//

//#import "ViewController.h"
//#import <FBSDKCoreKit/FBSDKCoreKit.h>
//#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import <Accounts/Accounts.h>
//#import <Social/Social.h>
//#import "Friends.h"
//
//@interface ViewController ()
//
//@end
//
//@implementation ViewController
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    
//    self.view.backgroundColor = [UIColor whiteColor];
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
//    
//    
//    UIButton * Friends = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 40)];
//    [Friends setTitle:@"Friends" forState:UIControlStateNormal];
//    [Friends setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [Friends addTarget:self action:@selector(FriendsClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:Friends];
//    
//    
//    //    FBSDKProfilePictureView *profilePictureview = [[FBSDKProfilePictureView alloc]initWithFrame:_imageView.frame];
//    //    [profilePictureview setProfileID:result[@"id"]];
//    //    [self.view addSubview:profilePictureview];
//    
//    ProfileName = [[UILabel alloc] initWithFrame:CGRectMake(40, 80, 180, 45)];
//    ProfileName.textAlignment = NSTextAlignmentCenter;
//    ProfileName.text = @"Welcome : ";
//    
//    ProfileName.textColor = [UIColor blueColor];
//    
//    [self.view addSubview:ProfileName];
//    
//    Image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 150, 300, 100)];
//    //image.image = [image ]
//    [self.view addSubview:Image];
//    
//    [self getUserData];
//    
//    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onProfileUpdated:) name:FBSDKProfileDidChangeNotification object:nil];
//}
//
//// get's the details of the user who is currently logged in
//- (void) getUserData
//{
//    if ([FBSDKAccessToken currentAccessToken]) {
//        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
//         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//             if (!error) {
//                 //NSLog(@"fetched user:%@", result);
//                 NSString *userName = [result objectForKey:@"userName"];
//                 NSString *ImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [result objectForKey:@"userID"]];
//                 NSURL *picUrl = [NSURL URLWithString:ImageURL];
//                 //NSLog(@" Name : %@ \n imageURl : %@",userNme, userImageURL);
//                 ProfileName.text = [NSString stringWithFormat:@"Welcome : %@",userName];
//                 Image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:picUrl]];
//                 
//             }
//         }];
//    }
//    
//}
//
//- (void)onProfileUpdated:(NSNotification*)notification {
//    
//}
//
//- (void)FriendsClicked {
//    
//    Friends * f = [[Friends alloc]init];
//    
//    [self.navigationController pushViewController:f animated:YES];
//    
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//@end

#import "ViewController.h"
#import "AppDelegate.h"
#import "FSData.h"
#import <Social/Social.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Friends.h"

@interface ViewController ()
{
    NSMutableArray * dataSource;
    AppDelegate * appDel;
    
    NSMutableArray * friendsArray;
    NSDictionary * friendCollection;
    
    // new fields for username and user image
    UILabel * userNameLabel;
    UIImageView * userImageView;
}
@end

@implementation ViewController

//@synthesize loginButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    appDel = [[UIApplication sharedApplication] delegate];
    self.title = @" List of Friends ";
    self.view.backgroundColor = [UIColor whiteColor];
    dataSource = [[NSMutableArray alloc] init];
    
    //[self deleteMethod];
    
    //REMOVED IT AND ADDED IT AS IBOUTLET
    //IBOUTLETS ARE INITILIAZED BY DEFAULT
    // facebook login
    
    FBSDKLoginButton * loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    
//    self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    // User name => display's name of the user logged in
    
    userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 80, 180, 45)];
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    userNameLabel.text = @"Hello : ";
    
    userNameLabel.textColor = [UIColor blueColor];
    
    [self.view addSubview:userNameLabel];
    
    // User Image => display's profile picture of the user
    
    userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 140, 225, 150)];
    
    [self.view addSubview:userImageView];
    
    // calling getUserData method to set the logged in user detail's like name, image.
    [self getUserData];
    
    
    UIButton * getFriends = [[UIButton alloc] initWithFrame:CGRectMake(80, 400, 200, 45)];
    [getFriends setTitle:@"Get My Friends List" forState:UIControlStateNormal];
    [getFriends setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [getFriends addTarget:self action:@selector(showFriends:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getFriends];
    
    UIButton * deleteData = [[UIButton alloc] initWithFrame:CGRectMake(80, 450, 200, 45)];
    [deleteData setTitle:@"Delete Data" forState:UIControlStateNormal];
    [deleteData setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [deleteData addTarget:self action:@selector(deleteMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteData];
    
    // NSLog(@" END ");
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onProfileUpdated:) name:FBSDKProfileDidChangeNotification object:nil];
}

// get's the details of the user who is currently logged in
- (void) getUserData
{
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 //NSLog(@"fetched user:%@", result);
                 NSString *userNme = [result objectForKey:@"name"];
                 NSString *userImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [result objectForKey:@"id"]];
                 NSURL *picUrl = [NSURL URLWithString:userImageURL];
                 //NSLog(@" Name : %@ \n imageURl : %@",userNme, userImageURL);
                 userNameLabel.text = [NSString stringWithFormat:@" Hello : %@",userNme];
                 userImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:picUrl]];
                 
             }
         }];
    }
    
}

- (void)onProfileUpdated:(NSNotification*)notification {
    
}

// Getting facebook data

-(void) showFriends:(UIButton *) btn;
{
    //NSLog(@"showFriends");
    NSFetchRequest * fetch = [NSFetchRequest fetchRequestWithEntityName:@"FriendsTable"];
    
    NSError * error;
    
    NSArray * results = [appDel.managedObjectContext executeFetchRequest:fetch error:&error];
    NSLog(@" results count is %li",[results count]);
    
    if (error == nil && [results count] == 25) {
        NSLog(@" [results count] == 25 ");
        Friends * showNavCont = [[Friends alloc] init];
        [self.navigationController pushViewController:showNavCont animated:YES];
    }
    else
    {
        NSLog(@" [results count] != 25 ");
        [self fetchFacebookFriends:^(NSArray *successArray) {
            self.theFriendsArray = successArray;
            
            //COREDATA
            //Prepare the array that we will send
            friendsArray = [[NSMutableArray alloc]init];
            for (NSDictionary *userInfo in successArray)
            {
                
                NSString *userName = [userInfo objectForKey:@"name"];
                NSString *userID = [userInfo objectForKey:@"id"];
                
                NSDictionary *pictureData = [[userInfo objectForKey:@"picture"] objectForKey:@"data"];
                NSString *imageUrl = [pictureData objectForKey:@"url"];
                //Save all the user information in a dictionary that will contain the basic info that we need
                friendCollection = [[NSDictionary alloc]initWithObjects:@[userName, imageUrl, userID] forKeys:@[@"username", @"picURL", @"uId"]];
                //Store each dictionary inside the array that we created
                [friendsArray addObject:friendCollection];
                
            }
            [self addMethod];
            //
            
            dispatch_async(dispatch_get_main_queue(), ^{
                Friends * showNavCont = [[Friends alloc] init];
                [self.navigationController pushViewController:showNavCont animated:YES];
                //[table reloadData];
            });
            
        }error:^(NSString *errorString) {
            
        }];
    }
    
}

-(void)fetchFacebookFriends:(FriendsCallbackSuccess)success error:(FriendsCallbackError)inError {
    
    FBSDKGraphRequest * request = [[FBSDKGraphRequest alloc] initWithGraphPath:[NSString stringWithFormat:@"/%@/taggable_friends", [[FBSDKProfile currentProfile] userID]] parameters:Nil HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (error == nil) {
            NSArray *allFriends = [result objectForKey:@"data"];
            success(allFriends);
        } else {
            inError(error.description);
        }
    }];
}

-(void)getEmployeeDataFromCoreData
{
    
    //NSLog(@"getEmployeeDataFromCoreData");
    NSFetchRequest * fetch = [NSFetchRequest fetchRequestWithEntityName:@"FSData"];
    
    NSError * error;
    
    NSArray * results = [appDel.managedObjectContext executeFetchRequest:fetch error:&error];
    NSLog(@" results count is %li",[results count]);
    
    if (error == nil && [results count]>0) {
        
        //        [dataSource removeAllObjects];
        [dataSource addObjectsFromArray:results];
        //        [table reloadData];
        
        for (int i = 0; i<2; i++) {
            FSData * objEmployee = [dataSource objectAtIndex:i];
            NSLog(@" Name %i is %@",i, objEmployee.userName);
            NSLog(@" user id %i is %@",i,objEmployee.userID);
            NSLog(@" URl %i is %@",i, objEmployee.imageUrl);
        }
        
        
    }
    
}

-(void)addMethod
{
    
    //NSLog(@" in addMethod ");
    NSLog(@" Friends array size is %li",[friendsArray count]);
    NSDictionary * dict;
    for (int i = 0; i<[friendsArray count]; i++) {
        FSData * objFriend = [NSEntityDescription insertNewObjectForEntityForName:@"FSData" inManagedObjectContext:appDel.managedObjectContext];
        dict = [friendsArray objectAtIndex:i];
        
        NSURL *picUrl = [NSURL URLWithString:[dict objectForKey:@"picURL"]];
        //You are saving it ahead of time, but I want you to get it when it is showed to user, You need to do lazy loading, Think about 1000 friends lets say, You cannot get all of them at once
        //You need to do it in cell for row //USE NSURLConnection sendAsynchronousRequest
        //I have added a class for FriendsTable(NSManagedobject) that links to coredata entity you created before, Add a method under that class for fetching image
        //To add a class for enity , select that entity under xcdatamodel and Editor -> create new NSManagedObjectModel
        //Show loading if it is fetching
        //Get rid of other friendsTable class
        
        NSData * data = [NSData dataWithContentsOfURL:picUrl];
        objFriend.userName = [dict objectForKey:@"username"];
        objFriend.userID = [dict objectForKey:@"uId"];
        objFriend.imageUrl = [dict objectForKey:@"picURL"];
        objFriend.pictureData = data;
        
        NSError * error;
        [appDel.managedObjectContext save:&error];
        
        if (error == nil) {
        }
    }
    [self getEmployeeDataFromCoreData];
    
}


-(void)deleteMethod
{
    NSLog(@"deleteMethod");
    NSFetchRequest * allCars = [[NSFetchRequest alloc] init];
    [allCars setEntity:[NSEntityDescription entityForName:@"FSData" inManagedObjectContext:appDel.managedObjectContext]];
    [allCars setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * cars = [appDel.managedObjectContext executeFetchRequest:allCars error:&error];
    //error handling goes here
    for (NSManagedObject * car in cars) {
        [appDel.managedObjectContext deleteObject:car];
    }
    NSError *saveError = nil;
    [appDel.managedObjectContext save:&saveError];
    [self getEmployeeDataFromCoreData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
