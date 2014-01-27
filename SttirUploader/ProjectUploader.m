//
//  ProjectUploader.m
//  SttirUploader
//
//  Copyright (c) 2014 Sttir. All rights reserved.
//

#import "ProjectUploader.h"

@interface ProjectUploader()

@end

@implementation ProjectUploader
{
    ;
}

- (void)callUploadAPI:(NSString *)path
{
    NSData *data = [NSData dataWithContentsOfFile:path];

    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:9393/project/upload"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];

    CFUUIDRef uuid = CFUUIDCreate(nil);
	CFStringRef uuidString = CFUUIDCreateString(nil, uuid);
	CFRelease(uuid);
	NSString *boundary = [NSString stringWithFormat:@"0xKhTmLbOuNdArY-%@",uuidString];

    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *parameter = @"movie";

    NSString *fileName = [[path componentsSeparatedByString:@"/"] lastObject];
    if (fileName.length <= 0){
        NSLog(@"Filename is NULL or NULL string");
        return;
    }

    NSString *contentType = @"video/mp4";

    NSMutableData *postBody = [NSMutableData data];

    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", parameter, fileName] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", contentType] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:data];
	[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    NSString *header = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:header forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:postBody];
	
	[NSURLConnection connectionWithRequest:request delegate:self];
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
