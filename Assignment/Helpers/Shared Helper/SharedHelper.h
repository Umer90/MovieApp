/*Disclaimer: IMPORTANT:  This software is proprietary confidential property owned exclusively by Umer Wasi Without prior written consent and compensation, Umer Wasi expressly forbids the use, installation, modification or redistribution of this software.
 
 
 Umer Wasi forbids all parties, without a non-exclusive license, under Umer Wasi's copyrights in this original software (the “Umer Wasi Software"), to use, reproduce, modify and redistribute the Software, with or without modifications, in source and/or binary forms. In all cases, you must retain this notice and the following text and  Disclaimers in all such redistributions of the Software.
 
 
 The Software is provided by Umer Wasi on an "AS IS" basis. Umer Wasi MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 
 IN NO EVENT SHALL Umer Wasi BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION). ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF Umer Wasi HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 Copyright © 2019 Umer Wasi. All rights reserved.*/

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"

@interface SharedHelper : NSObject
{
    MBProgressHUD *hudLoading;
    BOOL kReacheacheable;
}
    
- (BOOL)connectedToNetwork;
- (NSString *)removedSpacesInString :(NSString *)str;
- (void)showMessage:(NSString*)message withTitle:(NSString *)title :(UIViewController *)vc;
- (void)showAnimator;
- (void)hideAnimator;

@end
