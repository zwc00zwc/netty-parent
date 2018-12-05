<!DOCTYPE html>
<html class="login">

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="x-dns-prefetch-control" content="on" />
    <title>登录</title>
    <meta name="viewport" content="width=320.1,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no,minimal-ui" />
    <meta name="apple-mobile-web-app-title" content="登录" /><meta name="apple-mobile-web-app-capable" content="yes" />
    <meta content="telephone=no" name="format-detection" />
    <meta name="full-screen" content="yes" />
    <meta name="x5-fullscreen" content="true" />
    <link rel="stylesheet" type="text/css" href="/resources/chat/m/css/mui.css"/>
    <link rel="stylesheet" type="text/css" href="/resources/chat/m/css/main.css" />
</head>

<body>
<header>
    <a href= "index.html" class="back">
        <img src="/resources/chat/m/images/back.png" />
    </a>
    <h1 class="title">登录</h1>
</header>
<div class="loginContent">
    <div class="avatar">
        <img src="/resources/chat/m/images/userSet.png" />
    </div>
    <div class="loginBox">
        <div class="input_row usernameRow">
            <input type="text" id="username" value="" placeholder="用户名/手机号/邮箱" autocomplete="off" />
        </div>
        <div class="input_row passwordRow">
            <input type="password" id="password" value="" placeholder="用户密码" autocomplete="off" />
            <img id="passHidden" class="passHidden" src="/resources/chat/m/images/passHidden.png" onclick="pwdFun1(this)"/>
            <img id="passSee" class="passSee" src="/resources/chat/m/images/passSee.png" onclick="pwdFun2(this)"/>
        </div>
    </div>

    <div class="loginBtn">
        <input class="loginBtn" type="submit" value="登录"  onclick="submit()"/>
    </div>
</div>

</body>
<script>
    var ip='${request.getContextPath()}';
</script>
<script type="text/javascript" src="/resources/chat/m/js/common.js"></script>
<script type="text/javascript" src="/resources/chat/m/js/rem.js"></script>
<script type="text/javascript" src="/resources/chat/m/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/chat/m/js/jquery.cookie.js"></script>
<script type="text/javascript" src="/resources/chat/m/js/mui.js"></script>
<script type="text/javascript">

    function submit(){
        var $username=$("#username").val();
        var $password=$("#password").val();
        var userInfo;
        if($username==''){
            mui.toast("请输入用户名、手机号或者邮箱");
            return $("#username").focus();
        }else if($password==''){
            mui.toast("请输入密码");
            return $("#password").focus();
        }
        $.ajax(logined,{
            data:{
                username:$username,
                password:$password,
            },
            dataType:'json',//服务器返回json格式数据
            type:'post',//HTTP请求类型
            timeout:10000,//超时时间设置为10秒；
            success:function(data){
                console.log(data);
                if(data.success){
                    mui.toast('登录成功');
                    $.cookie('userInfo', null);
                    $.cookie('userInfo1', null);
                    var user=data.result;
                    var userObj=[];
                    userObj.push(user);
                    var objString = JSON.stringify(userObj);
                    $.cookie('userInfo',objString);
                    $t.cookie.set('user_info', JSON.stringify(data.result), 'd7');
                    setTimeout(function(){
                        window.location='/chat/mIndex';
                    },1000)
                }else{
                    mui.toast(data.errorDesc);
                }


            },
            error:function(xhr,type,errorThrown){
                mui.toast('登录失败，请检查您填写的账号和密码');
            }
        });
    }

    function pwdFun1(obj){
        obj.style.display='none';
        $("#passSee").css('display','block');
        document.getElementById("password").type='text';
    }
    function pwdFun2(obj){
        obj.style.display='none';
        $("#passHidden").css('display','block');
        document.getElementById("password").type='password';
    }
</script>

</html>