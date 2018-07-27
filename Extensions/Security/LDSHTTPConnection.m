//
//  LDSHTTPConnection.m
//  SmartHome
//
//  Created by leedarson on 2018/6/15.
//  Copyright © 2018年 leedarson. All rights reserved.
//

#import "LDSHTTPConnection.h"
#import "HTTPLogging.h"
#import "NSString+hash.h"
@protocol GCDAsyncSocketDelegate;

// Log levels : off, error, warn, info, verbose
// Other flags: trace
static const int httpLogLevel = HTTP_LOG_LEVEL_VERBOSE | HTTP_LOG_FLAG_TRACE;

@interface LDSHTTPConnection ()

@end

@implementation LDSHTTPConnection

- (BOOL)isPasswordProtected:(NSString *)path
{
    // We're only going to password protect the "secret" directory.
    
    BOOL result = [path hasPrefix:@"/"];
    
    HTTPLogTrace2(@"%@[%p]: isPasswordProtected(%@) - %@", THIS_FILE, self, path, (result ? @"YES" : @"NO"));
    
    return result;
}

- (BOOL)useDigestAccessAuthentication
{
    HTTPLogTrace();
    
    // Digest access authentication is the default setting.
    // Notice in Safari that when you're prompted for your password,
    // Safari tells you "Your login information will be sent securely."
    //
    // If you return NO in this method, the HTTP server will use
    // basic authentication. Try it and you'll see that Safari
    // will tell you "Your password will be sent unencrypted",
    // which is strongly discouraged.
    
    return YES;
}

- (NSString *)passwordForUser:(NSString *)username
{
    HTTPLogTrace();
    
    // You can do all kinds of cool stuff here.
    // For simplicity, we're not going to check the username, only the password.
    
    return [NSString sha1:@"smarthome"];
}
- (BOOL)isSecureServer {

    return YES;
}
- (NSArray *)sslIdentityAndCertificates {

        NSData *pkcs12data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"server_test" ofType:@"p12"]];
        if (pkcs12data==nil) {
            return nil;
        }
        CFDataRef inPKCS12Data = (CFDataRef)CFBridgingRetain(pkcs12data);
        CFStringRef password = CFSTR("ldx2017");
        const void *keys[] = { kSecImportExportPassphrase };
        const void *values[] = { password };
        CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    
        CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    
        OSStatus securityError = SecPKCS12Import(inPKCS12Data, options, &items);
    
        if(securityError == errSecSuccess)
            NSLog(@"Success opening p12 certificate.");
    
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef myIdent = (SecIdentityRef)CFDictionaryGetValue(identityDict,
                                                                      kSecImportItemIdentity);
//    [sslSettings setObject:(id)kCFBooleanTrue forKey:(NSString *)GCDAsyncSocketManuallyEvaluateTrust];
//    //    [sslSettings setObject:[[NSArray alloc] initWithObjects:(__bridge id)(myIdent), nil] forKey:GCDAsyncSocketSSLCertificates];
    return [[NSArray alloc] initWithObjects:(__bridge id)(myIdent), nil];
}


@end
