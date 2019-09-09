/*Disclaimer: IMPORTANT:  This software is proprietary confidential property owned exclusively by Umer Wasi Without prior written consent and compensation, Umer Wasi expressly forbids the use, installation, modification or redistribution of this software.
 
 
 Umer Wasi forbids all parties, without a non-exclusive license, under Umer Wasi's copyrights in this original software (the “Umer Wasi Software"), to use, reproduce, modify and redistribute the Software, with or without modifications, in source and/or binary forms. In all cases, you must retain this notice and the following text and  Disclaimers in all such redistributions of the Software.
 
 
 The Software is provided by Umer Wasi on an "AS IS" basis. Umer Wasi MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, REGARDING THE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 
 IN NO EVENT SHALL Umer Wasi BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION). ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF Umer Wasi HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 Copyright © 2019 Umer Wasi. All rights reserved.*/

#import "NetworkHelper.h"

@implementation NetworkHelper

+(void)getServicesInfo: (NSString *)urlString :(UIViewController *)vc withCompletionHandler:(void (^) (NSDictionary *response, NSError *error))completionHandler;{
    
    [sharedHelper showAnimator];
    
    if ([sharedHelper connectedToNetwork]) {
        
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,urlString]];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            completionHandler (responseObject, nil);
            [sharedHelper hideAnimator];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            completionHandler (nil, error);
            [sharedHelper hideAnimator];
        }];
    }
    else{
        [sharedHelper showMessage:MSG_NO_INTERNET withTitle:TITLE_NO_INTERNET :vc];
    }
}
@end
