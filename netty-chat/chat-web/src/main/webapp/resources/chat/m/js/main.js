var domain = '47.75.223.217';
var roomId = 5;
var websocket;
var reConnect = true;
var webSocketUrl;
var faceList = document.getElementById("faceList");
var houseList = document.getElementById("houseList");
var shareList = document.getElementById("shareList");
var container = document.getElementById("container");
var showBox = document.getElementById("showBox");
var oprateBox = document.getElementById("oprateBox");
var redPackBox = document.getElementById("redPackBox");
var noPack = document.getElementById("noPack");
var hasPack = document.getElementById("hasPack");
var sendName = document.getElementById("sendName");
var sendNumber = document.getElementById("sendNumber");
var inputLogin = document.getElementById("inputLogin");
var rewordText = document.getElementById("rewordText");
var reword = document.getElementById("reword");
var jionAllList=document.getElementById('jionAllList');
var oul = document.getElementById('messageList');
var userId, userName;
var token = '';
var icon;
//$.cookie('userInfo', null);
//$.cookie('userInfo1', null); 
var userInfo = $.cookie('userInfo');
var userInfo1 = $.cookie('userInfo1');
console.log(userInfo);
//说明所存的用户信息ccookie为数组对象，格式如//[{"roleName":"超级管理员","userName":"fff","userIcon":"随机","userId":18,"token":"f7908d5486974462ba18e724f934ffe9"}]
if(userInfo != undefined && userInfo != null && userInfo != 'null') {
	userInfo = JSON.parse(userInfo);
	userInfo = userInfo[0];
	console.log(userInfo); //{"roleName":"超级管理员","userName":"fff","userIcon":"随机","userId":18,"token":"f7908d5486974462ba18e724f934ffe9"}
	token = userInfo.token;
	userId = userInfo.userId;
	userName = userInfo.userName;
	document.getElementById('userName').style.display = 'none';
	document.getElementById('indexAvatar').style.display = 'block';
	inputLogin.style.display = 'none';
}


$("#faceList li").click(function() {

	$("#text").focus();
	var osrc = $(this).children(0).attr('src');
	var datasrc = $(this).children(0).attr('datasrc');
	var img_url = '<img datasrc="' + datasrc + '" src="' + osrc + '"/>'
	_insertimg(img_url);
})

//表情
var faceObj = {
	'[::A]': 'face1',
	'[::B]': 'face2',
	'[::C]': 'face3',
	'[::D]': 'face4',
	'[::E]': 'face5',
	'[::F]': 'face6',
	'[::G]': 'face7',
	'[::H]': 'face8',
	'[::I]': 'face9',
	'[::J]': 'face10',
	'[::K]': 'face11',
	'[::L]': 'face12',
	'[::M]': 'face13',
	'[::N]': 'face14',
	'[::O]': 'face15',
	'[::P]': 'face16',
	'[::Q]': 'face17',
	'[::R]': 'face18',
	'[::S]': 'face19',
	'[::T]': 'face20',
	'[::U]': 'face21',
}

//点击聊天室
$("#chatHouse").click(function() {
	$("#chatHouseBox").css({
		'display': 'block'
	})
	$("#mask").css({
		'display': 'block'
	})
})
$("#redPackBtn").click(function() {
	$("#myPackBox").css({
		'display': 'block'
	})
	$("#mask").css({
		'display': 'block'
	})
})
$("#myPackBtn1,#myPackBtn2").click(function() {
	$("#myPackBox").css({
		'display': 'none'
	})
	$("#mask").css({
		'display': 'none'
	})
	$("#myPackPage").show();
})

function myPackClose(){
	$("#myPackPage").hide();
}
function userInfoClose(){
	$("#userInfoPage").hide();
}
function userPhotoClose(){
	$("#userPhotoPage").hide();
}
function userPassClose(){
	$("#userPassPage").hide();
}
function userInfoPageFun(){
	$("#userInfoPage").show();
}
function userPassPageFun(){
	$("#userPassPage").show();
}
function userPhotoPageFun(){
	$("#userPhotoPage").show();
}
$("#mask").click(function() {
	$("#chatHouseBox").css({
		'display': 'none'
	})
	$("#myPackBox").css({
		'display': 'none'
	})
	$("#redPackBox").css({
		'display': 'none'
	})
	$("#reword").css({
		'display': 'none'
	})
	$("#mask").css({
		'display': 'none'
	})
})
//文字横向滚动
function ScrollImgLeft() {
	var speed = 50; //初始化速度 也就是字体的整体滚动速度
	var MyMar = null; //初始化一个变量为空 用来存放获取到的文本内容
	var scroll_begin = document.getElementById("scroll_begin"); //获取滚动的开头id
	var scroll_end = document.getElementById("scroll_end"); //获取滚动的结束id
	var scroll_div = document.getElementById("scroll_div"); //获取整体的开头id
	scroll_end.innerHTML = scroll_begin.innerHTML; //滚动的是html内部的内容,原生知识!
	//定义一个方法
	function Marquee() {
		if(scroll_end.offsetWidth - scroll_div.scrollLeft <= 0)
			scroll_div.scrollLeft -= scroll_begin.offsetWidth;
		else
			scroll_div.scrollLeft++;

	}
	MyMar = setInterval(Marquee, speed); //给上面的方法设置时间  setInterval
	//鼠标点击这条公告栏的时候,清除上面的方法,让公告栏暂停
	scroll_div.onmouseover = function() {
		clearInterval(MyMar);
	}
	//鼠标点击其他地方的时候,公告栏继续运动
	scroll_div.onmouseout = function() {
		MyMar = setInterval(Marquee, speed);
	}
}
ScrollImgLeft();
window.onload = function() {
	connectSocket();
	reConnectSocket();
}
$.ajax(webSocketUrlPort, {
		data: {},
		dataType: 'json', //服务器返回json格式数据
		type: 'post', //HTTP请求类型
		timeout: 10000, //超时时间设置为10秒；
		success: function(data) {
			console.log(data);
			if(data.success) {
				webSocketUrl = data.result;
			} else {
				mui.toast(data.errorDesc);
			}
			},
			error: function(xhr, type, errorThrown) {}
		});
			function connectSocket() {
				if(!window.WebSocket && !window.WebSocket.prototype.send) {
					mui.toast("当前浏览器不支持websocket");
					return;
				}
				var protocolStr = document.location.protocol;
				//判断当前浏览器是否支持WebSocket
				try {
					var socketurl;
					socketurl = webSocketUrl + '/?token=' + token + '&domain=' + domain + '&roomId=' + roomId + '';
					websocket = new WebSocket(socketurl); //连接服务器
					websocket.onopen = function(event) {
						console.log("已经与服务器建立了连接当前连接状态：" + this.readyState);
						//console.log(event);
						console.log("用户信息：");
						console.log(userInfo);
						//加入房间
						var msg = {
							Id: userId,
							UserName: userName,
							RoleIcon: '',
							Icon: icon,
							Commond: 'S_JOIN_ROOM',
							Token: token
						};
						if(websocket && websocket.readyState == 1) {
							websocket.send(JSON.stringify(msg));
						} else {
							console.log('当前webSocket服务状态为' + websocket.readyState);
						}
						heartConnect();
					};
					//接收消息
					websocket.onmessage = function(event) {
						isNew = true;
						console.log("接收到服务器发送的数据：");
						message(event);
					};
					//与服务器断开连接
					websocket.onclose = function(event) {
						console.log("已经与服务器断开连接当前连接状态：" + this.readyState);
					};
					//连接异常
					websocket.onerror = function(event) {
						console.log("WebSocket异常！");
					};

				} catch(ex) {
					console.log("连接socket异常" + ex);
				}
			}



//心跳发送
function heartConnect() {
	setTimeout(function() {
		//发送心跳消息
		var payload = {
			Id: userId,
			Commond: 'S_HEART_BEAT',
			Token: token
		};
		var jStr = JSON.stringify(payload);
		if(websocket && websocket.readyState == 1) {
			websocket.send(jStr)
		}
		heartConnect();
	}, 10000);
}

//重连
function reConnectSocket() {
	setTimeout(function() {
		if((!websocket || websocket.readyState == 3) && reConnect) {
			console.log("正在重连！");
			connectSocket();
			if(websocket && websocket.readyState == 1) {
				console.log("重新连接成功！");
			}
		}
		reConnectSocket();
	}, 5000);
}

function addFun() {
	if(oprateBox.style.display == 'flex') {
		oprateBox.style.display = 'none';
	} else {
		oprateBox.style.display = 'flex';
	}
	shareList.style.display = 'none';
	faceList.style.display = 'none';

}

function shareFun() {
	oprateBox.style.display = "none";
	shareList.style.display = 'flex';
	faceList.style.display = 'none';
}

function faceFun() {
	if(faceList.style.display == 'flex') {
		faceList.style.display = 'none';
	} else {
		faceList.style.display = 'flex';
	}
	shareList.style.display = "none";
	oprateBox.style.display = "none";
}

//接收到消息的回调方法
var oimg;

function message(event) {
	var data = JSON.parse(event.data);
	console.log(data);
	if(data.command == 'S_HISTORY_CHAT') {
		oul.innerHTML='';
		data.content.forEach(function(item, index) {
			var item = JSON.parse(item);
			var avatar = item.userIcon || 'images/userSet.png';
			if(item.userIcon == '随机') {
				avatar = 'images/userSet.png';
			}
			var userName = item.userName || '';
			if(item.command == 'S_MESSAGE') { //这里表示普通消息记录
				var odiv = document.createElement('div'); //反转义开始
				var a = item.content;
				var c = document.createElement('div');
				c.innerHTML = a;
				a = c.innerText || c.textContent; ///反转义结束
				content = c.innerText || c.textContent;
				if(a.match(/<img class="uploadImg"  src=".*?"/g)) { //如果是图片消息
					if(item.userId == userId) {
						if(item.userIcon && item.userIcon.match(/userIcon.*?/g)) {
							oimg = '<div  class="rightAvatar  userIcon  ' + icon + '" ></div>';
						} else {
							oimg = '<img class="rightAvatar" src="' + avatar + '" />';
						}
						odiv.className = 'rightRecieve flex flexEnd';
						odiv.innerHTML = '<div class="reciever">' +
							oimg +
							'<div class="content uploadImgContent  mui-clearfix" style="float: right;">' +
							'<div class="userInfo">' +
							'<span>' + item.messageTime + '</span>' +
							'</div>' +
							'<div class="textcontent  mui-clearfix">' +
							'<div class="rightTriangle"></div>' + content +
							'</div>' +
							'</div>' +
							'</div>';
					} else {
						if(item.userIcon && item.userIcon.match(/userIcon.*?/g)) {
							oimg = '<div  class="leftAvatar  userIcon  ' + item.userIcon + '" ></div>';
						} else {
							oimg = '<img class="leftAvatar" src="' + avatar + '" />';
						}
						odiv.className = 'leftRecieve flex flexStart';
						odiv.innerHTML = '<div class="reciever">' +
							oimg +
							'<div class="content uploadImgContent  mui-clearfix">' +
							'<div class="userInfo">' +
							'<span class="userName">' + userName + '</span><span>' + item.messageTime + '</span>' +
							'</div>' +
							'<div class="textcontent mui-clearfix">' +
							'<div class="leftTriangle"></div>' +
							content +
							'</div>' +
							'</div>' +
							'</div>';
					}
				} else { //一般的文字和表情消息
					var reg = /\[.+?\]/g; //匹配表情
					a = a.replace(reg, function(d, b) {
						return '<img src="images/face/' + faceObj[d] + '.png"/>';
					});
					if(item.userId == userId) {
						if(item.userIcon && item.userIcon.match(/userIcon.*?/g)) {
							oimg = '<div  class="rightAvatar  userIcon  ' + item.userIcon + '" ></div>';
						} else {
							oimg = '<img class="rightAvatar" src="' + avatar + '" />';
						}
						odiv.className = 'rightRecieve flex flexEnd';
						odiv.innerHTML = '<div class="reciever">' +
							oimg +
							'<div class="content  mui-clearfix" style="float: right;">' +
							'<div class="userInfo">' +
							'<span>' + item.messageTime + '</span>' +
							'</div>' +
							'<div class="textcontent mui-clearfix">' +
							'<div class="rightTriangle"></div>' + a +
							'</div>' +
							'</div>' +
							'</div>';
					} else {
						if(item.userIcon && item.userIcon.match(/userIcon.*?/g)) {
							oimg = '<div  class="leftAvatar  userIcon  ' + item.userIcon + '" ></div>';
						} else {
							oimg = '<img class="leftAvatar" src="' + avatar + '" />';
						}
						odiv.className = 'leftRecieve flex flexStart';
						odiv.innerHTML = '<div class="reciever">' +
							oimg +
							'<div class="content  mui-clearfix">' +
							'<div class="userInfo">' +
							'<span class="userName">' + userName + '</span><span>' + item.messageTime + '</span>' +
							'</div>' +
							'<div class="textcontent">' +
							'<div class="leftTriangle"></div>' +
							a +
							'</div>' +
							'</div>' +
							'</div>';
					}
				}

				oul.insertBefore(odiv, oul.children[0]);
			} else { //这里是红包记录
				if(item.userId == userId) {
					if(item.userIcon && item.userIcon.match(/userIcon.*?/g)) {
					oimg = '<div  class="rightAvatar  userIcon  ' + item.userIcon + '" ></div>';
					} else {
						oimg = '<img class="rightAvatar" src="' + avatar + '" />';
					}
					var odiv = document.createElement('div');
					odiv.className = 'rightRecieve flex flexStart';
					odiv.innerHTML = '<div class="reciever redPack" redbagId=' + item.content.redbagId + '>' +
						oimg +
						'<div class="content  mui-clearfix"  style="float: right;">' +
						'<div class="userInfo">' +
						'<span class="userName">' + item.userName + '</span><span>' + item.messageTime + '</span>' +
						'</div>' +
						'<div class="textcontent  mui-clearfix" onclick="getPack(' + item.content.redbagId + ')">' +
						'<div class="rightTriangle"></div>' +
						'<div class="flex alignItems">' +
						'<img class="packIcon" src="/resources/chat/m/images/redPack.png"/>' +
						'<div class="">' +
						'<p class="packP1">' + userName + '的红包</p>' +
						'<p class="packP2">领取红包</p>' +
						'</div>' +
						'</div>' +
						'<p class="packP3">聊天室的红包</p>' +
						'</div>' +
						'</div>' +
						'</div>';
				}else{
					if(item.userIcon && item.userIcon.match(/userIcon.*?/g)) {
					oimg = '<div  class="leftAvatar  userIcon  ' + item.userIcon + '" ></div>';
					} else {
						oimg = '<img class="leftAvatar" src="' + avatar + '" />';
					}
					var odiv = document.createElement('div');
					odiv.className = 'leftRecieve flex flexStart';
					odiv.innerHTML = '<div class="reciever redPack" redbagId=' + item.content.redbagId + '>' +
						oimg +
						'<div class="content" >' +
						'<div class="userInfo">' +
						'<span class="userName">' + item.userName + '</span><span>' + item.messageTime + '</span>' +
						'</div>' +
						'<div class="textcontent  mui-clearfix" onclick="getPack(' + item.content.redbagId + ')">' +
						'<div class="leftTriangle"></div>' +
						'<div class="flex alignItems">' +
						'<img class="packIcon" src="/resources/chat/m/images/redPack.png"/>' +
						'<div class="">' +
						'<p class="packP1">' + userName + '的红包</p>' +
						'<p class="packP2">领取红包</p>' +
						'</div>' +
						'</div>' +
						'<p class="packP3">聊天室的红包</p>' +
						'</div>' +
						'</div>' +
						'</div>';
				}
				
				oul.insertBefore(odiv, oul.children[0]);
			}

		})
		oul.scrollTop = oul.scrollHeight;
	} else if(data.command == "S_JOIN_ROOM") {
		var op = document.createElement('p');
		op.className = 'joinList joinList1';
		op.innerHTML = '欢迎<span>' + data.userName + '</span>加入聊天室';
		jionAllList.appendChild(op);
		setTimeout(function() {
			$(".joinList").hide();
		}, 1500);
	} else if(data.command == "S_MESSAGE") { //这里是接受到消息

		var avatar = data.userIcon || 'images/userSet.png';
		if(data.userIcon == '随机') {
			avatar = 'images/userSet.png';
		}
		var userName = data.userName || '';
		var odiv = document.createElement('div');
		var a = data.content; ///反转义开始
		var c = document.createElement('div');
		c.innerHTML = a;
		a = c.innerText || c.textContent; ///反转义结束
		content = c.innerText || c.textContent;
		if(a.match(/<img class="uploadImg"  src=".*?"/g)) { //如果是图片消息
			if(data.userId == userId) {
				if(data.userIcon && data.userIcon.match(/userIcon.*?/g)) {
					oimg = '<div  class="rightAvatar  userIcon  ' + data.userIcon + '" ></div>';
				} else {
					oimg = '<img class="rightAvatar" src="' + avatar + '" />';
				}
				odiv.className = 'rightRecieve flex flexEnd';
				odiv.innerHTML = '<div class="reciever">' +
					oimg +
					'<div class="content uploadImgContent  mui-clearfix" style="float: right;">' +
					'<div class="userInfo">' +
					'<span>' + data.messageTime + '</span>' +
					'</div>' +
					'<div class="textcontent  mui-clearfix">' +
					'<div class="rightTriangle"></div>' + content +
					'</div>' +
					'</div>' +
					'</div>';
			} else {
				if(data.userIcon && data.userIcon.match(/userIcon.*?/g)) {
					oimg = '<div  class="leftAvatar  userIcon  ' + data.userIcon + '" ></div>';
				} else {
					oimg = '<img class="leftAvatar" src="' + avatar + '" />';
				}
				odiv.className = 'leftRecieve flex flexStart';
				odiv.innerHTML = '<div class="reciever">' +
					oimg +
					'<div class="content uploadImgContent">' +
					'<div class="userInfo">' +
					'<span class="userName">' + userName + '</span><span>' + data.messageTime + '</span>' +
					'</div>' +
					'<div class="textcontent">' +
					'<div class="leftTriangle"></div>' +
					content +
					'</div>' +
					'</div>' +
					'</div>';
			}
		} else { //文字消息
			var reg = /\[.+?\]/g;
			a = a.replace(reg, function(c, b) {
				return '<img src="images/face/' + faceObj[c] + '.png"/>';
			});

			if(data.userId == userId) {
				if(data.userIcon && data.userIcon.match(/userIcon.*?/g)) {
					oimg = '<div  class="rightAvatar  userIcon  ' + data.userIcon + '" ></div>';
				} else {
					oimg = '<img class="rightAvatar" src="' + avatar + '" />';
				}
				odiv.className = 'rightRecieve flex flexEnd';
				odiv.innerHTML = '<div class="reciever">' +
					oimg +
					'<div class="content" style="float: right;">' +
					'<div class="userInfo">' +
					'<span>' + data.messageTime + '</span>' +
					'</div>' +
					'<div class="textcontent">' +
					'<div class="rightTriangle"></div>' +
					a +
					'</div>' +
					'</div>' +
					'</div>';
				document.getElementById('text').innerHTML = '';
				faceList.style.display = "none";
			} else {
				if(data.userIcon && data.userIcon.match(/userIcon.*?/g)) {
					oimg = '<div  class="leftAvatar  userIcon  ' + data.userIcon + '" ></div>';
				} else {
					oimg = '<img class="leftAvatar" src="' + avatar + '" />';
				}
				odiv.className = 'leftRecieve flex flexStart';
				odiv.innerHTML = '<div class="reciever">' +
					oimg +
					'<div class="content">' +
					'<div class="userInfo">' +
					'<span class="userName">' + userName + '</span><span>' + data.messageTime + '</span>' +
					'</div>' +
					'<div class="textcontent">' +
					'<div class="leftTriangle"></div>' +
					a +
					'</div>' +
					'</div>' +
					'</div>';
			}
		}

		oul.appendChild(odiv);
		oul.scrollTop = oul.scrollHeight;
		faceList.style.display = 'none';
		shareList.style.display = 'none';
		oprateBox.style.display = 'none';
	} else if(data.command == "S_RECEIVE_REDBAG") {
		if(data.content.amount && data.content.amount > 0) {
			var odiv = document.createElement('div');
			odiv.className = 'getRedBox';
			odiv.innerHTML = '<span class="getRed">你已领取' + data.content.sendName + '的</em><em>红包</em></span>';
			oul.appendChild(odiv);
			sendNumber.innerHTML = data.content.amount;
			sendName.innerHTML = data.content.sendName;
			noPack.style.display = 'none';
			hasPack.style.display = 'block';
			redPackBox.style.display = 'block';
			mask.style.display = 'block';
		}
	} else if(data.command == "S_REDBAG_OUT") {
		var odiv = document.createElement('div');
		noPack.style.display = 'block';
		hasPack.style.display = 'none';
		redPackBox.style.display = 'block';
		mask.style.display = 'block';
	} else if(data.command == 'S_LOTTERY_GOODNEWS') {
		reword.style.display = 'block';
		rewordText.innerHTML = data.content;
		mask.style.display = 'block';
	} else if(data.command == 'S_LOGIN_INFO_LOSE') {
		mui.alert('登录信息失效', '', function() {
			$.cookie('userInfo', null);
			$.cookie('userInfo1', null);
			reConnect = false;
			location.reload();
		});
	}else if(data.command=='S_IP_ERROR'){//ip限制
		mui.alert('当前Ip已被限制', '', function() {
			$.cookie('userInfo', null);
			$.cookie('userInfo1', null);
			reConnect = false;
			//location.reload();
		});
	}
	else if(data.content.redbagId) {
		var avatar = data.userIcon || 'images/userSet.png';
		if(data.userIcon == '随机') {
			avatar = 'images/userSet.png';
		}
		var odiv = document.createElement('div');
		odiv.className = 'leftRecieve flex flexStart';
		odiv.innerHTML = '<div class="reciever redPack" redbagId=' + data.content.redbagId + '>' +
			'<img class="leftAvatar" src="' + avatar + '" />' +
			'<div class="content">' +
			'<div class="userInfo">' +
			'<span class="userName">' + data.userName + '</span><span>' + data.messageTime + '</span>' +
			'</div>' +
			'<div class="textcontent" onclick="getPack(' + data.content.redbagId + ')">' +
			'<div class="leftTriangle"></div>' +
			'<div class="flex alignItems">' +
			'<img class="packIcon" src="/resources/chat/m/images/redPack.png"/>' +
			'<div class="">' +
			'<p class="packP1">' + data.userName + '的红包</p>' +
			'<p class="packP2">领取红包</p>' +
			'</div>' +
			'</div>' +
			'<p class="packP3">聊天室的红包</p>' +
			'</div>' +
			'</div>' +
			'</div>';
		oul.appendChild(odiv);
		oul.scrollTop = oul.scrollHeight;
	}

}

function conFun() {
	faceList.style.display = 'none';
	shareList.style.display = 'none';
	oprateBox.style.display = 'none';
}

function isLogin() {
	if(userInfo == undefined || userInfo == null || userInfo == 'null') {
		mui.toast("需先登录才能发送消息哦~");
		setTimeout(function() {
			window.location = '/chat/mlogin';
		}, 800)
	}
}
//发送图片
document.getElementById("sendImg").onchange = function(evt) {
	if(userInfo == undefined || userInfo == null || userInfo == 'null') {
		mui.toast('要先登录才能发送图片哦~')
		setTimeout(function() {
			window.location = '/chat/mlogin';
		}, 1000);
		return;
	}
	var form = document.getElementById("sendImgForm");
	var formData = new FormData(form);
	formData.append("token", token);
	$.ajax(uploadTempImg, {
		data: formData,
		type: 'post', //HTTP请求类型
		timeout: 10000, //超时时间设置为10秒；
		processData: false, // 告诉jQuery不要去处理发送的数据
		contentType: false,
		success: function(data) {
			console.log(data);
			if(data.success) {
				var chatImg = data.result;
				var Content = '<img class="uploadImg"  src="' + chatImg + '" >';
				if(websocket.readyState == 1) {
					var msg = {
						command: 'C_MESSAGE',
						domain: domain,
						roomId: roomId,
						content: Content,
						token: token,
						userIcon: icon,
						userName: userName,
						userId: userId
					};
					websocket.send(JSON.stringify(msg));
				} else {
					console.log("连接状态为" + websocket.readyState + "");
				}
			} else {
				mui.toast(data.errorDesc);
			}
		},
		error: function(xhr, type, errorThrown) {}
	});

}

//发送消息
function send() {
	if(userInfo == undefined || userInfo == null || userInfo == 'null') {
		mui.toast('要先登录才能发送消息哦~')
		setTimeout(function() {
			window.location = 'login.html';
		}, 1000);
	}
	var message = document.getElementById('text').innerHTML;
	if(message == "") {
		mui.toast("写些内容再发表吧~");
		return;
	}
	attrReg = /datasrc=[\'\"]?([^\'\"]*)[\'\"]?/i;
	Content = '';
	console.log('message == ', message)
	Content = message.replace(/<img(?:.|\s)*?>/gi, function(item) {
		return '[' + item.match(attrReg)[1] + ']'
	})
	console.log(Content);
	if(websocket.readyState == 1) {
		var msg = {
			command: 'C_MESSAGE',
			domain: domain,
			roomId: roomId,
			content: Content,
			token: token,
			userIcon: icon,
			userName: userName,
			userId: userId
		};
		websocket.send(JSON.stringify(msg));
	} else {
		console.log("连接状态为" + websocket.readyState + "");
	}
}

//领取红包
function getPack(redbagId) {
	if(userInfo == undefined || userInfo == null || userInfo == 'null') {
		mui.toast("需先登录才能领取红包哦~")
		return;
	}
	if(websocket.readyState == 1) {
		var msg = {
			"command": "RECEIVE_REDBAG",
			"domain": domain,
			"roomId": roomId,
			"token": token,
			"userId": userId,
			"userName": userName,
			"userIcon": icon,
			"roleIcon": "roleicon",
			"roleName": "计划员",
			"content": {
				"redbagId": redbagId
			}
		}
		websocket.send(JSON.stringify(msg));
	} else {
		console.log("连接状态为" + websocket.readyState + "");
	}

}

$.ajax(ajaxRooms, {
	data: {},
	dataType: 'json', //服务器返回json格式数据
	type: 'get', //HTTP请求类型
	timeout: 10000, //超时时间设置为10秒；
	success: function(data) {
		console.log(data);
		data.list.forEach(function(item, index) {
			var oli = document.createElement('li');
			oli.innerHTML = '<a onclick="room(' + item.id + ')">' + item.roomName + '</a>';
			houseList.appendChild(oli);
		})
	},
	error: function(xhr, type, errorThrown) {
		//mui.toast('请求失败');
	}
});

function room(roomId) {
	document.getElementById("chatHouseBox").style.display = 'none';
	roomId = 5;
	connectSocket();
}

function shareSina() {
	//分享到新浪微博
	var sharesinastring = 'http://service.weibo.com/share/share.php?title=' + $("#title").val() + '&url=' + $("#url").val();
	window.location.href = sharesinastring;
}

function shareQQzone() {
	var p = {
		url: location.href,
		showcount: '0',
		/*是否显示分享总数,显示：'1'，不显示：'0' */
		desc: '',
		/*默认分享理由(可选)*/
		summary: '',
		/*分享摘要(可选)*/
		title: '',
		/*分享标题(可选)*/
		site: '满艺网',
		/*分享来源 如：腾讯网(可选)*/
		pics: '',
		/*分享图片的路径(可选)*/
		style: '203',
		width: 98,
		height: 22
	};
	//分享到QQ空间
	var sharesinastring = 'http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?title=' + $("#title").val() + '&url=' + $("#url").val() + '&site="满艺网"';
	window.location.href = sharesinastring;
}

function shareQQ() {
	var p = {
		url: location.href,
		/*获取URL，可加上来自分享到QQ标识，方便统计*/
		desc: '',
		/*分享理由(风格应模拟用户对话),支持多分享语随机展现（使用|分隔）*/
		title: '',
		/*分享标题(可选)*/
		summary: '',
		/*分享摘要(可选)*/
		pics: '',
		/*分享图片(可选)*/
		flash: '',
		/*视频地址(可选)*/
		site: '满艺网',
		/*分享来源(可选) 如：QQ分享*/
		style: '201',
		width: 32,
		height: 32
	};
	//分享到QQ
	var sharesinastring = 'http://connect.qq.com/widget/shareqq/index.html?title=' + $("#title").val() + '&summary=' + $("#url").val() + '&url=' + $("#url").val() + '&site="满艺网"';
	window.location.href = sharesinastring;
}

function shareQQweibo() {
	var p = {
		url: location.href,
		/*获取URL，可加上来自分享到QQ标识，方便统计*/
		title: '',
		/*分享标题(可选)*/
		pic: '',
		/*分享图片(可选)*/
		site: '满艺网' /*分享来源(可选) 如：QQ分享*/
	};
	//分享到腾讯微博
	var sharesinastring = 'http://v.t.qq.com/share/share.php?title=' + $("#title").val() + '&url=' + $("#url").val() + '&site="满艺网"';
	window.location.href = sharesinastring;
}

//以下为我的红包
	    var packList=document.getElementById("packList");
	    var num=document.getElementById("num");
	    var total=document.getElementById("total");
		$.ajax(ajaxReceiveRedBag,{
					data:{
						token:token
					},
					dataType:'json',//服务器返回json格式数据
					type:'post',//HTTP请求类型
					timeout:10000,//超时时间设置为10秒；
					success:function(data){
						console.log(data);
						var sum=0
						if(data.list){
						num.innerHTML=data.list.length;
						data.list.forEach(function(item, index){
						sum+=item.amount;
						total.innerHTML=sum;
						var oli = document.createElement('li');
						oli.className = 'flex spaceAround';
						var updateTime=item.updateTime?new Date(item.updateTime).Format("yyyy-MM-dd"):''
						oli.innerHTML = '<div class="packId">'+item.id+'</div>'+
								'<div class="price">'+item.amount+'元</div>'+
								'<div class="time">'+updateTime+'</div>';
								if(item.status==1){
									oli.innerHTML+='<div class="status2">未兑换</div>';
								}else if(item.status==2){
									oli.innerHTML+='<div class="status2">已兑换</div>';
								}
								packList.appendChild(oli);
						})
						}
					},
					error:function(xhr,type,errorThrown){
						 mui.toast('请求失败');
					}
				});
//以下为用户信息
			var userNameBox = document.getElementById("userNameBox1");
			var roleNameBox = document.getElementById("roleNameBox");
			var regTime = document.getElementById("regTime");
			var loginIp = document.getElementById("loginIp");
			var iconUser = document.getElementById("iconUser");

			$.ajax(userInfoPort, {
				data: {
					token: token
				},
				dataType: 'json', //服务器返回json格式数据
				type: 'post', //HTTP请求类型
				timeout: 10000, //超时时间设置为10秒；
				success: function(data) {
					console.log(data);
					if(data.success) {
						var user = data.result;
						var userObj = [];
						userObj.push(user);
						var objString = JSON.stringify(userObj);
						$.cookie('userInfo1', objString);
						userNameBox.innerHTML = data.result.userName;
						roleNameBox.innerHTML = data.result.roleName;
						regTime.innerHTML = new Date(data.result.createTime).Format("yyyy-MM-dd hh:mm:ss");
						loginIp.innerHTML = data.result.loginIp;
						
						icon = data.result.icon; 
						iconUser.src = data.result.icon || 'images/userSet.png';
						document.getElementById("indexAvatar").src= data.result.icon || 'images/userSet.png';
						document.getElementById("imgPhoto").src= data.result.icon || 'images/userSet.png';
						if(data.result.icon == '随机') {
							iconUser.src = 'images/userSet.png';
							document.getElementById("indexAvatar").src='images/userSet.png';
							document.getElementById("imgPhoto").src='images/userSet.png';
						}
						var icon1 = data.result.icon;
						if(icon1.match(/userIcon.*?/g)) {
							icon1 = 'images/defalt/' + data.result.icon + '.png';
							iconUser.src = icon1;
							document.getElementById("indexAvatar").src=icon1;
							document.getElementById("imgPhoto").src=icon1;
						}
					} else {
						mui.toast(data.errorDesc);
					}

				},
				error: function(xhr, type, errorThrown) {
					mui.toast('登录失败，请检查您填写的账号和密码');
				}
			});
			
			
				//以下为修改密码
				var token,userName;
				var userNameBox2= $("#userNameBox2");
				var oldPassword = document.getElementById("oldPassword");
				var firstPassword = document.getElementById("firstPassword");
				var secondPassword = document.getElementById("secondPassword");
			    if(userInfo != undefined && userInfo != null&& userInfo != 'null') {
					userName=userInfo.userName;
					userNameBox2.html(userName);
			    }
			    
			function submit() {
				if(oldPassword.value == '') {
					mui.toast("请输入原始密码");
					return $("#$oldPassword").focus();
				} 
				if(firstPassword.value == '') {
					mui.toast("请输入新密码");
					return $("#$firstPassword").focus();
				}else{
					if(firstPassword.value.length < 6) {
						mui.toast('请输入至少6位密码！');
						return firstPassword.value='';
					}
				}	
				if(secondPassword.value == '') {
					mui.toast("请确认新密码"); 
					return $("#secondPassword").focus();
				}else{
					if(firstPassword.value != secondPassword.value) {
						mui.toast('两次密码不一致');
						return secondPassword.value = "";
					}
				}
				console.log(token);
				$.ajax(updatePassword, {
					data: {
						token:token,
						oldPassword: oldPassword.value,
						firstPassword: firstPassword.value,
						secondPassword:secondPassword.value,
					},
					dataType: 'json', //服务器返回json格式数据
					type: 'post', //HTTP请求类型
					timeout: 10000, //超时时间设置为10秒；
					success: function(data) {
						console.log(data);
						if(data.success){
							mui.toast('修改密码成功');
							setTimeout(function() {
							userPassClose();
						}, 1000)
						}else{
							mui.toast(data.errorDesc);
						}
						
					},
					error: function(xhr, type, errorThrown) {
						mui.toast('登录失败，请检查您填写的账号和密码');
					}
				});
			}
			function reset(){
				 $("#oldPassword").val('');
				$("#firstPassword").val('');
				 $("#secondPassword").val('');
			}
			
			
		//以下为修改头像部分
				var userIconPhoto;
			    
			//相册    
			document.getElementById("picture").onchange = function(evt) {
				if(!window.FileReader)
					return;
				var files = evt.target.files;
				for(var i = 0, f; f = files[i]; i++) {
					if(!f.type.match('image.*')) {
						continue;
					}
					var reader = new FileReader();
					reader.onload = (function(theFile) {
						return function(e) {
							document.getElementById("imgPhoto").src = e.target.result;
						};
					})(f);
					reader.readAsDataURL(f);
				}
				var form = document.getElementById("myForm2");
				var formData = new FormData(form);
				formData.append("token",token);
			    $.ajax(uploadForeverImg,{
						data:formData,
						type:'post',//HTTP请求类型
						timeout:10000,//超时时间设置为10秒；
						processData: false,  // 告诉jQuery不要去处理发送的数据
				        contentType: false,  
						success:function(data){
							console.log(data);
							if(data.success){
								userIconPhoto=data.result;
								updateIconFun();
							}else{
							mui.toast(data.errorDesc);
							}
						},
						error:function(xhr,type,errorThrown){
						}
					}); 

			}
			//相机
			document.getElementById("camera").onchange = function(evt) {
				if(!window.FileReader)
					return;
				var files = evt.target.files;
				for(var i = 0, f; f = files[i]; i++) {
					if(!f.type.match('image.*')) {
						continue;
					}
					var reader = new FileReader();
					reader.onload = (function(theFile) {
						return function(e) {
							document.getElementById("imgPhoto").src = e.target.result;
						};
					})(f);
					reader.readAsDataURL(f);
				}
				var form = document.getElementById("myForm1");
				var formData = new FormData(form);
				formData.append("token",token);
			    $.ajax(uploadForeverImg,{
						data:formData,
						type:'post',//HTTP请求类型
						timeout:10000,
						processData: false,  
				        contentType: false,  
						success:function(data){
							console.log(data);
							if(data.success){
								userIconPhoto=data.result;
								updateIconFun();
							}else{
							mui.toast(data.errorDesc);
							}
							
						},
						error:function(xhr,type,errorThrown){
						}
					});

			}
			
			function updateIconFun(){
				$.ajax(updateIconPort, {
					data: {
						token:token,
						icon:userIconPhoto
					},
					dataType: 'json', 
					type: 'post', 
					timeout: 10000, 
					success: function(data) {
						console.log(data);
						if(data.success){
							mui.toast("头像上传成功");
							icon=userIconPhoto;
							if(userIconPhoto.match(/userIcon.*?/g)) {
								document.getElementById('indexAvatar').src='images/defalt/'+userIconPhoto+'.png';
								document.getElementById('iconUser').src='images/defalt/'+userIconPhoto+'.png';
							}else{
								document.getElementById('indexAvatar').src=userIconPhoto
								document.getElementById('iconUser').src=userIconPhoto;
							}
							
							setTimeout(function(){
									userPhotoClose()();
								},1000)
						}else{
							mui.toast(data.errorDesc);
						}
					},
					error: function(xhr, type, errorThrown) {
					}
				});
			}
			
			$(".photoList li").click(function(){
				 userIconPhoto=$(this).attr('class');
				 document.getElementById("imgPhoto").src='images/defalt/'+userIconPhoto+'.png';
				 updateIconFun();
			})

		
			
//以下部分为监听光标的位置
function pasteHandler() {

	setTimeout(function() {

		var content = document.getElementById("testdiv").innerHTML;

		valiHTML = ["br"];

		content = content.replace(/_moz_dirty=""/gi, "").replace(/\[/g, "[[-").replace(/\]/g, "-]]").replace(/<\/ ?tr[^>]*>/gi, "[br]").replace(/<\/ ?td[^>]*>/gi, "&nbsp;&nbsp;").replace(/<(ul|dl|ol)[^>]*>/gi, "[br]").replace(/<(li|dd)[^>]*>/gi, "[br]").replace(/<p [^>]*>/gi, "[br]").replace(new RegExp("<(/?(?:" + valiHTML.join("|") + ")[^>]*)>", "gi"), "[$1]").replace(new RegExp('<span([^>]*class="?at"?[^>]*)>', "gi"), "[span$1]").replace(/<[^>]*>/g, "").replace(/\[\[\-/g, "[").replace(/\-\]\]/g, "]").replace(new RegExp("\\[(/?(?:" + valiHTML.join("|") + "|img|span)[^\\]]*)\\]", "gi"), "<$1>");

		if(!$.browser.mozilla) {

			content = content.replace(/\r?\n/gi, "<br>");

		}

		document.getElementById("text").innerHTML = content;

	}, 1)

}

//锁定编辑器中鼠标光标位置。。

function _insertimg(str) {

	var selection = window.getSelection ? window.getSelection() : document.selection;

	var range = selection.createRange ? selection.createRange() : selection.getRangeAt(0);

	if(!window.getSelection) {

		document.getElementById('text').focus();

		var selection = window.getSelection ? window.getSelection() : document.selection;

		var range = selection.createRange ? selection.createRange() : selection.getRangeAt(0);

		range.pasteHTML(str);

		range.collapse(false);

		range.select();

	} else {

		document.getElementById('text').focus();

		range.collapse(false);

		var hasR = range.createContextualFragment(str);

		var hasR_lastChild = hasR.lastChild;

		while(hasR_lastChild && hasR_lastChild.nodeName.toLowerCase() == "br" && hasR_lastChild.previousSibling && hasR_lastChild.previousSibling.nodeName.toLowerCase() == "br") {

			var e = hasR_lastChild;

			hasR_lastChild = hasR_lastChild.previousSibling;

			hasR.removeChild(e)

		}

		range.insertNode(hasR);

		if(hasR_lastChild) {

			range.setEndAfter(hasR_lastChild);

			range.setStartAfter(hasR_lastChild)

		}

		selection.removeAllRanges();

		selection.addRange(range)

	}

}

//监控按enter键和空格键，如果按了enter键，则取消原事件，用<BR/ >代替。此处还等待修改！！！！！！如果后端能实现各个浏览器回车键产生的P，div, br的输出问题话就无需采用这段JS、

function enterkey() {

	e = event.keyCode;

	if(e == 13 || e == 32) {

		var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;

		event.returnValue = false; // 取消此事件的默认操作 

		if(document.selection && document.selection.createRange) {

			var myRange = document.selection.createRange();

			myRange.pasteHTML('<br />');

		} else if(window.getSelection) {

			var selection = window.getSelection();

			var range = window.getSelection().getRangeAt(0);

			range.deleteContents();

			var newP = document.createElement('br');

			range.insertNode(newP);

		}

		//alert(document.getElementById("testdiv").innerHTML)

	}

}

//此处必须防止在最下端。

var edt = document.getElementById("text");

if(edt.addEventListener) {

	edt.addEventListener("paste", pasteHandler, false);

} else {

	edt.attachEvent("onpaste", pasteHandler);

}