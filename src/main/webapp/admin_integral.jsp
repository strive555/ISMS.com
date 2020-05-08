<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2020/4/8
  Time: 10:43
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

<div id="time" style="display: none">
    <div class="layui-form" >
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label" style="width: 150px">请选择时间</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" id="test30">
                </div>
            </div>
        </div>
    </div>
    <div class="layui-inline">
        <label class="layui-form-label" style="width: 150px">请输入积分</label>
        <div class="layui-input-inline">
            <input type="text" class="layui-input" id="integral">
        </div>
    </div>
</div>

<div class="layui-form">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 150px">请选择日期搜索</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="test11">
            </div>
        </div>
    </div>
</div>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="refresh">刷新</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="del">删除</a>
</script>
<script>
    layui.use(['table','laydate'], function(){
        var table = layui.table
            ,laydate = layui.laydate;

        table.render({
            elem: '#test'
            ,url:'admin/findAllClockInIntegral'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,title: '积分设置数据表'
            ,height:520
            ,cols: [[
                {field:'id', title:'ID', width:'8%', fixed: 'left', unresize: true, sort: true}
                ,{field:'year', title:'年份', width:'15%', edit: 'text', sort: true}
                ,{field:'month', title:'月份', width:'15%', edit: 'text', sort: true}
                ,{field:'date', title:'日', width:'15%', sort: true}
                ,{field:'integral', title:'对应积分(onTime:+|Late:-)', width:'17%', sort: true}
                ,{field:'state', title:'状态(onTime:按时|Late:迟到)', width:'17%'}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo',width:'13%'}
            ]]
            ,page: true
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'refresh':
                    table.reload('test',{
                        url:'admin/findAllClockInIntegral'
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
                        url:'admin/deleteClockInIntegral',
                        data:{
                            id:data.id
                        },
                        success:function (data1) {
                            layer.msg("删除成功");
                        }
                    })
                });
            } else if(obj.event === 'edit'){
                var time=data.year+"-"+data.month+"-"+data.date
                $('#test30').val(time);
                $('#integral').val(data.integral);
                layer.open({
                    title: '编辑',
                    type: 1,
                    btn: ['确定', '取消'],
                    content: $('#time'),
                    area:['450px','200px'],
                    yes: function (index, layero) {

                        if($('#integral').val()=="" || $('#integral').val()==null){
                           var integral=0;
                        }else{
                            var integral=$('#integral').val();
                        }
                        $.ajax({
                            type:'post',
                            url:'admin/updateClockInIntegral',
                            data:{
                                year:$('#year').val(),
                                month:$('#month').val(),
                                date:$('#date').val(),
                                integral:integral,
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
        //自定义颜色
        laydate.render({
            elem: '#test30'
            ,theme: '#393D49'
            ,done: function(value, date){
                $('#year').val(date.year);
                $('#month').val(date.month);
                $('#date').val(date.date);
            }
        });
        laydate.render({
            elem: '#test11'
            ,format: 'yyyy年MM月dd日'
            ,done: function(value, date){
                table.reload('test',{
                    url:'admin/findAllClockInIntegral'
                    ,where:{
                        year:date.year,
                        month:date.month,
                        date:date.date
                    }
                })
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
