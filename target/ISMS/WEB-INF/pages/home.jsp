<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/2/9
  Time: 15:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://www.layuicdn.com/layui/css/layui.css">
    <script src="js/jquery.min.js"></script>
    <script src="https://www.layuicdn.com/layui/layui.js"></script>

</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">基于积分制的公司管理系统</div>
        <ul class="layui-nav layui-layout-right">
    <li class="layui-nav-item"  id="layerDemo" style="margin-bottom: 0;" >
        <a data-method="notice" id="time" class="btn-link"  onclick="iframebtn(0)">公告栏</a>
    </li>
    <li class="layui-nav-item">
        <a onclick="iframebtn(1)" id="task">任务大厅</a>
    </li>
    <li class="layui-nav-item">
        <a onclick="iframebtn(2)">我的积分</a>
    </li>
    <li class="layui-nav-item">
        <a onclick="iframebtn(3)">积分排行</a>
    </li>
    <li class="layui-nav-item">
        <a onclick="iframebtn(4)">兑换商城</a>
    </li>
    <li class="layui-nav-item">
        <a onclick="iframebtn(9)">文件上传</a>
    </li>
    <li class="layui-nav-item">
        <a onclick="iframebtn(6)">签到/签退</a>
    </li>
    <li class="layui-nav-item" lay-unselect="">
        <a href="javascript:;">
            <%if(session.getAttribute("userimage")==null || session.getAttribute("userimage")==""){%>
            <img src="static/imgs/upload_image.png" class="layui-nav-img">${username}</a>
            <%} else {%>
            <img src="uploads/${userimage}" class="layui-nav-img">${username}</a>
            <%}%>

        <dl class="layui-nav-child">
            <dd><a class="layui-btn" onclick="iframebtn(7)" style="color: white">修改信息</a></dd>
            <dd>
                <div class="site-demo-button" id="layerDemopwd" style="margin-bottom: 0;">
                    <a data-method="confirmTrans" class="layui-btn" style="color: white">安全管理</a></div>
            </dd>
            <dd>
                <div class="site-demo-button"  style="margin-bottom: 0;">
                    <a data-method="confirmTrans" class="layui-btn"  onclick="iframebtn(5)" style="color: white">积分奖扣</a></div>
            </dd>
            <dd>
                <div class="site-demo-button"  style="margin-bottom: 0;">
                    <a data-method="confirmTrans" class="layui-btn"  onclick="iframebtn(8)" style="color: white">兑换记录</a></div>
            </dd>
            <dd><a href="login" class="layui-btn" style="color: white">退了</a></dd>
        </dl>
    </li>
</ul>
    </div>
</div>
</body>
<iframe id="iframe" style="position: absolute;height:91%;width:100%;" src="notice"></iframe>

<script>

    layui.use('element', function(){
        var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块

        //监听导航点击
        element.on('nav(demo)', function(elem){
            //console.log(elem)
            layer.msg(elem.text());
        });
    });

    function iframebtn(id){
        if(id==0){
            document.getElementById("iframe").src="notice";
        }else if(id==1){
            document.getElementById("iframe").src="task";
        }else if(id==2){
            document.getElementById("iframe").src="points";
        }else if(id==3){
            document.getElementById("iframe").src="ranking";
        }else if(id==4){
            document.getElementById("iframe").src="shopping";
        }else if(id==5){
            document.getElementById("iframe").src="integral_award";
        }else if(id==6){
            document.getElementById("iframe").src="clock_in";
        }else if(id==7){
            document.getElementById("iframe").src="mydata";
        }else  if(id==8){
            document.getElementById("iframe").src="exchange.jsp";
        }else  if(id==9){
            document.getElementById("iframe").src="file_upload.jsp";
        }
    }
    layui.use('layer', function(){ //独立版的layer无需执行这一句
        var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句

        //触发事件
        var active = {
            confirmTrans: function(othis){
                var type = othis.data('type')
                    ,text = othis.text();
                layer.open({
                    type: 1
                    ,title:'安全管理'
                    ,confirmTrans: type //具体配置参考：http://www.layui.com/doc/modules/layer.html#offset
                    ,id: 'layerDemopwd'+type //防止重复弹出
                    ,content: '<div style="padding: 20px 100px;"><input type="text" name="pwd" id="pwd"></div>'
                    ,btn: '重置密码'
                    ,btnAlign: 'c' //按钮居中
                    ,shade: 0 //不显示遮罩
                    ,yes: function(){
                       $.ajax({
                           type:'post',
                           url:'updatepwd',
                           data:{
                               pwd:$('#pwd').val(),
                               name:'${username}'
                           },
                           success:function (data) {
                               layer.msg("重置密码成功");
                           }
                       })
                        layer.closeAll();
                    }
                });
            },
            notice: function(){
                $.ajax({
                    url:'refresh',
                    success:function(data){
                        if(data.data==""){

                        }else {
                            for(var i=0;i<data.data.length;i++){
                                //示范一个公告层
                                layer.open({
                                    type: 1
                                    ,title: false //不显示标题栏
                                    ,closeBtn: false
                                    ,area: '300px;'
                                    ,shade: 0.8
                                    ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
                                    ,btn: ['确定', '取消']
                                    ,btnAlign: 'c'
                                    ,moveType: 1 //拖拽模式，0或者1
                                    ,content:
                                        '<div style="padding: 20px; line-height: 42px; background-color: #393D49; color: #fff; font-weight: 300;">' +
                                        data.data[i].theme+'<br>'+data.data[i].content+'<br>'+new Date(data.data[i].time).toLocaleString()+'</div>'+
                                        '<div></div><br><div style="text-align: center"><font size="6"></font></div><div></div><br>'
                                    ,success: function(layero){
                                        var btn = layero.find('.layui-layer-btn');
                                        btn.find('.layui-layer-btn0').attr({
                                        });
                                    }
                                    ,yes: function(){
                                        $.ajax({
                                            type:'post',
                                            url:'removeMyNewNotice',
                                            data:{
                                                id:${userid}
                                            },
                                            success:function (data) {
                                                layer.closeAll();
                                            }
                                        })
                                        $.ajax({
                                            type:'post',
                                            url:'admin/findNoticeIntegral',
                                            success:function (data) {
                                                if (data.length==0){
                                                    $.ajax({
                                                        type:'post',
                                                        url:'integralMath',
                                                        data:{
                                                            integral:2,
                                                            id:${userid}
                                                        },
                                                        success:function (data1) {
                                                            layer.msg("积分+2");
                                                        }
                                                    })
                                                    IntegralEvent(2);
                                                }else{
                                                    $.ajax({
                                                        type:'post',
                                                        url:'integralMath',
                                                        data:{
                                                            integral:data[0].integral,
                                                            id:${userid}
                                                        },
                                                        success:function (data1) {
                                                           layer.msg("积分+"+data[0].integral);
                                                        }
                                                    })
                                                    IntegralEvent(data[0].integral);
                                                }
                                            }
                                        })

                                    }
                                });
                            }
                        }
                    }
                })
            }
        };

        $('#layerDemopwd .layui-btn').on('click', function(){
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });

        $('#layerDemo .btn-link').on('click', function(){
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });
    });

    function showTime() {
        $.ajax({
            url:'refresh',
           success:function(data){
               if(data.data==""){
                   document.getElementById('time').innerHTML = '公告栏';
               }else {
                   document.getElementById('time').innerHTML =  '公告栏<span class="layui-badge-dot"></span>';
               }
           }
        })

    }
    setInterval("showTime()",1000);

    function refreshuserdata() {
        $.ajax({
            type:'post',
            url:'mydatarefresh',
            data:{
                id:${userid}
            },
            success:function (data) {
                <%--console.log("${userid}")--%>
                <%--console.log("${username}");--%>
                <%--console.log("更新成功");--%>
            }
        })
    }
    setInterval("refreshuserdata()",1000);

    function deleteclockin(){
        $.ajax({
            url:'delectclockin',
            success:function (data) {

            }
        })
    }
    function refrewerew() {
        if (new Date().getHours()==0 && new  Date().getMinutes()==00 && new Date().getSeconds()==00){
            deleteclockin();
        }
    }
   setInterval("refrewerew()",1000);


    function refreclockin(){
        $.ajax({
            url:'findclockin',
            data:{
                id:${userid}
            },
            success:function (data) {
                // console.log(data);
            }
        })
    }
    setInterval("refreclockin()",1000);

    function showTask() {
        $.ajax({
            url:'RefreshTask',
            success:function(data){
                if(data=="1000"){
                    document.getElementById('task').innerHTML = '任务大厅<span class="layui-badge-dot"></span>';
                }else {
                    document.getElementById('task').innerHTML =  '任务大厅';
                }
            }
        })
    }
    setInterval("showTask()",1000);

    function IntegralEvent(num) {
        $.ajax({
            type:'post',
            url:'addMyEvent',
            data:{
                uid:${userid},
                event:'阅读公告',
                time:new Date(),
                integral:'+'+num
            },
            success:function (data) {
                console.log("积分事件");
            }
        })
    }
</script>
</html>
