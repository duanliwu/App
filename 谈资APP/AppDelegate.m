//
//  AppDelegate.m
//  谈资APP
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "TitleViewController.h"
#import "GuideViewController.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sucess"]) {
//        
//        [self MianViewController];  //如过再一次读到了这个1  这表示已经不是第一次进入程序了
//    }else{
//        [self HuanYing];
//    }
    [self MianViewController];
    [UMSocialData setAppKey:@"507fcab25270157b37000010"];
    [UMSocialWechatHandler setWXAppId:@"wxd9a39c7122aa6516" url:nil];
    
    
    [UMSocialConfig setQQAppId:@"100424468" url:nil importClasses:@[[QQApiInterface class],[TencentOAuth class]]];
    
    
    //设置友盟登录功能
   
    
    
    
    
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}
-(void)HuanYing{
   
    GuideViewController * guide = [[GuideViewController alloc]init];
    //定义代码块 切换视图   这个代码快内容是切换视图 名字叫做myblock
    void(^myblock)(void) = ^{
    
        [self MianViewController];
    
    };                     //这个block执行完就会调用
    guide.block = myblock;//这一步是 让这个guide去执行block  执行刚才传过来block
    self.window.rootViewController = guide;
  

}

-(void)MianViewController{

    
    NSLog(@"fafasd");
    TitleViewController * title = [[TitleViewController alloc]init];
    UINavigationController * una = [[UINavigationController alloc]initWithRootViewController:title];
    self.window.rootViewController = una;
    
    


}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
//这句话是加上第三方登录的功能
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{

    return [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UMSocialSnsService applicationDidBecomeActive];//这句话也是加上第三方登录的功能
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
