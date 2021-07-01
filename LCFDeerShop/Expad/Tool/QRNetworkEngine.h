//
//  QRNetworkEngine.h
//  TestProject
//
//  Created by 李春菲 on 17/1/11.
//  Copyright © 2017年 duoshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>

typedef enum _InternetStatus {
    NONE = 0,
    WWAN,
    WIFI,
} InternetStatus;

typedef void (^NetworkSuccessBlock)(id data);
typedef void (^NetworkFailureBlock)(NSError *error);
typedef void (^NetworkMultipartBlock)(id<AFMultipartFormData> formData);
typedef void (^NetworkReachabilityBlock)(InternetStatus status);

typedef enum _HttpMethod {
    GET = 0,
    POST,
    PUT,
    DELETE,
    HEAD,
    PATCH,
    POSTMUTIPART,
} HttpMethod;



//user信息
#define KAPI_QRU_Login                                @"user/login"      //登录__收银MD1.0




















//#define kAPI_QRU_Communitys                           @"v1/community/getcommunitylist" //根据坐标获取附近小区列表     ###废弃
#define kAPI_QRU_Stores                               @"v1/store/getstorelist" //根据小区id获取商户列表
#define KAPI_QRU_StoreFrame                           @"v1/products/getProducts" //获取商户货架信息
#define KAPI_QRU_StoreComment                         @"v1/store/getcomment" //获取商户评论信息
#define KAPI_QRU_StoreInfo                            @"v1/store/getstoredetail" //获取商户基本信息
#define KAPI_QRU_Orders                               @"v1/order/getorderlist" //获取我的订单列表
#define KAPI_QRU_OrderInfo                            @"v1/order/getorderdetail" //订单信息
#define KAPI_QRU_MakeOrder                            @"v1/order/newOrder" //创建订单
#define KAPI_QRU_ConfirmOrder                         @"v1/order/confirmorder" //确认订单
#define KAPI_QRU_Addresses                            @"v1/user/getAddressList" //获取收货地址列表
#define KAPI_QRU_AddressProcess                       @"v1/user/cope_address" //处理收货相关信息（增、删、改、查）
#define KAPI_QRU_PayResultConfirm                     @"v1/order/orderStatus" //根据订单id查看订单状态
#define KAPI_QRU_MyVolumes                            @"v1/order/getmyvolume" //我的优惠券
#define KAPI_QRU_VerionCheck                          @"v1/upgrade/index" //检测新版本
#define KAPI_QRU_CancelOrder                          @"v1/order/cancelOrder" //取消订单
#define KAPI_QRU_SaveComment                          @"v1/order/to_comment" //提交一条评论
#define KAPI_QRU_Citys                                @"v1/user/locationCity" //根据坐标获取城市
#define KAPI_QRU_VerifyCode                           @"user/verify/sendSms" //发送验证码
#define KAPI_QRU_Feedback                             @"v1/user/feedback" //意见反馈
#define KAPI_QRU_GetToBePaid                          @"v1/order/prepare_to_pay" //获取待支付订单
#define KAPI_QRU_Refundments                          @"v1/user/myRefundList" //获取退款信息列表
#define KAPI_QRU_VoiceVerify                          @"v1/user/callVerifyCode" //发送语音验证
#define KAPI_QRU_CancelMakeOrder                      @"v1/order/cancelOrderCause20" //取消创建订单
//#define kAPI_QRU_CommunityByLocation                  @"v1/localhost/getcommunity" //根据定位返回一个小区             ###废弃
//#define kAPI_QRU_SearchCommunity                      @"v1/localhost/communitylist" //根据搜索关键字返回小区列表       ###废弃
#define KAPI_QRU_CallbackForPay                       @"v1/thpay/syncback"  //支付回调通知服务器
#define KAPI_QRU_ExchangeVolumes                      @"v1/order/addCoupon"  //兑换优惠劵
#define KAPI_QRU_RedPackage                           @"v1/order/redPackage"  //红包信息
#define KAPI_QRU_ShareInfo                            @"v1/order/shareInfo"  //分享信息
#define KAPI_QRU_ConfirmReceived                      @"v1/ConfirmReceived/Confirmation"  //用户确认收货

#define KAPI_QRU_CurrentLocation                      @"v1/location/currentLocation"  //获取当前位置信息
#define KAPI_QRU_SearchLocation                       @"v1/location/searchLocation"  //搜索位置
#define KAPI_QRU_WelcomeInfo                          @"v1/client/welcomeinfo"  //获取欢迎页面图片数据
#define KAPI_QRU_WeixinOpenId                         @"v1/weixin/getauthorization" //获取微信OpenId
#define KAPI_QRU_CheckProductsWhenByAgain             @"v1/order/buyagain"  //再来一单时，获取商品
#define KAPI_QRU_NearbyLocation                       @"v1/location/nearbyLocation" //获取定位附近的小区列表
#define KAPI_QRU_CommunitiesPOI                       @"v1/location/getCommunitiesList" //获取高德返回小区POI，收货地址小区选择时用

#define KAPI_QRU_AssistInfo                           @"v1/user/getAssistInfo"  //获得辅助信息，未读消息数，客服电话，未用优惠劵数
#define KAPI_QRU_PriceList                            @"v1/order/getPriceList"   //确认订单界面，选项更改，获取新的价格

#define KAPI_QRU_OrderStatus                          @"v1/order/addOrderRemark" //订单信息

#define KAPI_QRU_PopularSearch                        @"v1/search/getPopularSearch"  //热门搜索

#define KAPI_QRU_SearchProduct                        @"v1/search/searchProduct"  //搜索商品
#define KAPI_QRU_ProductDetail                        @"v1/products/getProductDetail"  //推荐商品

@interface QRNetworkEngine : NSObject

+ (void)internetReachableWithblock:(NetworkReachabilityBlock)reachabilityBlock;
+ (void)configueNewRequestHeader;

+ (void)setBaseURL:(NSString *)baseUrl;
+ (NSString *)baseUrl;

+ (void)requestDataAPI:(NSString *)apiPath method:(HttpMethod)method params:(NSDictionary *)params customHeaderField:(NSDictionary *)customHeaderFields onSuccess:(NetworkSuccessBlock)successBlock onFailure:(NetworkFailureBlock)failureBlock;

@end
