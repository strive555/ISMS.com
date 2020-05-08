<%--
  Created by IntelliJ IDEA.
  User: 86135
  Date: 2020/4/8
  Time: 12:21
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
<div>
    <div class="layui-inline" style="width: 200px">
        <select class="layui-input" id="clockin" >
            <option value="">根据打卡类型</option>
            <option value="签退" >签退</option>
            <option value="签到" >签到</option>
        </select>
    </div>
    <button class="layui-btn layui-btn-normal" data-type="reload" id="find" title="不填写搜索信息，可当作页面刷新按钮哦">搜索</button>
</div>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-danger layui-btn-sm" lay-event="refresh">刷新</button>
    </div>
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="del">删除</a>
</script>
<script>
    layui.use(['table','laydate','util'], function(){
        var table = layui.table
            ,laydate = layui.laydate
            ,util=layui.util;

        table.render({
            elem: '#test'
            ,url:'admin/findAllClockInToday'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,title: '积分设置数据表'
            ,height:520
            ,cols: [[
                {field:'id', title:'ID', width:'8%', fixed: 'left', unresize: true, sort: true}
                ,{field:'uid', title:'用户ID', width:'15%', edit: 'text', sort: true}
                ,{field:'uname', title:'用户名', width:'15%', edit: 'text'}
                ,{field:'time', title:'打卡时间', width:'13%', edit: 'text',templet:function (d) {
                        return util.toDateString(d.time,"yyyy-MM-dd HH:mm:ss")
                    }}
                ,{field:'clockin', title:'打卡类型', width:'17%'}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo',width:'32%'}
            ]]
            ,page: true
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'refresh':
                    table.reload('test',{
                        url:'admin/findAllClockIn'
                        ,where:{
                            clockin:'',
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
                        url:'admin/deleteClockInToday',
                        data:{
                            id:data.id
                        },
                        success:function (data1) {
                            layer.msg("删除成功");
                        }
                    })
                });
            }
        });
        $('#find').click(function () {
            table.reload('test',{
                url:'admin/findAllClockInToday'
                ,where:{
                    clockin:$('#clockin').val()
                }
            })
        })
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
