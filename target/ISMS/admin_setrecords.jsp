<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2020/4/7
  Time: 23:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="static/layui/css/layui.css">
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="static/layui/layui.js"></script>
</head>
<body>

<input style="display: none" id="year">
<input style="display: none" id="month">
<input style="display: none" id="date">
<input style="display: none" id="hours">
<input style="display: none" id="minutes">
<input style="display: none" id="seconds">

<div id="time" style="display: none;width: 440px;">
    <div class="layui-form">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label" style="width: 150px">请选择时间</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="test5" placeholder="yyyy-MM-dd HH:mm:ss">
                </div>
            </div>
        </div>
    </div>
</div>

    <div class="layui-form">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label" style="width: 150px">请选择日期搜索</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="test11" placeholder="yyyy年MM月dd日">
                </div>
            </div>
        </div>
    </div>

<table class="layui-hide" id="test" lay-filter="test"></table>
    <script type="text/html" id="toolbarDemo">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-normal layui-btn-sm" lay-event="refresh">刷新</button>
        </div>
    </script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script>
    layui.use(['table','laydate'], function(){
        var table = layui.table
            ,laydate = layui.laydate;

        table.render({
            elem: '#test'
            ,url:'admin/findAllWordShift'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,title: '打卡设置记录数据表'
            ,height:520
            ,cols: [[
                {field:'id', title:'ID', width:'8%', fixed: 'left', unresize: true, sort: true}
                ,{field:'year', title:'年份', width:'10%', edit: 'text', sort: true}
                ,{field:'month', title:'月份', width:'10%', edit: 'text', sort: true}
                ,{field:'date', title:'日', width:'10%', sort: true}
                ,{field:'hours', title:'小时',width:'10%', sort: true}
                ,{field:'minutes', title:'分钟',width:'10%', sort: true}
                ,{field:'seconds', title:'秒',width:'10%', sort: true}
                ,{field:'state', title:'AM/PM',width:'10%'}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:'22%'}
            ]]
            ,page: true
        });

        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'refresh':
                    console.log("asd");
                    table.reload('test',{
                        url:'admin/findAllWordShift'
                        ,where:{
                            year:0,
                        }
                    })
                    break;
            };
        });
        //监听行工具事件
        table.on('tool(test)', function(obj){
            var data = obj.data;
            //console.log(obj)
            if(obj.event === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del();
                    layer.close(index);
                    $.ajax({
                        type:'post',
                        url:'admin/deleteWordShift',
                        data:{
                            id:data.id
                        },
                        success:function (data1) {
                            layer.msg("删除成功");
                        }
                    })
                });
            } else if(obj.event === 'edit'){
                var time=data.year+"-"+data.month+"-"+data.date+" "+data.hours+":"+data.minutes+":"+data.seconds;
                $('#test5').val(time);
                layer.open({
                    title: '编辑',
                    type: 1,
                    btn: ['确定', '取消'],
                    content: $('#time'),
                    area:['450px','200px'],
                    yes: function (index, layero) {
                        $.ajax({
                            type:'post',
                            url:'admin/updateWordShift',
                            data:{
                                year:$('#year').val(),
                                month:$('#month').val(),
                                date:$('#date').val(),
                                hours:$('#hours').val(),
                                minutes:$('#minutes').val(),
                                seconds:$('#seconds').val(),
                                id:data.id
                            },
                            success:function (data) {
                                layer.msg("编辑成功",{
                                    time:1000
                                },function () {
                                    layer.closeAll();
                                })
                            }
                        })
                    }
                });
            }
        });
        laydate.render({
            elem: '#test11'
            ,format: 'yyyy年MM月dd日'
            ,done: function(value, date){
                table.reload('test',{
                    url:'admin/findAllWordShift'
                    ,where:{
                       year:date.year,
                        month:date.month,
                        date:date.date
                    }
                })
            }
        });
        //日期时间选择器
        laydate.render({
            elem: '#test5'
            ,type: 'datetime'
            ,done: function(value, date){
               $('#year').val(date.year);
                $('#month').val(date.month);
                $('#date').val(date.date);
                $('#hours').val(date.hours);
                $('#seconds').val(date.seconds);
                $('#minutes').val(date.minutes);
            }
        });
    });
    function Login() {
        var id='<%=session.getAttribute("adminid")%>';
        if(id=="null" || id==""){
            location.href="admin_login";
        }
    }
    setInterval("Login()",1000);
</script>
</body>
</html>
