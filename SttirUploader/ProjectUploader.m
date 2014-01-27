//
//  ProjectUploader.m
//  SttirUploader
//
//  Copyright (c) 2014 Sttir. All rights reserved.
//

#import "ProjectUploader.h"
#import "helpers/FileDetectHelper.h"
#import <AFURLRequestSerialization.h>
#import <AFURLSessionManager.h>
#import <AFHTTPRequestOperationManager.h>

@interface ProjectUploader()

@end

@implementation ProjectUploader
{
    ;
}

- (void)callUploadAPI:(NSString *)path
{
    // -------------------- finding file name -------------------
    FileDetectHelper *helper = [[FileDetectHelper alloc] init];
    NSArray *fileList = [helper getSpecificExtensionFileByPath:path extensionName:@"jpg"];
    for (NSString *file in fileList) {
        // NSLog(@"filename: %@", file);
    }
    // -------------------- finding file name -------------------


    // -------------------- upload file --------------------
    // TODO: 冗長なので別クラスにする
    // TODO: async 使う？
    // TODO: AFNetworking 使えないか？
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:[fileList objectAtIndex:0]];

    //ここからPOSTDATAの作成
    NSString *urlString = @"http://172.19.201.32:3000/upload";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];

    NSMutableData *body = [NSMutableData data];

    NSString *boundary = @"---------------------------168072824752491622650073";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];

    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"user.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: image/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:data]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    [request setHTTPBody:body];

    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];

    NSLog(@"%@", returnString);
    // -------------------- upload file --------------------

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
	if(httpResponse.statusCode == 200) {
		NSLog(@"");
	}
    else {
        NSLog(@"");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSLog(@"%@", jsonObject);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}
@end
