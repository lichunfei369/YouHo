//
//  AppDelegate.m
//  LCFDeerShop
//
//  Created by 李春菲 on 16/11/18.
//  Copyright © 2016年 lichunfei. All rights reserved.
//

#import "AppDelegate.h"
#import "LCFHomeViewController.h"
#import "LCFCategoryViewController.h"
#import "LCFShoppingViewController.h"
#import "LCFMyViewController.h"
#import "LCFNavigationController.h"
#import "LCFTaBarViewController.h"
//1

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self showMainController];
  
    //git测试
    
    
    
    return YES;
}
-(void)showMainController{
    
    LCFHomeViewController * homeVC = [[LCFHomeViewController alloc] init];
    homeVC.title = @"Home";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"home"];
    LCFNavigationController * homeNa = [[LCFNavigationController alloc] initWithRootViewController:homeVC];
    
    LCFCategoryViewController * categoryVC = [[LCFCategoryViewController alloc] init];
    categoryVC.title = @"Categoty";
    categoryVC.tabBarItem.image = [UIImage imageNamed:@"categoty"];
    LCFNavigationController * categoryNa = [[LCFNavigationController alloc] initWithRootViewController:categoryVC];
    
    LCFShoppingViewController * shopVc = [[LCFShoppingViewController alloc]init];
    shopVc.title = @"Shoping";
    shopVc.tabBarItem.image = [UIImage imageNamed:@"shoping"];
    LCFNavigationController * shopNa = [[LCFNavigationController alloc] initWithRootViewController:shopVc];
    
    LCFMyViewController * myVC = [[LCFMyViewController alloc] init];
    myVC.title = @"My";
    myVC.tabBarItem.image = [UIImage imageNamed:@"my"];
    LCFNavigationController * myNa = [[LCFNavigationController alloc] initWithRootViewController:myVC];
    
    LCFTaBarViewController * taBar = [LCFTaBarViewController shareTabar];
    taBar.viewControllers = @[homeNa,categoryNa,shopNa,myNa];
    taBar.tabBar.tintColor = [UIColor whiteColor];
    
    self.window.rootViewController = taBar;
    
     [[UITabBar appearance] setBackgroundImage:[self GetImageWithColor:[UIColor colorWithRed:34 / 255.0 green:31 / 255.0  blue:35 / 255.0 alpha:1.] andHeight:1.]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, taBar.tabBar.bounds);
    taBar.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    taBar.tabBar.layer.shadowColor = [UIColor whiteColor].CGColor;
    taBar.tabBar.layer.shadowOffset = CGSizeMake(0, -0.5);
    taBar.tabBar.layer.shadowRadius = 2;
    taBar.tabBar.layer.shadowOpacity = .5;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    taBar.tabBar.clipsToBounds = NO;
    
    
    
}

- (UIImage*)GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height{
    
    CGRect r = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    return image;
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"LCFDeerShop"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
