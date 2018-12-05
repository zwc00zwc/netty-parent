<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" type="text/css" href="${request.getContextPath()}/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${request.getContextPath()}/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${request.getContextPath()}/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${request.getContextPath()}/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="${request.getContextPath()}/h-ui.admin/css/style.css" />
    <title>聊天室服务管理后台</title>
    <meta name="keywords" content="聊天室服务管理后台">
    <meta name="description" content="聊天室服务管理后台">
</head>
<body>
<header class="navbar-wrapper">
    <div class="navbar navbar-fixed-top">
        <div class="container-fluid cl">
            <div class="logo navbar-logo f-l mr-10 hidden-xs" style="font-size: large">聊天室服务管理后台</div>
            <nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
                <ul class="cl">
                    <li class="dropDown dropDown_hover">
                        <a href="#" class="dropDown_A">console<i class="Hui-iconfont">&#xe6d5;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="javascript:loginout();"><span class="glyphicon glyphicon-log-out"></span> 退出</a></li>
                        </ul>
                    </li>
                    <li id="Hui-skin" class="dropDown right dropDown_hover">
                        <a href="javascript:;" class="dropDown_A" title="换肤"><i class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>
                            <li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
                            <li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
                            <li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
                            <li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
                            <li><a href="javascript:;" data-val="orange" title="橙色">橙色</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</header>
<aside class="Hui-aside">
    <div class="menu_dropdown bk_2">
        <dl id="menu-product">
            <dt><i class="Hui-iconfont">&#xe616;</i> 聊天室服务管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="/console/domainConfig" data-title="服务列表" href="javascript:void(0)">服务列表</a></li>
                    <li><a data-href="/console/room" data-title="房间列表" href="javascript:void(0)">房间列表</a></li>
                    <li><a data-href="/console/monitor" data-title="服务器监控列表" href="javascript:void(0)">服务器监控列表</a></li>
                </ul>
            </dd>
        </dl>
    </div>
</aside>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
    <div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
        <div class="Hui-tabNav-wp">
            <ul id="min_title_list" class="acrossTab cl">
                <li class="active">
                    <span title="我的桌面" data-href="">我的桌面</span>
                    <em></em>
                </li>
            </ul>
        </div>
        <div class="Hui-tabNav-more btn-group">
            <a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a>
            <a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a></div>
    </div>
    <div id="iframe_box" class="Hui-article">
        <div class="show_iframe">
            <div style="display:none" class="loading"></div>
            <iframe scrolling="yes" frameborder="0" src="/console/welcome"></iframe>
        </div>
    </div>
</section>

<div class="contextMenu" id="Huiadminmenu">
    <ul>
        <li id="closethis">关闭当前 </li>
        <li id="closeall">关闭全部 </li>
    </ul>
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${request.getContextPath()}/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${request.getContextPath()}/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${request.getContextPath()}/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="${request.getContextPath()}/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${request.getContextPath()}/lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script>
<script type="text/javascript" src="${request.getContextPath()}/js/js.cookie.js"></script>
<script type="text/javascript">
    function loginout() {
        Cookies.remove('console_token');
        location.reload();
    }

    function trimStr(str) {
        if (str) {
            return str.replace(/(^\s*)|(\s*$)/g, "");
        }
        return '';
    }
</script>
</body>
</html>

