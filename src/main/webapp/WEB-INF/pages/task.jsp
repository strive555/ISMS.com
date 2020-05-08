<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/2/16
  Time: 16:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="static/layui/css/layui.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="static/layui/layui.js"></script>
</head>
<style>
    body{
        background-color:#3c3f41;
    }
    li{
        color:#ffffff;
    }
</style>
<body class="container" onload="refresh()">
<div class="layui-tab" lay-filter="test">
    <ul class="layui-tab-title">
        <li class="layui-this" id="urgenttask"lay-id="11" style="color: red">紧急任务</li>
        <li lay-id="22" id="dailytask" style="color:yellow">日常任务</li>
        <li lay-id="33" id="mytask_no">我的任务</li>
        <li lay-id="33" id="mytask_yes">我的任务</li>
    </ul>
    <div class="layui-tab-content">
        <div class="layui-tab-item layui-show">
            <ul id="biuuu_city_list"></ul>
            <div id="cardcontent" style="display: none"></div>
            <div style="color: #1E9FFF">已加载全部内容</div>
        </div>
        <div class="layui-tab-item">
            <ul id="biuuu_city_list1"></ul>
            <div id="cardcontent1" style="display: none"></div>
            <div style="color: #1E9FFF">已加载全部内容</div>
        </div>
        <div class="layui-tab-item">
            <ul id="biuuu_city_list2"></ul>
            <div id="cardcontent2" style="display: none"></div>
            <div style="color: #1E9FFF">已加载全部内容</div>
        </div>
        <div class="layui-tab-item">
            <ul id="biuuu_city_list3"></ul>
            <div id="cardcontent3" style="display: none"></div>
            <div style="color: #1E9FFF">已加载全部内容</div>
        </div>
    </div>
</div>
<div id="tasknum"></div>
<script>
    layui.use('element', function(){
        var $ = layui.jquery
            ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块

        //Hash地址的定位
        var layid = location.hash.replace(/^#test=/, '');
        element.tabChange('test', layid);

        element.on('tab(test)', function(elem){
            location.hash = 'test='+ $(this).attr('lay-id');
        });
    });

    function refresh(){
        $.ajax({
            url:'findtask',
            success:function (data) {
                layui.use(['laypage', 'layer'], function(){
                    var laypage = layui.laypage
                        ,layer = layui.layer;

                    //测试数据
                    var adddata = [];
                    for(var i=0;i<data.length;i++){
                        if(data[i].type=="紧急任务" && data[i].uid==""){

                            $.ajax({
                                type:'post',
                                url:'admin/findFiles',
                                data:{
                                    time:new Date(data[i].time)
                                },
                                success:function (res) {
                                    if(res==""){
                                    }else{
                                        console.log(res);
                                        console.log(res.length);
                                        console.log(res[0].files);
                                        console.log(document.getElementById(res[0].time));
                                        var id=res[0].time;
                                        var task=[];
                                        if (res.length>2){
                                            $('#'+id).append('<button type="button" class="btn btn-primary" id="'+id+'"style="position: relative;left: -25%" >查看</button> ');
                                            for(var i=0;i<res.length;i++) {
                                                task.push('<a  href="uploads/' + res[i].files + '" style="position: relative;left: -25%"><font size="1">' + res[i].files + '</font></a>');
                                            }
                                        }else{
                                            for(var i=0;i<res.length;i++){
                                                $('#'+id).append('<a  href="uploads/'+res[i].files+'" style="position: relative;left: -25%"><font size="1">'+res[i].files+'</font></a> ');
                                            }
                                        }
                                        $('#'+id).click(function () {
                                            console.log(task);
                                            if (task.length==0){

                                            }else{
                                                layer.open({
                                                    type: 1
                                                    ,title: '文件详情'
                                                    ,content: '<div style="padding: 20px 100px;">'+task+'</div>'
                                                    ,btn: '确定'
                                                    ,btnAlign: 'c' //按钮居中
                                                    ,shade: 0 //不显示遮罩
                                                    ,offset:['40%','40%']
                                                });
                                            }
                                        })
                                    }

                                }
                            })
                                    adddata.push(
                                        '<div class="card">\n' +
                                        '                <h5 class="card-header" style="color:red">'+data[i].theme+'</h5>\n' +
                                        '                <div class="card-body" id='+data[i].time+'>\n' +
                                        '                    <p class="card-text" style="color:black">'+data[i].content+'</p>\n' +
                                        '                    <p class="card-text" style="color:black;position: absolute;left: 2%;top:67.5%">文件栏：</p>' +
                                        '                    <a  onclick="btn1(<%=session.getAttribute("userid")%>,'+data[i].id+')"class="btn btn-primary" style="position:relative;left: 45%">接收任务</a>'+'<span style="position: relative;left:68%;color:#000000">发布时间：'+new Date(data[i].time).toLocaleString()+'</span>\n' +
                                        '               </div>\n' +
                                        '            </div><br><br>');


                        }
                        document.getElementById('urgenttask').innerHTML="紧急任务(<font style='color:#00FF00'>"+adddata.length+"</font>)";
                    }
                    //调用分页
                    laypage.render({
                        elem: 'cardcontent'
                        ,count: adddata.length
                        ,jump: function(obj){
                            //模拟渲染
                            document.getElementById('biuuu_city_list').innerHTML = function(){
                                var arr = []
                                    ,thisData = adddata.concat().splice(0, adddata.length);
                                layui.each(thisData, function(index, item){
                                    arr.push('<li>'+ item +'</li>');
                                });
                                return arr.join('');
                            }();
                        }
                    });
                    //测试数据
                    var adddata1 = [];
                    for(var i=0;i<data.length;i++){
                        if(data[i].type=="日常任务" && data[i].uid==""){

                            $.ajax({
                                type:'post',
                                url:'admin/findFiles',
                                data:{
                                    time:new Date(data[i].time)
                                },
                                success:function (res) {
                                    if(res==""){
                                    }else{
                                        console.log(res);
                                        console.log(res.length);
                                        console.log(res[0].files);
                                        console.log(document.getElementById(res[0].time));
                                        var id=res[0].time;
                                        var task1=[];
                                        if (res.length>2){
                                            $('#'+id).append('<button type="button" class="btn btn-primary" id="'+id+'"style="position: relative;left: -25%" >查看</button> ');
                                            for(var i=0;i<res.length;i++) {
                                                task1.push('<a  href="uploads/' + res[i].files + '" style="position: relative;left: -25%"><font size="1">' + res[i].files + '</font></a>');
                                            }
                                        }else{
                                            for(var i=0;i<res.length;i++){
                                                $('#'+id).append('<a  href="uploads/'+res[i].files+'" style="position: relative;left: -25%"><font size="1">'+res[i].files+'</font></a> ');
                                            }
                                        }
                                        $('#'+id).click(function () {
                                            console.log(task1);
                                            if (task1.length==0){

                                            }else{
                                                layer.open({
                                                    type: 1
                                                    ,title: '文件详情'
                                                    ,content: '<div style="padding: 20px 100px;">'+task1+'</div>'
                                                    ,btn: '确定'
                                                    ,btnAlign: 'c' //按钮居中
                                                    ,shade: 0 //不显示遮罩
                                                    ,offset:['40%','40%']
                                                });
                                            }
                                        })
                                    }

                                }
                            })
                            adddata1.push(
                                '<div class="card">\n' +
                                '                <h5 class="card-header" style="color:red">'+data[i].theme+'</h5>\n' +
                                '                <div class="card-body" id='+data[i].time+'>\n' +
                                '                    <p class="card-text" style="color:black">'+data[i].content+'</p>\n' +
                                '                    <p class="card-text" style="color:black;position: absolute;left: 2%;top:67.5%">文件栏：</p>' +
                                '                    <a  onclick="btn1(<%=session.getAttribute("userid")%>,'+data[i].id+')"class="btn btn-primary" style="position:relative;left: 45%">接收任务</a>'+'<span style="position: relative;left:68%;color:#000000">发布时间：'+new Date(data[i].time).toLocaleString()+'</span>\n' +
                                '               </div>\n' +
                                '            </div><br><br>');


                        }
                        document.getElementById('dailytask').innerHTML="日常任务(<font style='color: #00FF00'>"+adddata1.length+"</font>)";
                    }
                    //调用分页
                    laypage.render({
                        elem: 'cardcontent1'
                        ,count: adddata1.length
                        ,jump: function(obj){
                            //模拟渲染
                            document.getElementById('biuuu_city_list1').innerHTML = function(){
                                var arr = []
                                    ,thisData = adddata1.concat().splice(0, adddata1.length);
                                layui.each(thisData, function(index, item){
                                    arr.push('<li>'+ item +'</li>');
                                });
                                return arr.join('');
                            }();
                        }
                    });
                    //测试数据
                    var adddata2 = [];
                    for(var i=0;i<data.length;i++){
                        if(data[i].uid==<%=session.getAttribute("userid")%> && data[i].state=="no"){
                            $.ajax({
                                type:'post',
                                url:'admin/findFiles',
                                data:{
                                    time:new Date(data[i].time)
                                },
                                success:function (res) {
                                    if(res==""){
                                    }else{
                                        console.log(res);
                                        console.log(res.length);
                                        console.log(res[0].files);
                                        console.log(document.getElementById(res[0].time));
                                        var id=res[0].time;
                                        var task2=[];
                                        if (res.length>2){
                                            $('#'+id).append('<button type="button" class="btn btn-primary" id="'+id+'"style="position: relative;left: -23%" >查看</button> ');
                                            for(var i=0;i<res.length;i++) {
                                                task2.push('<a  href="uploads/' + res[i].files + '" style="position: relative;left: -25%"><font size="1">' + res[i].files + '</font></a>');
                                            }
                                        }else{
                                            for(var i=0;i<res.length;i++){
                                                $('#'+id).append('<a  href="uploads/'+res[i].files+'" style="position: relative;left: -25%"><font size="1">'+res[i].files+'</font></a> ');
                                            }
                                        }
                                    $('#'+id).click(function () {
                                        console.log(task2);
                                        if (task2.length==0){

                                        }else{
                                            layer.open({
                                                type: 1
                                                ,title: '文件详情'
                                                ,content: '<div style="padding: 20px 100px;">'+task2+'</div>'
                                                ,btn: '确定'
                                                ,btnAlign: 'c' //按钮居中
                                                ,shade: 0 //不显示遮罩
                                                ,offset:['40%','40%']
                                            });
                                        }
                                    })
                                    }
                                }
                            })
                            if(data[i].finishtime=="" || data[i].finishtime==null){
                                adddata2.push(
                                    '<div class="card">\n' +
                                    '                <h5 class="card-header" style="color:red">'+data[i].theme+'</h5>\n' +
                                    '                <div class="card-body" id='+data[i].time+'>\n' +
                                    '                    <p class="card-text" style="color:black">'+data[i].content+'</p>\n' +
                                    '                    <p class="card-text" style="color:black;position: absolute;left: 2%;top:67.5%">文件栏：</p>' +
                                    '                    <a  onclick="btn2('+data[i].id+')"class="btn btn-primary" style="position:relative;left: 45%">完成任务</a>'+'<span style="position: relative;left:68%;color:#000000">发布时间：'+new Date(data[i].time).toLocaleString()+'</span>\n' +
                                    '               </div>\n' +
                                    '            </div><br><br>');
                            }else{
                                adddata2.push(
                                    '<div class="card">\n' +
                                    '                <h5 class="card-header" style="color:red">'+data[i].theme+'</h5>\n' +
                                    '                <div class="card-body" id='+data[i].time+'>\n' +
                                    '                    <p class="card-text" style="color:black">'+data[i].content+'</p>\n' +
                                    '                    <p class="card-text" style="color:black;position: absolute;left: 2%;top:71.5%">文件栏：</p>' +
                                    '                    <a   style="position:relative;left: 45%;color:#000000" title="提交时间：'+new Date(data[i].finishtime).toLocaleString()+'">等待审核...</a>'+'<span style="position: relative;left:68%;color:#000000">发布时间：'+new Date(data[i].time).toLocaleString()+'</span>\n' +
                                    '               </div>\n' +
                                    '            </div><br><br>');

                            }

                            }
                        document.getElementById('mytask_no').innerHTML="我的任务(<font style='color: #00FF00'>正在进行："+adddata2.length+"</font>)";
                        }
                    //调用分页
                    laypage.render({
                        elem: 'cardcontent2'
                        ,count: adddata2.length
                        ,jump: function(obj){
                            //模拟渲染
                            document.getElementById('biuuu_city_list2').innerHTML = function(){
                                var arr = []
                                    ,thisData = adddata2.concat().splice(0, adddata2.length);
                                layui.each(thisData, function(index, item){
                                    arr.push('<li>'+ item +'</li>');
                                });
                                return arr.join('');
                            }();
                        }
                    });
                    var adddata3 = [];
                    for(var i=0;i<data.length;i++){
                        if(data[i].uid==<%=session.getAttribute("userid")%> && data[i].state=="yes"){

                            $.ajax({
                                type:'post',
                                url:'admin/findFiles',
                                data:{
                                    time:new Date(data[i].time)
                                },
                                success:function (res) {
                                    if(res==""){
                                    }else{
                                        console.log(res);
                                        console.log(res.length);
                                        console.log(res[0].files);
                                        console.log(document.getElementById(res[0].time));
                                        var id=res[0].time;
                                        var task3=[];
                                        if (res.length>2){
                                            $('#'+id).append('<button type="button" class="btn btn-primary" id="'+id+'"style="position: relative;left: -29%" >查看</button> ');
                                            for(var i=0;i<res.length;i++) {
                                                task3.push('<a  href="uploads/' + res[i].files + '" style="position: relative;left: -25%"><font size="1">' + res[i].files + '</font></a>');
                                            }
                                        }else{
                                            for(var i=0;i<res.length;i++){
                                                $('#'+id).append('<a  href="uploads/'+res[i].files+'" style="position: relative;left: -25%"><font size="1">'+res[i].files+'</font></a> ');
                                            }
                                        }
                                        $('#'+id).click(function () {
                                            console.log(task3);
                                            if (task3.length==0){

                                            }else{
                                                layer.open({
                                                    type: 1
                                                    ,title: '文件详情'
                                                    ,content: '<div style="padding: 20px 100px;">'+task3+'</div>'
                                                    ,btn: '确定'
                                                    ,btnAlign: 'c' //按钮居中
                                                    ,shade: 0 //不显示遮罩
                                                    ,offset:['40%','40%']
                                                });
                                            }
                                        })
                                    }

                                }
                            })
                            adddata3.push(
                                '<div class="card">\n' +
                                '                <h5 class="card-header" style="color:red">'+data[i].theme+'</h5>\n' +
                                '                <div class="card-body" id='+data[i].time+'>\n' +
                                '                    <p class="card-text" style="color:black">'+data[i].content+'</p>\n' +
                                '                    <p class="card-text" style="color:black;position: absolute;left: 2%;top:71.5%">文件栏：</p>' +
                                '                    <a  style="position:relative;left: 40%;color: black" title="提交时间：'+new Date(data[i].finishtime).toLocaleString()+'">审核通过（已完成）</a>'+'<span style="position: relative;left:63%;color:#000000">发布时间：'+new Date(data[i].time).toLocaleString()+'</span>\n' +
                                '               </div>\n' +
                                '            </div><br><br>');
                        }
                        document.getElementById('mytask_yes').innerHTML="我的任务(<font style='color: #00FF00'>已完成："+adddata3.length+"</font>)";
                    }
                    //调用分页
                    laypage.render({
                        elem: 'cardcontent3'
                        ,count: adddata3.length
                        ,jump: function(obj){
                            //模拟渲染
                            document.getElementById('biuuu_city_list3').innerHTML = function(){
                                var arr = []
                                    ,thisData = adddata3.concat().splice(0, adddata3.length);
                                layui.each(thisData, function(index, item){
                                    arr.push('<li>'+ item +'</li>');
                                });
                                return arr.join('');
                            }();
                        }
                    });
                });
            }
        })
    }
    function btn1(uid,id) {
        layui.use('element', function(){
            var layer = layui.layer;
            $.ajax({
                type:'post',
                url:'usertask',
                data:{
                    uid:uid,
                    id:id
                },
                success:function (data) {
                    layer.msg("接收任务成功");
                    refresh();
                }
            })

        })
    }
    function btn2(id) {
        console.log(id);
        layui.use('element', function(){
            var layer = layui.layer;
            $.ajax({
                type:'post',
                url:'TaskFinishTime',
                data:{
                   finishtime:new Date(),
                    id:id
                },
                success:function (data) {
                    layer.msg("提交成功，等待管理员审核");
                    refresh();
                }
            })

        })
    }
</script>
</body>
</html>
