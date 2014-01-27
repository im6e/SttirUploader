//
//  ProjectUploader.m
//  SttirUploader
//
//  Copyright (c) 2014 Sttir. All rights reserved.
//

#import "ProjectUploader.h"
#import "helpers/FileDetectHelper.h"

@interface ProjectUploader()

@end

@implementation ProjectUploader
{
    ;
}

- (void)callUploadAPI:(NSString *)path
{
    FileDetectHelper *helper = [[FileDetectHelper alloc] init];
    NSArray *fileList = [helper getSpecificExtensionFileByPath:path extensionName:@"txt"];
    for (NSString *file in fileList) {
        NSLog(@"filename: %@", file);
    }

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
