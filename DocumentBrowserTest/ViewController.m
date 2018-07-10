//
//  ViewController.m
//  DocumentBrowserTest
//
//  Created by SKOINFO_MACBOOK on 2018. 6. 28..
//  Copyright © 2018년 SKOINFO_MACBOOK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)test:(id)sender {
    // Document 연결 및 파일앱 접근을 위한 ViewController 생성
    // public.data 기본
    // public.item 'data' 상위 구조
    // apk, ipa, exe, dmg 와 같은 실행가능한 파일은 선택 안됨 (정확한 이유 알 수 없음)
    UIDocumentPickerViewController *documentPickerViewCtr = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.item"] inMode:UIDocumentPickerModeImport];
    documentPickerViewCtr.delegate = self;
    
    // 다중 선택 가능하도록 mode변경
    documentPickerViewCtr.allowsMultipleSelection = YES;
    
    [self presentViewController:documentPickerViewCtr animated:YES completion:nil];
}

// 파일앱 뷰어에서 파일 선택 완료시 호출
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls
{

    NSLog(@"******************* 파일 선택 완료 *******************");
    
    for (NSURL *url in urls) {
        
        NSError *err = nil;
        NSError *error = nil;

        NSNumber * fileSize;
        if(![url getPromisedItemResourceValue:&fileSize forKey:NSURLFileSizeKey error:&err]) {
            NSLog(@"Failed error: %@", error);
            return ;
        } else {
            // 파일 크기
            NSLog(@"fileSize : %f",fileSize.doubleValue);
            // 파일 크기 바이트 형식으로 변경
            NSLog(@"fileSize Resize : %@",[NSByteCountFormatter stringFromByteCount:fileSize.doubleValue countStyle:NSByteCountFormatterCountStyleFile]);
            // 파일 이름
            NSLog(@"test file name : \n %@",url.lastPathComponent);
            // 파일 타입
            NSLog(@"test file type : \n %@",url.pathExtension);
        }
        
        
        // 파일앱을 통해 가져온 URL 파일을 Data 형식으로 변경
        NSFileCoordinator *coordinator = [[NSFileCoordinator alloc] initWithFilePresenter:nil];
        [coordinator coordinateReadingItemAtURL:url options:0 error:&error byAccessor:^(NSURL *newURL) {
            NSData *data = [NSData dataWithContentsOfURL:newURL];
            // Do something
//            NSLog(@"test data logo : \n %@",data);
        }];
        if (error) {
            // Do something else
            NSLog(@"test error logo : \n %@",error);
        }
        
    }
    
    NSLog(@"**************************************************");
}


// 파일앱 뷰어 취소시 호출
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller
{

}

@end
