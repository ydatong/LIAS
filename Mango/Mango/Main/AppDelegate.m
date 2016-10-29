//
//  AppDelegate.m
//  Mango
//
//  Created by 周永 on 16/10/20.
//  Copyright © 2016年 shuige. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseViewController.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [self setupMainController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (UITabBarController*)setupMainController {
    
    UITabBarController *mainTabbarVC = [[UITabBarController alloc] init];
    
    
    NSDictionary *tabbarOrderInfo = @{@"0":kTabbarOrderNameTodo,
                                      @"1":kTabbarOrderNamePlan,
                                      @"2":kTabbarOrderNameNote,
                                      @"3":kTabbarOrderNameTimer,
                                      @"4":kTabbarOrderNameSetting};
    
//    if (!tabbarOrderInfo) {
//        tabbarOrderInfo = @{@"0":@"todo",
//                            @"1":@"plan",
//                            @"2":@"note",
//                            @"3":@"timer",
//                            @"4":@"setting"};
//        [[NSUserDefaults standardUserDefaults] setValue:tabbarOrderInfo forKey:kTabbarOrderInfoKey];
//    }

    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0 ; i < 5; i++) {
        [tmp addObject:[self navigationOfName:tabbarOrderInfo[[NSString stringWithFormat:@"%d",i]]]];
    }
    
    mainTabbarVC.viewControllers = [NSArray arrayWithArray:tmp];
    return mainTabbarVC;
}

- (BaseNavigationController*)navigationOfName:(NSString*)name {
    
    if ([name isEqualToString:kTabbarOrderNameTodo]) {
       return [self navgationControllerWithTitle:@"待办"
                                     image:@"tabbar_todo"
                        rootViewController:@"TodoViewController"];
    }
    
    if ([name isEqualToString:kTabbarOrderNamePlan]) {
        return [self navgationControllerWithTitle:@"计划"
                                     image:@"tabbar_plan"
                        rootViewController:@"PlanViewController"];
    }
    
    if ([name isEqualToString:kTabbarOrderNameTimer]) {
        return [self navgationControllerWithTitle:@"定时"
                                            image:@"tabbar_timer"
                               rootViewController:@"TimerViewControllerNew"];
    }
    
    if ([name isEqualToString:kTabbarOrderNameNote]) {
        return [self navgationControllerWithTitle:@"记事"
                                            image:@"tabbar_note"
                               rootViewController:@"NoteViewController"];
    }
    
    return [self navgationControllerWithTitle:@"设置"
                                 image:@"tabbar_setting"
                    rootViewController:@"SettingViewController"];
    
}

- (BaseNavigationController*)navgationControllerWithTitle:(NSString*)title
                                                  image:(NSString*)image
                                     rootViewController:(NSString*)controller{
    
    UIViewController *vc = [NSClassFromString(controller) alloc];
    vc = [vc initWithNibName:controller bundle:nil];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.navigationItem.title = title;
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    return nav;
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
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Mango"];
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
