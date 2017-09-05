//
//  RegistureUserInfoViewController.m
//  CatLive
//
//  Created by 平凡 on 17/8/20.
//  Copyright © 2017年 Yahaw Lee. All rights reserved.
//

#import "RegistureUserInfoViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface RegistureUserTableCell : UITableViewCell <UITextFieldDelegate>{

    __weak IBOutlet UILabel *_titleLabel;
    
}
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RegistureUserTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _textField.delegate = self;

}


#pragma mark - UITextFieldDelegate


@end

@protocol RegistureUserSexTableCellDelegate <NSObject>

- (void)userChoiceSexIsMan:(BOOL)isMan;

@end

@interface RegistureUserSexTableCell : UITableViewCell {

    __weak IBOutlet UIButton *_manBtn;
    
    __weak IBOutlet UIButton *_womanBtn;
}
@property (nonatomic,weak) id<RegistureUserSexTableCellDelegate> delegate;


@end

@implementation RegistureUserSexTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (IBAction)choiceManAction:(UIButton *)sender {
    sender.selected = YES;
    _womanBtn.selected = NO;
    
    if (_delegate && [_delegate respondsToSelector:@selector(userChoiceSexIsMan:)]) {
        [_delegate userChoiceSexIsMan:YES];
    }
}

- (IBAction)choiceWomanAction:(UIButton *)sender {
    sender.selected = YES;
    _manBtn.selected = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(userChoiceSexIsMan:)]) {
        [_delegate userChoiceSexIsMan:NO];
    }
    
}



@end




@interface RegistureUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate>{

    __weak IBOutlet UITableView *_tableView;
    
    __weak IBOutlet UIView *_haderView;
    __weak IBOutlet UIButton *_skipBtn;
    __weak IBOutlet UIButton *_headerChoiceBtn;
    
    
    __weak IBOutlet UIView *_footerView;
    
    __weak IBOutlet UIButton *_finishBtn;
    
    CLLocationManager                *_locationManager;
    CLGeocoder                       *_locationEncoder;//将经纬度信息转换成位置信息
    NSString                         *_locationStr;//用户的位置

    
    
    UIImagePickerController *_pickerVC;
    
    UIImage *_selectImage;
    
    
}

@end

@implementation RegistureUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _skipBtn.layer.cornerRadius = 14.0;
    _skipBtn.layer.masksToBounds = YES;
    
    _finishBtn.layer.cornerRadius = 21.0;
    _finishBtn.layer.masksToBounds = YES;
    
    [self getUserLocationInfo];//获取用户定位信息
    
}


- (void)showAlbum {
    if (_pickerVC == nil) {
        _pickerVC = [[UIImagePickerController alloc] init];
        _pickerVC.delegate = self;
        _pickerVC.allowsEditing = YES;
    }
    _pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_pickerVC animated:YES completion:^{
    }];
}

- (void)showCrema {
    
    
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

- (void)getUserLocationInfo{
    //上传用户位置信息
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager requestWhenInUseAuthorization];//请求仅在使用时定位
        _locationManager.distanceFilter = 10.0;//定位的频率
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;//设置精确度
        _locationManager.delegate  = self;
        _locationEncoder = [[CLGeocoder alloc] init];
    }
    //    BOOL isopen  = [CLLocationManager locationServicesEnabled];
    //    BOOL isopen  = [CLLocationManager regionMonitoringEnabled];
    
    if ([ CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        //提示跳转修改权限
        [self showLocationAuthAlert];
    } else {
        [_locationManager startUpdatingLocation];//开始定位
    }
}
- (void)showLocationAuthAlert {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"定位服务未开启" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//提示定位失败
    }];
    UIAlertAction *authAction = [UIAlertAction actionWithTitle:@"开启定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //跳转定位设置页
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:authAction];
    [self presentViewController:alertVC animated:YES completion:^{
    }];
}




#pragma mark - IBAction
- (IBAction)skipAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (IBAction)headerChoiceAction:(UIButton *)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *crameAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showCrema];
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showAlbum];
    }];
    [alertVC addAction:crameAction];
    [alertVC addAction:albumAction];
    [self presentViewController:alertVC animated:YES completion:^{
    }];
    
}


- (IBAction)finishAction:(UIButton *)sender {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@([LoginManager manager].userInfo.userId) forKey:@"userId"];
    [params setObject:@"joker" forKey:@"nickname"];
    [params setObject:@"127" forKey:@"longitude"];
    [params setObject:@"35" forKey:@"latitude"];
    //上传头像
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 这行最好加上
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:[NSString stringWithFormat:@"%@%@",URL_DOMAIN,APIUpdateInfo] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(_selectImage, 0.3f);
        [formData appendPartWithFileData:imageData name:@"avatar" fileName:@"123" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDic = responseObject;
        int code = [resultDic safeIntForkey:@"status"];
        
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"%@",error);
         
    }];

    
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
            [_headerChoiceBtn setImage:editImg forState:UIControlStateNormal];
            _selectImage = editImg;
            
        }
    } else {
        [NoticeView showWithMsg:NSLocalizedString(@"请正确选择一张图片", nil)];
    }
    
    [_pickerVC dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - CLLocationManagerDelegate
//定位信息
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (locations && locations.count) {
        //        CLLocationCoordinate2D lastLocation = locations.lastObject.coordinate;
        CLLocation *location = [locations lastObject];
        //开始转换
        [_locationEncoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error == nil) {
                CLPlacemark *placemark = [placemarks lastObject];
                NSString *city = [placemark.addressDictionary objectForKey:@"City"];
                //                NSString *subLoc = [placemark.addressDictionary objectForKey:@"SubLocality"];
                if ([city isEqualToString:@"(null)"]) {
                    city = placemark.country;//城市为空取国家
                }
                _locationStr = [NSString stringWithFormat:@"%@·%@",placemark.country,city];
            }
        }];
        [manager stopUpdatingLocation];
    }
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    //定位失败
    [manager stopUpdatingLocation];
}




#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        RegistureUserSexTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegistureUserSexTableCell"];
        return cell;
    } else {
        RegistureUserTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegistureUserTableCell"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
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





