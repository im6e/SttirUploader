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
    NSString *file = [NSString stringWithFormat:@"file://%@", [fileList objectAtIndex:0]];
    NSLog(@"%@", file);
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
//                                                                                              URLString:@"http://172.19.201.32:3000/upload"
//                                                                                             parameters:nil
//                                                                              constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//                                        [formData appendPartWithFileURL:[NSURL fileURLWithPath:file]
//                                                                   name:@"file"
//                                                               fileName:@"filename.txt"
//                                                               mimeType:@"text/plain"
//                                                                  error:nil
//                                         ];
//    } error:nil];
//
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSProgress *progress = nil;
//
//    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request
//                                                                       progress:&progress
//                                                              completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//                                                                  if (error) {
//                                                                      NSLog(@"Error: %@", error);
//                                                                  } else {
//                                                                      NSLog(@"%@ %@", response, responseObject);
//                                                                  }
//                                                              }
//                                          ];
//
//    [uploadTask resume];

//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSDictionary *parameters = @{@"foo": @"bar"};
//    NSURL *filePath = [NSURL fileURLWithPath:file];
//    NSData *data = [[NSFileManager defaultManager] contentsAtPath:file];
//    [manager POST:@"http://172.19.201.32:3000/upload" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
//     {
//         [formData appendPartWithFileURL:filePath
//                                    name:@"file"
//                                fileName:@"filename.jpg"
//                                mimeType:@"image/jpeg"
//                                   error:nil
//          ];
//     }
//          success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSLog(@"Success: %@", responseObject);
//     }
//          failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         NSLog(@"Error: %@", error);
//         NSLog(@"all headers: %@", [[operation.response allHeaderFields] descriptionInStringsFileFormat]);
//         NSLog(@"request: %@", [[operation.request allHTTPHeaderFields] descriptionInStringsFileFormat]);
//         NSString *req = [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
//         NSLog(@"req: %@", req);
//     }
//     ];


    NSData *data = [[NSFileManager defaultManager] contentsAtPath:[fileList objectAtIndex:0]];
    NSLog(@"data: %@", data);

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
