<#assign map = websetmap/>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="x-dns-prefetch-control" content="on" />
    <title>${map["web_name"]!''}</title>
    <meta name="viewport" content="width=320.1,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no,minimal-ui" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta content="telephone=no" name="format-detection" />
    <link href="/resources/chat/m/css/mui.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="/resources/chat/m/css/main.css" />
    <link rel="stylesheet" type="text/css" href="/resources/chat/m/css/swiper.min.css" />

    <script>
        if (!/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
            window.location.href = '//' + window.location.host + '/chat/index'
        }
    </script>
</head>

<body>
<header class="">
    <a class="logo"><img src="${map["pc_logo"]!''}" /></a>
    <h1 class="title">${room.roomName!''}</h1>
    <div class="userLogin">
        <span id="userName"><a href="/chat/mlogin" class="userName">登录</a></span>
        <a id="userInfoBtn"  onclick="userInfoPageFun()">
            <img id="indexAvatar" class="indexAvatar" src="/resources/chat/m/images/userSet.png" />
        </a>
    </div>
</header>
<div id="mask" class="mask"></div>
<div id="countBox" class="num"></div>
<nav class="">
    <div class="">
        <ul class="flex navlist justifyContent">
            <li class="active"  >
                <a dataHref="" showValue="true">聊天</a>
            </li>
            <#if tabmenu?exists>
                <#list tabmenu as r>
                    <li>
                        <#if (r.sysType!'0'?number) == 1>
                            <a showValue="true" showId="page2"  openUrl="true" dataHref="${r.sysValue!''}">${r.remark!''}</a>
                            <#else>
                            <a showValue="true" showId="page2"  openUrl="false" dataHref="${r.sysValue!''}">${r.remark!''}</a>
                        </#if>
                    </li>
                </#list>
            </#if>
        </ul>
    </div>
</nav>
<div id="scroll_div" class="fl textAuto">
    <div id="scroll_begin">
        <span class="pad_right">${map["mobile_notice"]!''}</span>
    </div>
    <div id="scroll_end"></div>
</div>
<div id="iframeBox" class="iframeBox" style="background-image:url();-webkit-background-size:100% 100%;background-size:100% 100% ;">
</div>
<#--正在加载div-->
<div id="loading" class="mui-show-loading loading-visible">
    <i class="mui-spinner mui-spinner-white"></i>
    <p class="text">正在加载..</p>
</div>

<div id="container" class="container" style="background-image:url();-webkit-background-size:100% 100%;background-size:100% 100% ;">
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
    <div id="newMessage" class="newMessage" onclick="scrollBottom()">1</div>
    <div id="jionAllList" class="jionAllList">
        <!--<p class="joinList joinList1">欢迎<span>育儿回访来</span>加入聊天室</p>
        <p class="joinList joinList2">欢迎<span>育儿回访来</span>加入聊天室</p>
        <p class="joinList joinList3">欢迎<span>育儿回访来</span>加入聊天室</p>-->
    </div>
    <#--<div  class="forbidden forbiddenYes">聊天室已开启禁言</div>-->
    <#--<div  class="forbidden forbiddenNo">聊天室已关闭禁言</div>-->
    <#--<div  class="revert">你撤回一条消息</div>-->
    <div id="infer" onclick="inferFun()" class="inferBox"><span  class="infer"><span>abc</span>@了你，点击查看</span></div>
</div>
<!--放大图片-->
<div class="big_img">
    <div class="swiper-container2">
        <div class="swiper-wrapper"> </div>
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
<div id="reword" class="reword" >
    <div id="rewordText" class="rewordText mui-ellipsis-2 flex alignItems justifyContent">
        恭喜
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
<div id="redPackBox" class="redPackBox">
    <img id="sendRedbag" src="/resources/chat/m/images/userSet.png" />
    <div id="sendName" class="sendName "></div>
    <div class="sendInfo">发了一个红包，金额随机</div>
    <div id="hasPack" class="hasPack ">
        <div class="sendText"></div>
        <div class="sendNumber "><em id="sendNumber">0</em>元</div>
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
        <#if roomList?exists>
            <#list roomList as r>
                <li><a href="/chat/mIndex?roomId=${r.id!''}">${r.roomName!''}</a></li>
            </#list>
        </#if>
    </ul>
</div>
</div>
<!--<!--我的红包-->
<div id="myPackPage" class="newPage myPack" >
    <div class="header">
        <a onclick="myPackClose()" class="back">
            <img src="/resources/chat/m/images/myPack/back1.png" />
        </a>
        <h1 class="title">我的红包</h1>
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
                领取时间
            </li>
            <li>
                状态
            </li>
        </ul>
        <!--下拉刷新容器-->
        <div id="pullrefresh" class="mui-content mui-scroll-wrapper">
            <div class="mui-scroll">
                <!--数据列表-->

                <ul id="packList" class="packList">
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
        </div>

    </div>
    <footer class="isPack" id="isPack">
        共为您抢了<span id="num">0</span>个红包
    </footer>
</div>

<!--用户中心-->
<div id="userInfoPage" class="newPage userInfoPage">
    <div class="header">
        <a onclick="userInfoClose()" class="back">
            <img src="/resources/chat/m/images/back2.png" />
        </a>
        <h1 class="title">用户中心</h1>
        <div class="edit">
            <a onclick="userPassPageFun()" >
                <img src="/resources/chat/m/images/edit.png" />
            </a>
        </div>
    </div>
    <div class="userInfoContent">
        <div class="topBox">
            <a onclick="userPhotoPageFun()">
                <div class="userInfoAvatar">
                    <img id="iconUser" src="/resources/chat/m/images/userSet.png" />
                </div>
                <div class="editText">点击编辑头像</div>
            </a>
        </div>
        <div class="userInfoBox">
            <div class="userBox">
                <div class="userName">
                    <span class="userTitle">用户名：</span><span id="userNameBox1"></span>
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
        <img src="/resources/chat/m/images/add.png" onclick="addFun()" />
        <img onclick="faceFun()" src="/resources/chat/m/images/face.png" />
        <div>
            <div id="text" contenteditable="true" class="editbox" onkeydown="enterkey()"></div>
            <div class="messageEditor" onclick="isLogin()" id="inputLogin">登录后才能发起聊天哦~</div>
        </div>


        <img src="/resources/chat/m/images/send.png" onclick="send()" />
    </div>
    <!--<input type="file" accept="image/*" capture="camera">
<input type="file" name="file" accept="image/*" >-->

    <div id="oprateBox" class="oprateBox flex">
        <img class="oprateImg" src="/resources/chat/m/images/share.png" onclick="shareFun()" />
        <form class="sendImgForm" id="sendImgForm" method="post">
            <label for="sendImg" class="indexImg"><img src="/resources/chat/m/images/picture.png" /></label>
            <input type="file" name="file" id="sendImg" accept="image/*">
        </form>

    </div>
    <ul id="faceList" class="faceList flex flexWrap spaceAround">
        <li><img datasrc="::A" src="/resources/chat/m/images/face/face1.png" /></li>
        <li><img datasrc="::B" src="/resources/chat/m/images/face/face2.png" /></li>
        <li><img datasrc="::C" src="/resources/chat/m/images/face/face3.png" /></li>
        <li><img datasrc="::D" src="/resources/chat/m/images/face/face4.png" /></li>
        <li><img datasrc="::E" src="/resources/chat/m/images/face/face5.png" /></li>
        <li><img datasrc="::F" src="/resources/chat/m/images/face/face6.png" /></li>
        <li><img datasrc="::G" src="/resources/chat/m/images/face/face7.png" /></li>
        <li><img datasrc="::H" src="/resources/chat/m/images/face/face8.png" /></li>
        <li><img datasrc="::I" src="/resources/chat/m/images/face/face9.png" /></li>
        <li><img datasrc="::J" src="/resources/chat/m/images/face/face10.png" /></li>
        <li><img datasrc="::K" src="/resources/chat/m/images/face/face11.png" /></li>
        <li><img datasrc="::L" src="/resources/chat/m/images/face/face12.png" /></li>
        <li><img datasrc="::M" src="/resources/chat/m/images/face/face13.png" /></li>
        <li><img datasrc="::N" src="/resources/chat/m/images/face/face14.png" /></li>
        <li><img datasrc="::O" src="/resources/chat/m/images/face/face15.png" /></li>
        <li><img datasrc="::P" src="/resources/chat/m/images/face/face16.png" /></li>
        <li><img datasrc="::Q" src="/resources/chat/m/images/face/face17.png" /></li>
        <li><img datasrc="::R" src="/resources/chat/m/images/face/face18.png" /></li>
        <li><img datasrc="::S" src="/resources/chat/m/images/face/face19.png" /></li>
        <li><img datasrc="::T" src="/resources/chat/m/images/face/face20.png" /></li>
        <li><img datasrc="::R" src="/resources/chat/m/images/face/face21.png" /></li>
    </ul>
    <script type="text/javascript">
        var url = document.location;
        var desc = '起点彩票还不错哦~';
        var title = '起点彩票还不错哦';
        var c = "";
        var d = "";
        var e = "";
        var f = "";
        var logo="/resources/chat/m/images/logo.png";

        function shareText() {
            var data = {};
            data.content = "起点彩票";
            testShare(0, data);
        }

        function shareImg() {

            var data = {};
            data.image = "/resources/chat/m/images/logo.png"; //(单纯去分享图片的时候，没有太大限制)
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
            data.image = "/resources/chat/m/images/logo.png";
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
            <img src="/resources/chat/m/images/share/share1.png" />
            <div>QQ好友</div>
            </a>
        </li>
        <li>
            <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=" +url+ "" target="_blank">
            <img src="/resources/chat/m/images/share/share2.png" />
            <div>QQ空间</div>
            </a>

        </li>
        <!--<li>
            <a href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?to=pengyou&url=" +url+ "">
                <img src="/resources/chat/m/images/share/share3.png" />
                <div>朋友网</div>
            </a>
        </li>-->
        <li>
            <a href="http://v.t.qq.com/share/share.php?url=" +url+ "&title="+title+ "&appkey=" + d + "&site=" + f + "&pic=" + e+"">
            <img src="/resources/chat/m/images/share/share4.png" />
            <div>
                腾讯微博
            </div>
            </a>
        </li>
        <li class="bdsharebuttonbox ">
            <a class="bds_weixin " data-cmd="weixin" title="分享到微信 ">
                <!--<img src="/resources/chat/m/images/share/share5.png " />-->
            </a>
            <div>微信好友</div>
        </li>
        <li class="bdsharebuttonbox ">
            <a data-cmd="weixin" title="分享到微信 ">
                <!--<img src="/resources/chat/m/images/share/share6.png " />-->
            </a>
            <div>朋友圈</div>
        </li>
        <li>
            <a onclick="postToXinLang() ">
                <img src="/resources/chat/m/images/share/share7.png " />
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
            <img src="/resources/chat/m/images/back2.png" />
        </a>
        <h1 class="title">修改登录密码</h1>
    </div>
    <div class="passContent">
        <div class="userInfoBox">
            <div class="userBox">
                <div class="userName">
                    <span class="userTitle">用户名：</span><span style="margin-left: 4px;" id="userNameBox2"></span>
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
            <img src="/resources/chat/m/images/back2.png" />
        </a>
        <h1 class="title"></h1>
    </div>
    <div class="userInfoContent">
        <div class="topBox">
            <div class="userInfoAvatar">
                <img id="imgPhoto" src="/resources/chat/m/images/userSet.png" />
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
    <script>
        var domain = '${domainName!''}';
        var roomId = ${room.id!''};
        var ip='${request.getContextPath()}';
    </script>
    <script type="text/javascript" src="/resources/chat/m/js/common.js"></script>
    <script type="text/javascript" src="/resources/chat/m/js/rem.js"></script>
    <script type="text/javascript" src="/resources/chat/m/js/jquery.min.js"></script>
    <script type="text/javascript" src="/resources/chat/m/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="/resources/chat/m/js/mui.js"></script>
    <script type="text/javascript" src="/resources/chat/m/js/dataform.js"></script>
    <script type="text/javascript" src="/resources/chat/m/js/vconsole.min.js"></script>
    <script type="text/javascript" src="/resources/chat/m/js/swiper.min.js"></script>
    <script type="text/javascript" src="/resources/chat/m/js/device.min.js"></script>
    <script type="text/javascript" src="/resources/chat/m/js/main.js"></script>
    <script type="text/javascript">
        var isConsole;
        var query = window.location.search.substring(1);
        if (query) {
            var vars = query.split("&");
            if (vars && vars.length > 0) {
                for (var i = 0; i < vars.length; i++) {
                    var pair = vars[i].split("=");
                    if (pair[0] == 'console') {
                        isConsole = pair[1];
                    }
                }
            }
        }

        if (isConsole == 'true') {
            var vConsole = new VConsole();
        }


     </script>
</body>

</html>