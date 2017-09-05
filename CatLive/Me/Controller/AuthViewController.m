//
//  AuthViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/22.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "AuthViewController.h"
#import <UIButton+WebCache.h>
#import "UIButton+Ext.h"
#import <AVFoundation/AVFoundation.h>
@interface AuthViewController () <UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

    __weak IBOutlet UIScrollView *_scrollView;
    
    __weak IBOutlet UIView *_contentView;
    
    __weak IBOutlet NSLayoutConstraint *_contentViewHeight;
    
    __weak IBOutlet UIButton *_userImageBtn;
    
    __weak IBOutlet UIView *_recodVideoView;

    __weak IBOutlet UIButton *_playBtn;
    __weak IBOutlet UIButton *_reRecodBtn;
    __weak IBOutlet UIButton *_recodBtn;
    
    __weak IBOutlet UIButton *_submitBtn;
    
    UIImagePickerController *_pickerVC;
    
}

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"申请认证";
    [self destoryViews];
    
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    _contentViewHeight.constant = 752;
}


- (void)destoryViews {
    _userImageBtn.layer.masksToBounds = YES;
    _userImageBtn.layer.cornerRadius = 40.0;
    _recodVideoView.layer.cornerRadius = 8.0;
    _recodVideoView.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 21.0;
    _submitBtn.layer.masksToBounds = YES;
    
    [_playBtn chanegStyleTopImageBottomTitle];
    _playBtn.hidden = YES;
    [_reRecodBtn chanegStyleTopImageBottomTitle];
    _reRecodBtn.hidden = YES;
    [_recodBtn chanegStyleTopImageBottomTitle];
    
}



- (void)uploadPhotoAsUserHeader:(UIImage *)image{
    //上传头像
    [_userImageBtn setImage:image forState:UIControlStateNormal];
    
}

//- (NSString *)creatSandBoxFilePathIfNoExist {
//    //沙盒路径
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentDirectory = [paths objectAtIndex:0];
//    
//    NSFileManager *fileManager = [[NSFileManager alloc] init];
//    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    //创建目录
//    NSString *createPath = [NSString stringWithFormat:@"%@/Video", pathDocuments];
//    // 判断文件夹是否存在，如果不存在，则创建
//    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
//        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
//    } else {
//        NSLog(@"FileImage is exists.");
//    }
//    return createPath;
//}
//
//
//- (void)convertVideoWithFileName:(NSString *)fileName{
//   NSString *sandBoxFilePath = [self creatSandBoxFilePathIfNoExist];
//    
//    //转码配置
//    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:model.assetFilePath options:nil];
//    AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
//    exportSession.shouldOptimizeForNetworkUse = YES;
//    exportSession.outputURL = [NSURL fileURLWithPath:model.sandBoxFilePath];
//    exportSession.outputFileType = AVFileTypeMPEG4;
//    [exportSession exportAsynchronouslyWithCompletionHandler:^{
//        int exportStatus = exportSession.status;
//        RZLog(@"%d",exportStatus);
//        switch (exportStatus)
//        {
//            case AVAssetExportSessionStatusFailed:
//            {
//                // log error to text view
//                NSError *exportError = exportSession.error;
//                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
//                break;
//            }
//            case AVAssetExportSessionStatusCompleted:
//            {
//                RZLog(@"视频转码成功");
//                NSData *data = [NSData dataWithContentsOfFile:model.sandBoxFilePath];
//                model.fileData = data;
//            }
//        }
//    }];
//    
//}

- (IBAction)chooseUserImageAction:(UIButton *)sender {
    if (_pickerVC == nil) {
        _pickerVC = [[UIImagePickerController alloc] init];
        _pickerVC.delegate = self;
        _pickerVC.allowsEditing = YES;
    }
    _pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    _pickerVC.showsCameraControls = YES;
    [self presentViewController:_pickerVC animated:YES completion:^{
        
    }];
}


- (IBAction)playVideoAction:(UIButton *)sender {
    
}

- (IBAction)reRecodAction:(UIButton *)sender {
    //重新录制
    
}

- (IBAction)recodAction:(UIButton *)sender {
    //录制视频
}


- (IBAction)submitAction:(UIButton *)sender {
    //提交
}



#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //取消选择头像
    [_pickerVC dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    if ([info[@"UIImagePickerControllerMediaType"] isEqualToString:(NSString *)kUTTypeImage]) {
        //得到图片
        UIImage *editImg = [info objectForKey:UIImagePickerControllerEditedImage];
        if (editImg != nil) {
            [self uploadPhotoAsUserHeader:editImg];
            
        }
    } else {
        [NoticeView showWithMsg:NSLocalizedString(@"请正确选择一张图片", nil)];
    }
    
    [_pickerVC dismissViewControllerAnimated:YES completion:^{
    }];
}



- (void)uploadUserInfoSuccess {
    //信息上传成功后注销界面
    
    //清空录制视频的缓存文件
    

}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
