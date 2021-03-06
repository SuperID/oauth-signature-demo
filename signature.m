//
//  signature
//  oauth-signature-demo
//
//  Created by YourtionGuo on 14/12/2016.
//  Copyright © 2016 Yourtion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation SIDSign : NSObject

+ (void)demo {
    NSDictionary *dictionary = @{
                                 @"a": @2,
                                 @"b": @"a",
                                 @"timestamp": @1442198292,
                                 @"noncestr" : @"TWSm66JpFIlzdRyk",
                                 @"app_id" : @"5vY4mg0Eog8SWo0mHYSWbqpl",
                                 };
    NSString *sign = [SIDSign getSignatureWithParmas:dictionary andSecret:@"Ppuj8xfvb8jltBkcDvALFcEtWvgXGdxj"];
    
    NSLog(@"Sign: %@", sign);
    NSLog(@"SHA1:%@",[SIDSign sha1:@"com.ISNC.FaceChat"]);
}

+ (NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return result;
}


+ (NSString *)getSignatureWithParmas:(NSDictionary *)params andSecret:(NSString *)secret {
    NSArray *keys = [params allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSString *basestring = [[NSString alloc] init];
    for (NSString *key in sortedArray) {
        NSString *value = [[NSString stringWithFormat:@"%@", [params objectForKey:key]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        basestring = [NSString stringWithFormat:@"%@&%@=%@", basestring, key, value];
    }
    basestring = [basestring substringFromIndex:1];
    basestring = [basestring stringByAppendingFormat:@":%@", secret];
    NSLog(@"BaseString: %@",basestring);
    
    NSString *sign = [SIDSign md5:basestring];
    NSLog(@"MD5: %@", sign);
    return sign;
}

@end

int main(int argc, char *argv[]) {
    @autoreleasepool {
        [SIDSign demo];
    }
}