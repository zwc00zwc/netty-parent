<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="x-dns-prefetch-control" content="on" />
    <title>起点彩票</title>
    <meta name="viewport" content="width=320.1,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no,minimal-ui" />
    <meta name="apple-mobile-web-app-title" content="起点彩票" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta content="telephone=no" name="format-detection" />
    <!--<meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />-->
    <script src="${request.getContextPath()}/resources/chat/m/js/mui.min.js"></script>
    <link href="${request.getContextPath()}/resources/chat/m/css/mui.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="${request.getContextPath()}/resources/chat/m/css/main.css" />
    <script type="text/javascript" src="${request.getContextPath()}/resources/chat/m/js/common.js"></script>
    <script type="text/javascript" src="${request.getContextPath()}/resources/chat/m/js/rem.js"></script>
    <script type="text/javascript" src="${request.getContextPath()}/resources/chat/m/js/jquery.min.js"></script>
    <script type="text/javascript" src="${request.getContextPath()}/resources/chat/m/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="${request.getContextPath()}/resources/chat/m/js/mui.min.js"></script>
    <script type="text/javascript" src="${request.getContextPath()}/resources/chat/m/js/dataform.js"></script>
    <script type="text/javascript" charset="utf-8">
        mui.init();
    </script>
</head>

<body>
<header class="">
    <a class="logo"><img src="${request.getContextPath()}/resources/chat/m/images/logo.png" /></a>
    <h1 class="title">起点彩票群</h1>
    <div class="userLogin">
        <span id="userName"><a href="login.html" class="userName">登录</a></span>
        <a id="userInfoBtn"  onclick="userInfoPageFun()">
            <img id="indexAvatar" class="indexAvatar" src="${request.getContextPath()}/resources/chat/m/images/userSet.png" />
        </a>
    </div>
</header>
<div id="mask" class="mask"></div>
<div class="num">7787人</div>
<nav class="">
    <div class="">
        <ul class="flex navlist spaceBetween">
            <li class="active">
                <a href="#">聊天</a>
            </li>
            <li>
                <a href="#">直播</a>
            </li>
            <li>
                <a href="#">投注</a>
            </li>
            <li>
                <a href="#">开奖</a>
            </li>
            <li>
                <a href="#">充值</a>
            </li>
        </ul>
    </div>
</nav>
<div id="scroll_div" class="fl textAuto">
    <div id="scroll_begin">
        <span class="pad_right">休闲聊天玩直播，娱乐投注等开奖，尽在起点娱乐<a href=""> www.qdcp585.com!</a></span>
        <span class="pad_right">休闲聊天玩直播，娱乐投注等开奖，尽在<a href="">起点娱乐 www.qdcp585.com!</a></span>
        <span class="pad_right">休闲聊天玩直播，娱乐投注等开奖，尽在<a href="">起点娱乐 www.qdcp585.com!</a></span>
        <span class="pad_right">休闲聊天玩直播，娱乐投注等开奖，尽在<a href="">起点娱乐 www.qdcp585.com!</a></span>
        <span class="pad_right">休闲聊天玩直播，娱乐投注等开奖，尽在<a href="">起点娱乐 www.qdcp585.com!</a></span>

    </div>
    <div id="scroll_end"></div>
</div>
<div id="container" class="container">
    <div id="messageList" class="messageList" onclick="conFun()">
        <!--<div class="leftRecieve flex flexStart">
        <div class="reciever redPack">
            <div  class="leftAvatar userIcon userIcon24" ></div>
            <div class="content">
                <div class="userInfo">
                    <span class="userName">gufy</span><span>14:20 30</span>
                </div>
                <div class="textcontent">
                    <div class="leftTriangle"></div>
                    <div class="flex alignItems">
                        <img class="packIcon" src="images/redPack.png"/>
                        <div class="">
                            <p class="packP1">小可爱的红包</p>
                            <p class="packP2">领取红包</p>
                        </div>
                    </div>
                    <p class="packP3">聊天室的红包</p>
                </div>
            </div>
        </div>
    </div>
    <div class="leftRecieve flex flexStart">
        <div class="reciever redPack">
            <img class="leftAvatar" src="images/wutu.png" />
            <div class="content">
                <div class="userInfo">
                    <span class="userName">gufy</span><span>14:20 30</span>
                </div>
                <div class="textcontent">
                    <div class="leftTriangle"></div>
                    <div class="flex alignItems">
                        <img class="packIcon" src="images/redPack.png"/>
                        <div class="">
                            <p class="packP1">小可爱的红包</p>
                            <p class="packP2">领取红包</p>
                        </div>
                    </div>
                    <p class="packP3">聊天室的红包</p>
                </div>
            </div>
        </div>
    </div>
    <div class="leftRecieve flex flexStart">
        <div class="reciever">
            <img class="leftAvatar" src="images/wutu.png" />
            <div class="content uploadImgContent">
                <div class="userInfo">
                    <span class="userName">gufy</span><span>14:20 30</span>
                </div>
                <div class="textcontent">
                    <div class="leftTriangle"></div>
                    <img class="uploadImg"  src="images/share/share3.png" />
                </div>
            </div>
        </div>
    </div>
    <div class="rightRecieve flex flexEnd">
        <div class="reciever">
            <img class="rightAvatar" src="images/wutu.png" />
            <div class="content uploadImgContent" style="float: right;">
                <div class="userInfo">
                    <span>14:20 30</span>
                </div>
                <div class="textcontent">
                    <div class="rightTriangle"></div>
                    <img class="uploadImg"  src="images/share/share3.png" />
                </div>
            </div>
        </div>
    </div>-->
        <!--<div class="leftRecieve flex flexStart">
        <div class="reciever">
            <img class="leftAvatar" src="images/wutu.png" />
            <div class="content">
                <div class="userInfo">
                    <span class="userName">gufy</span><span>14:20 30</span>
                </div>
                <div class="textcontent">
                    <div class="leftTriangle"></div>
                    今天中了一百多今天中了一百多今天中了一百多今天中了一百多今天中了一百多
                </div>
            </div>
        </div>
    </div>
    <div class="rightRecieve flex flexEnd">
        <div class="reciever">
            <img class="rightAvatar" src="images/wutu.png" />
            <div class="content" style="float: right;">
                <div class="userInfo">
                    <span>14:20 30</span>
                </div>
                <div class="textcontent">
                    <div class="rightTriangle"></div>
                    我也
                </div>
            </div>
        </div>
    </div>-->
        <!--<div class="getRedBox"><span class="getRed">你已领取小可爱的</em><em>红包</em></span></div>-->
    </div>
    <div id="jionAllList" class="jionAllList">
        <!--<p class="joinList joinList1">欢迎<span>育儿回访来</span>加入聊天室</p>
        <p class="joinList joinList2">欢迎<span>育儿回访来</span>加入聊天室</p>
        <p class="joinList joinList3">欢迎<span>育儿回访来</span>加入聊天室</p>-->
    </div>

</div>
<script type="text/jscript ">
			function postToXinLang() {
				window.open("http://v.t.sina.com.cn/share/share.php?title=" + title + " &url=" + url + " &rcontent=", " _blank ", "scrollbars=no,width=600,height=450,left=75,top=20,status=no,resizable=yes ")
			}

			function postToQzone() {
				window.open("http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?title=" + title + " &url=" + url + " &summary=" + c)
			}

			function postToWb() {
				setTimeout(function() {
					g = " http://v.t.qq.com/share/share.php?title=" + title + " &url=" + url + " &appkey=" + d + " &site=" + f + " &pic=" + e;
					window.open(g, " 转播到腾讯微博 ", "width=700, height=680, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, location=yes, resizable=no, status=no ")
				}, 800);
			}
		</script>
<div id="reword" class="reword ">
    <div id="rewordText " class="rewordText mui-ellipsis-2 ">
        恭喜WX***12在重庆时时彩中投注， 中奖15000元，速速来围观吧！
    </div>
</div>
<div class="rightFix">
    <div id="chatHouse" class="chatHouse ">
        进入聊天室
    </div>
    <div id="redPackBtn" class="redPackBtn">
    </div>
</div>
<div id="myPackBox" class="myPackBox ">
    <a id="myPackBtn1" class="myPackBtn"></a>
</div>
<div id="redPackBox" class="redPackBox ">
    <img src="${request.getContextPath()}/resources/chat/m/images/userSet.png" />
    <div id="sendName" class="sendName ">小可爱</div>
    <div class="sendInfo">发了一个红包，金额随机</div>
    <div id="hasPack" class="hasPack ">
        <div class="sendText">恭喜发财，大吉大利！</div>
        <div class="sendNumber "><em id="sendNumber">200</em>元</div>
        <a id="myPackBtn2" class="seeBtn ">查看我的红包&gt;&gt;</a>
    </div>
    <div id="noPack" class="noPack ">
        红包已抢完！
    </div>
    <div class="intrText">请及时兑换，逾期作废</div>
</div>
<div id="chatHouseBox" class="chatHouseBox">
    <div class="joinHHouse">
        <div class=" ">
            进入聊天室
        </div>
    </div>
    <ul id="houseList" class="houseList ">
        <!--<li>
            <a href="# ">聊天室一</a>
        </li>-->
    </ul>
</div>
</div>
<!--<!--我的红包-->
<div id="myPackPage" class="newPage myPack">
    <div class="header">
        <a onclick="myPackClose()" class="back">
            <img src="${request.getContextPath()}/resources/chat/m/images/myPack/back1.png" />
        </a>
        <h1 class="title ">我的红包</h1>
    </div>
    <div class="packContent">
        <ul class="flex packTitle spaceBetween">
            <li class="active ">
                兑换ID
            </li>
            <li>
                金额
            </li>
            <li>
                兑换时间
            </li>
            <li>
                状态
            </li>
        </ul>
        <ul id="packList" class="packList ">
            <!--<li class="flex spaceAround ">
                <div class="packId ">1247451682</div>
                <div class="price ">200元</div>
                <div class="time ">2019/01/23</div>
                <div class="status1 ">未兑换</div>
            </li>
            <li class="flex spaceAround ">
                <div class="packId ">1247451682</div>
                <div class="price ">200元</div>
                <div class="time ">2019/01/23</div>
                <div class="status2 ">未兑换</div>
            </li>-->

        </ul>
    </div>
    <footer>
        共为您抢了<span id="num">3</span>个红包，共计<span id="total ">2018</span>元
    </footer>
</div>
<!--用户中心-->
<div id="userInfoPage" class="newPage userInfoPage">
    <div class="header">
        <a onclick="userInfoClose()" class="back">
            <img src="${request.getContextPath()}/resources/chat/m/images/back2.png" />
        </a>
        <h1 class="title">用户中心</h1>
        <div class="edit">
            <a onclick="userPassPageFun()" >
                <img src="${request.getContextPath()}/resources/chat/m/images/edit.png" />
            </a>
        </div>
    </div>
    <div class="userInfoContent">
        <div class="topBox">
            <a onclick="userPhotoPageFun()">
                <div class="userInfoAvatar">
                    <img id="iconUser" src="${request.getContextPath()}/resources/chat/m/images/userSet.png" />
                </div>
                <div class="editText">点击编辑头像</div>
            </a>
        </div>
        <div class="userInfoBox">
            <div class="userBox">
                <div class="userName">
                    <span class="userTitle">用户名：</span><span id="userNameBox1">快过节了开发</span>
                </div>
                <div class="userGrounp">
                    <span class="userTitle">用户组：</span><span id="roleNameBox">会员</span>
                </div>
                <div class="regTime">
                    <span class="userTitle">注册时间：</span> <span id="regTime"></span>
                </div>
                <div class="loginIp">
                    <span class="userTitle">登录IP：</span> <span id="loginIp"></span>
                </div>
            </div>
        </div>
    </div>

</div>
<div id="showBox" class="showBox">
    <div class="oprate flex alignItems spaceAround">
        <img src="${request.getContextPath()}/resources/chat/m/images/add.png" onclick="addFun()" />
        <img onclick="faceFun()" src="${request.getContextPath()}/resources/chat/m/images/face.png" />
        <div class="editBox">
            <div id="text" contenteditable="true" class="editbox" onkeydown="enterkey()"></div>
            <div class="messageEditor" onclick="isLogin()" id="inputLogin">登录后才能发起聊天哦~</div>
        </div>


        <img src="${request.getContextPath()}/resources/chat/m/images/send.png" onclick="send()" />
    </div>
    <!--<input type="file" accept="image/*" capture="camera">
<input type="file" name="file" accept="image/*" >-->

    <div id="oprateBox" class="oprateBox flex">
        <img class="oprateImg" src="${request.getContextPath()}/resources/chat/m/images/share.png" onclick="shareFun()" />
        <form class="sendImgForm" id="sendImgForm" method="post">
            <label for="sendImg" class="indexImg"><img src="${request.getContextPath()}/resources/chat/m/images/picture.png" /></label>
            <input type="file" name="file" id="sendImg" accept="image/*">
        </form>

    </div>
    <ul id="faceList" class="faceList flex flexWrap spaceAround">
        <li><img datasrc="::A" src="${request.getContextPath()}/resources/chat/m/images/face/face1.png" /></li>
        <li><img datasrc="::B" src="${request.getContextPath()}/resources/chat/m/images/face/face2.png" /></li>
        <li><img datasrc="::C" src="${request.getContextPath()}/resources/chat/m/images/face/face3.png" /></li>
        <li><img datasrc="::D" src="${request.getContextPath()}/resources/chat/m/images/face/face4.png" /></li>
        <li><img datasrc="::E" src="${request.getContextPath()}/resources/chat/m/images/face/face5.png" /></li>
        <li><img datasrc="::F" src="${request.getContextPath()}/resources/chat/m/images/face/face6.png" /></li>
        <li><img datasrc="::G" src="${request.getContextPath()}/resources/chat/m/images/face/face7.png" /></li>
        <li><img datasrc="::H" src="${request.getContextPath()}/resources/chat/m/images/face/face8.png" /></li>
        <li><img datasrc="::I" src="${request.getContextPath()}/resources/chat/m/images/face/face9.png" /></li>
        <li><img datasrc="::J" src="${request.getContextPath()}/resources/chat/m/images/face/face10.png" /></li>
        <li><img datasrc="::K" src="${request.getContextPath()}/resources/chat/m/images/face/face11.png" /></li>
        <li><img datasrc="::L" src="${request.getContextPath()}/resources/chat/m/images/face/face12.png" /></li>
        <li><img datasrc="::M" src="${request.getContextPath()}/resources/chat/m/images/face/face13.png" /></li>
        <li><img datasrc="::N" src="${request.getContextPath()}/resources/chat/m/images/face/face14.png" /></li>
        <li><img datasrc="::O" src="${request.getContextPath()}/resources/chat/m/images/face/face15.png" /></li>
        <li><img datasrc="::P" src="${request.getContextPath()}/resources/chat/m/images/face/face16.png" /></li>
        <li><img datasrc="::Q" src="${request.getContextPath()}/resources/chat/m/images/face/face17.png" /></li>
        <li><img datasrc="::R" src="${request.getContextPath()}/resources/chat/m/images/face/face18.png" /></li>
        <li><img datasrc="::S" src="${request.getContextPath()}/resources/chat/m/images/face/face19.png" /></li>
        <li><img datasrc="::T" src="${request.getContextPath()}/resources/chat/m/images/face/face20.png" /></li>
        <li><img datasrc="::R" src="${request.getContextPath()}/resources/chat/m/images/face/face21.png" /></li>
    </ul>
    <script type="text/javascript">
        var url = document.location;
        var desc = '起点彩票还不错哦~';
        var title = '起点彩票还不错哦';
        var c = "";
        var d = "";
        var e = "";
        var f = "";
        var logo="${request.getContextPath()}/resources/chat/m/images/logo.png";

        function shareText() {
            var data = {};
            data.content = "起点彩票";
            testShare(0, data);
        }

        function shareImg() {

            var data = {};
            data.image = "${request.getContextPath()}/resources/chat/m/images/logo.png"; //(单纯去分享图片的时候，没有太大限制)
            testShare(1, data);

        }

        function shareNews() {
            /**
             * content 分享内容
             * title 标题
             * image  图片路径(和新闻在一起分享的时候，图片的大小不能超过32k，微信有限制)
             * url 点击后跳转到的页面
             * desc 描述信息
             * type 分享类型  text:0 image:1 news:2
             */
            var data = {};
            data.content = "起点彩票";
            data.title = "起点彩票";
            data.image = "${request.getContextPath()}/resources/chat/m/images/logo.png";
            data.url = document.location;
            testShare(2, data);
        }
    </script>

    <script>
        window._bd_share_config = {
            "common": {
                "bdSnsKey": {},
                "bdText": "",
                "bdMini": "2",
                "bdMiniList": false,
                "bdPic": "",
                "bdStyle": "0",
                "bdSize": "16"
            },
            "share": {
                "bdSize": 16
            },
            "image": {
                "viewList": ["weixin"],
                "viewText": "分享到：",
                "viewSize": "16"
            },
            "selectShare": {
                "bdContainerClass": null,
                "bdSelectMiniList": ["weixin"]
            }
        };
        with(document) 0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=' + ~(-new Date() / 36e5)];
    </script>

    <ul id="shareList" class="shareList flex spaceBetween">

        <li>
            <a href="http://connect.qq.com/widget/shareqq/index.html?url=" +url+"&sharesource=qzone&title=" +title+"&pics="+logo+"&summary=" +desc+"&desc=" +desc+"" target="_blank">
            <img src="${request.getContextPath()}/resources/chat/m/images/share/share1.png" />
            <div>QQ好友</div>
            </a>
        </li>
        <li>
            <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=" +url+ "" target="_blank">
            <img src="${request.getContextPath()}/resources/chat/m/images/share/share2.png" />
            <div>QQ空间</div>
            </a>

        </li>
        <!--<li>
            <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?to=pengyou&url=" +url+ "">
                <img src="images/share/share3.png" />
                <div>朋友网</div>
            </a>
        </li>-->
        <li>
            <a href="http://v.t.qq.com/share/share.php?url=" +url+ "&title="+title+ "&appkey=" + d + "&site=" + f + "&pic=" + e+"">
            <img src="${request.getContextPath()}/resources/chat/m/images/share/share4.png" />
            <div>
                腾讯微博
            </div>
            </a>
        </li>
        <li class="bdsharebuttonbox ">
            <a class="bds_weixin " data-cmd="weixin" title="分享到微信 ">
                <!--<img src="images/share/share5.png " />-->
            </a>
            <div>微信好友</div>
        </li>
        <li class="bdsharebuttonbox ">
            <a data-cmd="weixin" title="分享到微信 ">
                <!--<img src="images/share/share6.png " />-->
            </a>
            <div>朋友圈</div>
        </li>
        <li>
            <a onclick="postToXinLang() ">
                <img src="${request.getContextPath()}/resources/chat/m/images/share/share7.png " />
                <div>
                    新浪微博
                </div>
            </a>
        </li>
    </ul>
</div>
<!--修改密码-->
<div id="userPassPage" class="newPage userPass">
    <div class="header">
        <a onclick="userPassClose()" class="back">
            <img src="${request.getContextPath()}/resources/chat/m/images/back2.png" />
        </a>
        <h1 class="title">修改登录密码</h1>
    </div>
    <div class="passContent">
        <div class="userInfoBox">
            <div class="userBox">
                <div class="userName">
                    <span class="userTitle">用户名：</span><span style="margin-left: 4px;" id="userNameBox2">用户名</span>
                </div>
                <div class="userGrounp">
                    <span class="userTitle" style="margin-right:4px">原始密码：</span><input type="password" name="" id="oldPassword" value="" />
                </div>
                <div class="regTime">
                    <span class="userTitle">新密码：</span> <input type="password" name="" id="firstPassword" value="" />
                </div>
                <div class="confimPass">
                    <span class="userTitle">再次输入：</span> <input type="password" name="" id="secondPassword" value="" />
                </div>
            </div>
        </div>
    </div>

    <div class="passDiv passDiv1">
        <input class="passBtn" type="submit" value="确定" onclick="submit()" />
    </div>
    <div class="passDiv passDiv2">
        <input type="button" value="重置" onclick="reset()" />
    </div>
</div>
</div>

<!--修改头像-->
<div id="userPhotoPage" class="newPage userInfoPage">
    <div class="header">
        <a onclick="userPhotoClose()" class="back">
            <img src="${request.getContextPath()}/resources/chat/m/images/back2.png" />
        </a>
        <h1 class="title"></h1>
    </div>
    <div class="userInfoContent">
        <div class="topBox">
            <div class="userInfoAvatar">
                <img id="imgPhoto" src="${request.getContextPath()}/resources/chat/m/images/userSet.png" />
            </div>
        </div>
        <div class="photoText">系统头像</div>
        <div id="slider" class="mui-slider" >
            <div class="mui-slider-group mui-slider-loop">
                <div class="mui-slider-item mui-slider-item-duplicate">
                    <ul class="photoList flex flexWrap">
                        <li class="userIcon1"></li>
                        <li class="userIcon2"></li>
                        <li class="userIcon3"></li>
                        <li class="userIcon4"></li>
                        <li class="userIcon5"></li>
                        <li class="userIcon6"></li>
                        <li class="userIcon7"></li>
                        <li class="userIcon8"></li>
                        <li class="userIcon9"></li>
                        <li class="userIcon10"></li>
                        <li class="userIcon11"></li>
                        <li class="userIcon12"></li>
                    </ul>
                </div>
                <div class="mui-slider-item">
                    <ul class="photoList flex flexWrap">
                        <li class="userIcon1"></li>
                        <li class="userIcon2"></li>
                        <li class="userIcon3"></li>
                        <li class="userIcon4"></li>
                        <li class="userIcon5"></li>
                        <li class="userIcon6"></li>
                        <li class="userIcon7"></li>
                        <li class="userIcon8"></li>
                        <li class="userIcon9"></li>
                        <li class="userIcon10"></li>
                        <li class="userIcon11"></li>
                        <li class="userIcon12"></li>
                    </ul>
                </div>
                <div class="mui-slider-item">
                    <ul class="photoList flex flexWrap">
                        <li class="userIcon13"></li>
                        <li class="userIcon14"></li>
                        <li class="userIcon15"></li>
                        <li class="userIcon16"></li>
                        <li class="userIcon17"></li>
                        <li class="userIcon18"></li>
                        <li class="userIcon19"></li>
                        <li class="userIcon20"></li>
                        <li class="userIcon21"></li>
                        <li class="userIcon22"></li>
                        <li class="userIcon23"></li>
                        <li class="userIcon24"></li>
                    </ul>
                </div>
                <div class="mui-slider-item mui-slider-item-duplicate">
                    <ul class="photoList flex flexWrap">
                        <li class="userIcon1"></li>
                        <li class="userIcon2"></li>
                        <li class="userIcon3"></li>
                        <li class="userIcon4"></li>
                        <li class="userIcon5"></li>
                        <li class="userIcon6"></li>
                        <li class="userIcon7"></li>
                        <li class="userIcon8"></li>
                        <li class="userIcon9"></li>
                        <li class="userIcon10"></li>
                        <li class="userIcon11"></li>
                        <li class="userIcon12"></li>
                    </ul>
                </div>
            </div>
            <div class="btnText">
                <form id="myForm1"  method="post">
                    <label for="camera" class="photoBtn">拍照</label>
                    <input type="file" name="file" id="camera" accept="image/*" capture="camera" >
                </form>
                <form id="myForm2"  method="post">
                    <label for="picture" class="photoBtn">从相册选取相片</label>
                    <input type="file" name="file" id="picture" accept="image/*">
                </form>
            </div>

        </div>
    </div>
    <script type="text/javascript" src="${request.getContextPath()}/resources/chat/m/js/main.js "></script>
</body>

</html>