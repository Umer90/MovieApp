/*Disclaimer: IMPORTANT:  This software is proprietary confidential property owned exclusively by Umer Wasi Without prior written consent and compensation, Umer Wasi expressly forbids the use, installation, modification or redistribution of this software.
 
 
 Umer Wasi forbids all parties, without a non-exclusive license, under Umer Wasi's copyrights in this original software (the “Umer Wasi Software"), to use, reproduce, modify and redistribute the Software, with or without modifications, in source and/or binary forms. In all cases, you must retain this notice and the following text and  Disclaimers in all such redistributions of the Software.
 
 
 The Software is provided by Umer Wasi on an "AS IS" basis. Umer Wasi MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 
 IN NO EVENT SHALL Umer Wasi BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION). ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF Umer Wasi HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 Copyright © 2019 Umer Wasi. All rights reserved.*/

#import "SharedHelper.h"

@implementation SharedHelper

-(instancetype)init{
    //do initializations here
    return self;
}

#pragma -mark Reacheability

-(BOOL)connectedToNetwork{
    Reachability *reachability = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    BOOL isInternet;
    if(remoteHostStatus == NotReachable)
    {
        isInternet = NO;
    }
    else if (remoteHostStatus == ReachableViaWWAN)
    {
        isInternet = YES;
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    {
        isInternet = YES;
    }
    else{
        isInternet = NO;
    }
    return isInternet;
}

-(void)initReacheability{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self->kReacheacheable  = YES;
        });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self->kReacheacheable  = NO;
        });
    };
    [reach startNotifier];
}

-(BOOL)kIsReacheable{
    return kReacheacheable;
}

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {
        kReacheacheable  = YES;
    }
    else
    {
        kReacheacheable  = NO;
    }
}

- (NSString *)removedSpacesInString :(NSString *)str{
    return [str stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
}

-(void)showMessage :(NSString*)message withTitle :(NSString *)title :(UIViewController *)vc{
    UIAlertController *alert=   [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:ALERT_OKAY style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //do something when click button
    }];
    [alert addAction:okAction];
    [vc presentViewController:alert animated:YES completion:nil];
}

#pragma -mark MBProgressHUD

- (void)showAnimator{
    dispatch_async(dispatch_get_main_queue(), ^{
        UINavigationController *nvc;
        if(nvc == nil){
            nvc = (UINavigationController *)appdelegate.window.rootViewController;
        }
        UIViewController *vc  = [[nvc viewControllers]lastObject];
        self->hudLoading = [MBProgressHUD showHUDAddedTo:vc.view animated:YES];
        
        self->hudLoading.mode = MBProgressHUDModeIndeterminate;
        self->hudLoading.removeFromSuperViewOnHide=YES;
    });
}

- (void)hideAnimator{
    dispatch_async(dispatch_get_main_queue(), ^{
        UINavigationController *nvc;
        if(nvc == nil){
            nvc = (UINavigationController *)appdelegate.window.rootViewController;
        }
        UIViewController *vc  = [[nvc viewControllers]lastObject];
        [MBProgressHUD hideHUDForView:vc.view animated:YES];
    });
}

@end
