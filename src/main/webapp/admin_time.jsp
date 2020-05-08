<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2020/4/4
  Time: 12:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="static/layui/css/layui.css">
    <script src="js/jquery.min.js"></script>
    <script src="static/layui/layui.js"></script>
</head>
<body >
<div class="layui-form">
    <div class="layui-form-item">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 0px;">
            <legend>积分</legend>
        </fieldset>
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 150px">按时打卡所得积分</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="integral" value="1" placeholder="默认2分" >
                <input type="text" class="layui-input" id="OnTime" placeholder="选择日期">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 150px">迟到/早退所扣积分</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="LateIntegral" value="2" placeholder="默认2分" >
                <input type="text" class="layui-input" id="Late" placeholder="选择日期">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 150px">阅读公告所得积分</label>
            <div class="layui-input-inline" style="width: 250px">
                <input type="text" class="layui-input" id="notice" placeholder="默认2分" >
                <button id="btn_notice" class="layui-btn layui-btn-normal">确定</button>
                <button id="btn_notice_2" class="layui-btn layui-btn-primary">查看</button>
                <button id="btn_notice_1" class="layui-btn" title="默认积分2">恢复默认</button>
            </div>
        </div>
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 0px;">
            <legend>打卡时间</legend>
        </fieldset>
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 150px">上班时间</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="AM" placeholder="默认8:00AM">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 150px">下班时间</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="PM" placeholder="默认5:00PM">
            </div>
        </div>
    </div>
</div>
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 0px;">
    <legend>积分规则说明</legend>
</fieldset>
<form class="layui-form">
    <div class="layui-form-item layui-form-text">
        <div class="layui-input-block" >
            <textarea id="content"style="height: 40%" placeholder="请输入内容" class="layui-textarea" lay-verify="required" lay-reqtext="积分规则说明是必填项，岂能为空？"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <a type="submit" class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</a>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            <a type="button" class="layui-btn layui-btn-normal"  id="findIntegralRule">查看当前积分规则</a>
        </div>
    </div>
</form>
</body>
<script>
    layui.use(['laydate','layer','transfer', 'util','form'], function() {
        var laydate = layui.laydate
            , layer = layui.layer
            , $ = layui.$
            , transfer = layui.transfer
            , util = layui.util
            , form = layui.form;

        //常规用法
        laydate.render({
            elem: '#OnTime'
            , theme: 'grid'
            , done: function (value, date) {
                console.log($('#integral').val());
                $.ajax({
                    type: 'post',
                    url: 'admin/addClockInIntegral',
                    data: {
                        year: date.year,
                        month: date.month,
                        date: date.date,
                        integral: $('#integral').val(),
                        state: 'OnTime'
                    },
                    success: function (data) {
                        console.log(data);
                        if (data == 1000) {
                            layer.msg('<img src="static/layui/images/face/0.gif">' + "设定成功:" + date.year + "年" + date.month + "月" + date.date + "日，准时打卡所得积分为" + $('#integral').val());
                        } else {
                            layer.msg('<img src="static/layui/images/face/12.gif">设定失败：该日期已设定过了');
                        }

                    }
                })
            }
        });
        laydate.render({
            elem: '#Late'
            , theme: 'grid'
            , done: function (value, date) {
                $.ajax({
                    type: 'post',
                    url: 'admin/addClockInIntegral',
                    data: {
                        year: date.year,
                        month: date.month,
                        date: date.date,
                        integral: $('#LateIntegral').val(),
                        state: 'Late'
                    },
                    success: function (data) {
                        console.log(data);
                        if (data == 1000) {
                            layer.msg('<img src="static/layui/images/face/0.gif">' + "设定成功:" + date.year + "年" + date.month + "月" + date.date + "日，迟到/早退所扣积分为" + $('#LateIntegral').val());
                        } else {
                            layer.msg('<img src="static/layui/images/face/12.gif">设定失败：该日期已设定过了');
                        }

                    }
                })
            }
        });
        //日期时间选择器
        laydate.render({
            elem: '#AM'
            , theme: 'molv'
            , type: 'datetime'
            , done: function (value, date) {
                $.ajax({
                    type: 'post',
                    url: 'admin/addWorkShift',
                    data: {
                        year: date.year,
                        month: date.month,
                        date: date.date,
                        hours: date.hours,
                        minutes: date.minutes,
                        seconds: date.seconds,
                        state: 'AM'
                    },
                    success: function (data) {
                        console.log(data);
                        if (data == 1000) {
                            layer.msg('<img src="static/layui/images/face/0.gif">' + "设定成功:" + date.year + "年" + date.month + "月" + date.date + "日，上班时间为" + date.hours + ":" + date.minutes + ":" + date.seconds);
                        } else {
                            layer.msg('<img src="static/layui/images/face/12.gif">设定失败：该日期已设定上班时间了');
                        }
                    }
                })
            }
        });
        laydate.render({
            elem: '#PM'
            , theme: 'molv'
            , type: 'datetime'
            , done: function (value, date) {
                $.ajax({
                    type: 'post',
                    url: 'admin/addWorkShift',
                    data: {
                        year: date.year,
                        month: date.month,
                        date: date.date,
                        hours: date.hours,
                        minutes: date.minutes,
                        seconds: date.seconds,
                        state: 'PM'
                    },
                    success: function (data) {
                        console.log(data);

                        if (data == 1000) {
                            layer.msg('<img src="static/layui/images/face/0.gif">' + "设定成功:" + date.year + "年" + date.month + "月" + date.date + "日，下班时间为" + date.hours + ":" + date.minutes + ":" + date.seconds);
                        } else {
                            layer.msg('<img src="static/layui/images/face/12.gif">设定失败：该日期已设定下班时间了');
                        }
                    }
                })
            }
        });

        $('#btn_notice').click(function () {
            $.ajax({
                type: 'post',
                url: 'admin/refreshNoticeIntegral',
                data: {
                    time: new Date(),
                    integral: $('#notice').val()
                },
                success: function (data) {
                    layer.msg('<img src="static/layui/images/face/0.gif">成功');
                }
            })
        });
        $('#btn_notice_1').click(function () {
            $.ajax({
                type: 'post',
                url: 'admin/renewNoticeIntegral',
                success: function (data) {
                    layer.msg('<img src="static/layui/images/face/0.gif">恢复成功');
                }
            })
        })
        $('#btn_notice_2').click(function () {
            $.ajax({
                type:'post',
                url:'admin/findNewNoticeIntegral',
                success:function (data) {
                    console.log(data);
                    if(data.length==0){
                        layer.open({
                            type: 1
                            ,title: '当前阅读所得积分'
                            ,content: '<div style="padding: 20px 60px;">当前没有设置积分，默认2分<br><br><br><a href="#" type="button" onclick="FindNoticeIntegral()">历史记录</a></div>'
                            ,btn: '确定'
                            ,btnAlign: 'c' //按钮居中
                            ,shade: 0 //不显示遮罩
                        });
                    }else{
                        layer.open({
                            type: 1
                            ,title: '当前阅读所得积分'
                            ,content: '<div style="padding: 20px 60px;">积分：'+data[0].integral+'<br>设置时间：'+new Date(data[0].time).toLocaleString()+'<br><br><br><a href="#" type="button" onclick="FindNoticeIntegral()">历史记录</a></div>'
                            ,btn: '确定'
                            ,btnAlign: 'c' //按钮居中
                            ,shade: 0 //不显示遮罩
                        });
                    }

                }
            })
        })

        //监听提交
        form.on('submit(demo1)', function(data) {
            $.ajax({
                type:'post',
                url:'admin/refreshIntegralRule',
                data:{
                    content:$('#content').val(),
                    time:new Date()
                },
                success:function(data){
                    layer.msg("发布成功");
                }
            })
        });

        $('#findIntegralRule').click(function () {
            $.ajax({
                type:'post',
                url:'admin/findIntegralRule',
                success:function (data) {
                    layer.open({
                        type: 1
                        ,title: '当前积分规则说明'
                        ,content: '<div style="padding: 20px 60px;width: 580px">'+data[0].content+'<br>'+new Date(data[0].time).toLocaleString()+'</div>'
                        ,btn: '确定'
                        ,btnAlign: 'c' //按钮居中
                        ,shade: 0 //不显示遮罩
                        ,area:['700px','500px']
                    });
                }
            })
        })
    });

    function FindNoticeIntegral(){

        $.ajax({
            type:'post',
            url:'admin/FindNoticeIntegral',
            success:function (data) {
                if(data.length==0){
                    layer.msg("没有历史记录");
                }else{
                    var notice=[];
                    var str="";
                    for(var i=0;i<data.length;i++){
                        notice.push('积分:'+data[i].integral+' | 设置时间：'+new Date(data[i].time).toLocaleString()+'<br>');
                    }
                    layer.open({
                        type: 1
                        ,title: '当前阅读所得积分'
                        ,content: '<div style="padding: 20px 80px;width: 300px">'+notice+'</div>'
                        ,btn: '确定'
                        ,btnAlign: 'c' //按钮居中
                        ,shade: 0 //不显示遮罩
                        ,area:['500px','']
                    });
                }

            }
        })
    }


    function Login() {
        var id='<%=session.getAttribute("adminid")%>';
        if(id=="null" || id==""){
            location.href="admin_login";
        }
    }
    setInterval("Login()",1000);
</script>
</html>
