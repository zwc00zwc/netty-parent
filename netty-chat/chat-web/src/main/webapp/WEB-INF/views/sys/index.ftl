<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <#--<link rel="Bookmark" href="/favicon.ico">-->
    <#--<link rel="Shortcut Icon" href="/favicon.ico" />-->
    <link rel="stylesheet" type="text/css" href="${request.getContextPath()}/resources/sys/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${request.getContextPath()}/resources/sys/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${request.getContextPath()}/resources/sys/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${request.getContextPath()}/resources/sys/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="${request.getContextPath()}/resources/sys/static/h-ui.admin/css/style.css" />
    <title>聊天室后台</title>
    <meta name="keywords" content="开奖网系统后台">
    <meta name="description" content="开奖网系统后台">
</head>
<body>
<header class="navbar-wrapper">
    <div class="navbar navbar-fixed-top">
        <div class="container-fluid cl">
            <div class="logo navbar-logo f-l mr-10 hidden-xs" style="font-size: large">聊天室后台</div>
            <nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
                <ul class="cl">
                    <li class="dropDown dropDown_hover">
                        <a href="#" class="dropDown_A">${(user.userName)!''}<i class="Hui-iconfont">&#xe6d5;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="javascript:editPassword();"><span class="glyphicon glyphicon-log-out"></span> 修改密码</a></li>
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

    <#if perms?exists>
        <#list perms as p>
            <dl id="menu-system">
                <dt><i class="Hui-iconfont">${p.url}</i> ${p.name}<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                <dd>
                    <ul>
                        <#if p.list?exists>
                            <#list p.list as s>
                                <li><a data-href="${s.url}" data-title="${s.name}" href="javascript:void(0)">${s.name}</a></li>
                            </#list>
                        </#if>
                    </ul>
                </dd>
            </dl>
        </#list>
    </#if>
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
            <iframe scrolling="yes" frameborder="0" src="/sys/welcome"></iframe>
        </div>
    </div>
</section>

<div class="modal fade" id="editPassword_modal" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header no-padding">
                <div class="table-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">
                        <span class="white">×</span>
                    </button>
                    <span class="modalFormTitle">修改密码</span>
                </div>
            </div>
            <div class="modal-body" style="text-align:center">
                <form class="form form-horizontal" id="form-password-add">
                    <div class="row cl">
                        <label class="form-label col-xs-4 col-sm-2">新密码：</label>
                        <div class="formControls col-xs-8 col-sm-9">
                            <input type="text" class="input-text" value="" id="editPassword">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" onclick="saveCurrPassword();" class="btn btn-primary">提交</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<div class="contextMenu" id="Huiadminmenu">
    <ul>
        <li id="closethis">关闭当前 </li>
        <li id="closeall">关闭全部 </li>
    </ul>
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="${request.getContextPath()}/resources/sys/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${request.getContextPath()}/resources/sys/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="${request.getContextPath()}/resources/sys/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="${request.getContextPath()}/resources/sys/static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="${request.getContextPath()}/resources/sys/lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script>
<script type="text/javascript" src="${request.getContextPath()}/resources/sys/js/js.cookie.js"></script>
<script type="text/javascript">
    /*个人信息*/
    function myselfinfo() {
        layer.open({
            type: 1,
            area: ['300px', '200px'],
            fix: false, //不固定
            maxmin: true,
            shade: 0.4,
            title: '查看信息',
            content: '<div>管理员信息</div>'
        });
    }

    function loginout() {
        Cookies.remove('sys_token');
        location.reload();
    }

    function editPassword() {
        $('#editPassword').val('');
        $('#editPassword_modal').modal('show');
    }

    function saveCurrPassword() {
        var editPassword = $('#editPassword').val();
        if (!trimStr(editPassword)) {
            alert('新密码为空');
            return;
        }
        $.post(
            '/sys/updateCurrentPassword', { "editPassword": trimStr(editPassword) }, function (data) {
                if (data.success) {
                    layer.msg('修改成功', { icon: 1, time: 1000 });
                    $('#editPassword_modal').modal('hide');
                } else {
                    layer.msg(data.errorDesc);
                }
            }
        );
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

