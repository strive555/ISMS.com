<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/3/26
  Time: 21:33
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
<table class="layui-hide" id="test" lay-filter="test"></table>
<div id="editGoods" style="display: none;width: 500px;">
    <div class="layui-form-item">
        <label class="layui-form-label" style="width:100px">消息主题</label>
        <div class="layui-input-block">
            <input type="text" id="theme" lay-verify="required" lay-reqtext="消息主题是必填项，岂能为空？" autocomplete="off" placeholder="请输入标题" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label" style="width:100px">正文内容</label>
        <div class="layui-input-block">
            <textarea id="content" placeholder="请输入内容" class="layui-textarea" lay-verify="required" lay-reqtext="消息主题是必填项，岂能为空？"></textarea>
        </div>
    </div>
</div>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script>
    layui.use(['table','util' ],function(){
        var table = layui.table,
        util=layui.util;

        table.render({
            elem: '#test'
            ,url:'admin/findallnotice'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,title: '用户数据表'
            ,height:545
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID', width:'6%', fixed: 'left', unresize: true, sort: true}
                ,{field:'theme', title:'公告主题', width:'21.5%', edit: 'text'}
                ,{field:'content', title:'公告内容', width:'40%', edit: 'text'}
                ,{field:'time', title:'发布的时间', width:'14%', edit: 'text',templet:function (d) {
                        return util.toDateString(d.time,"yyyy-MM-dd HH:mm:ss")
                    }}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:'15%'}
            ]]
            ,page: true
        });

        //头工具栏事件
        table.on('toolbar(test)', function(obj){
            var checkStatus = table.checkStatus(obj.config.id);
            switch(obj.event){
                case 'getCheckData':
                    var data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                    break;
                case 'getCheckLength':
                    var data = checkStatus.data;
                    layer.msg('选中了：'+ data.length + ' 个');
                    break;
                case 'isAll':
                    layer.msg(checkStatus.isAll ? '全选': '未全选');
                    break;

                //自定义头工具栏右侧图标 - 提示
                case 'LAYTABLE_TIPS':
                    layer.alert('这是工具栏右侧自定义的一个图标按钮');
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
                        url:'admin/removenotice',
                        data:{
                            id:data.id
                        },
                        success:function (data) {
                            layer.msg("删除成功");
                        }
                    })
                });
            } else if(obj.event === 'edit'){
                $('#theme').val(data.theme);
                $('#content').val(data.content);
                layer.open({
                    title: '编辑',
                    type: 1,
                    btn: ['确定', '取消'],
                    content: $('#editGoods'),
                    area:['600px','300px'],
                    yes: function (index, layero) {
                            $.ajax({
                                type: 'post',
                                url: 'admin/updatenotice',
                                data:{
                                    id:data.id,
                                    theme:$('#theme').val(),
                                    content:$('#content').val()
                                },
                                success:function(data){
                                    layer.msg("编辑成功",{
                                        time:1000
                                    },function () {
                                        layer.closeAll();
                                    });
                                }
                            })
                    }
                });
            }else if(obj.event ==='detail'){
               $.ajax({
                   type:'post',
                   url:'admin/findFiles',
                   data:{
                     time:new Date(data.time)
                   },
                   success:function (filedata) {
                       if(filedata.length==0){
                           layer.open({
                               title:'文件栏',
                               type:1,
                               btn:'确定',
                               content:'<div style="padding: 20px 100px;">该公告没有文件哦</div>',
                               offset:['40%','40%']
                           })
                       }else{
                           var id=filedata[0].time;
                           var notice=[];
                           for(var i=0;i<filedata.length;i++){
                               notice.push('<a  href="uploads/'+filedata[i].files+'" style="position: relative;left: -25%"><font size="1">'+filedata[i].files+'</font></a> ');
                           }
                           layer.open({
                               title:'文件栏',
                               type:1,
                               btn:'确定',
                               content:'<div style="padding: 20px 100px;">'+notice+'</div>',
                               offset:['40%','40%']
                           })
                       }
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
