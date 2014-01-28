//
//  FileUploadHelper.m
//  SttirUploader
//
//  Created by A12192 on 1/28/14.
//  Copyright (c) 2014 Sttir. All rights reserved.
//

#import "FileUploadHelper.h"

@implementation FileUploadHelper

// Upload の EndPoint
NSString * const kUploadApi = @"http://172.19.201.32:3000/upload";


- (id)init {
    self = [super init];
    if (self) {
        // initialize
    }
    return self;
}

- (void)uploadFileDataByName:(NSString*)fullPath filename:(NSString*)name {
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:fullPath];

    //ここからPOSTDATAの作成
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:kUploadApi]];
    [request setHTTPMethod:@"POST"];

    NSMutableData *body = [NSMutableData data];

    NSString *boundary = @"---------------------------168072824752491622650073";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];

    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", name]
                      dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: image/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:data]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    [request setHTTPBody:body];

    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];

    NSLog(@"%@", returnString);

}

@end
