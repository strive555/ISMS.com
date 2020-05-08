<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/3/26
  Time: 23:49
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
<form class="layui-form">
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
    <div class="layui-form-item">
        <label class="layui-form-label" style="width:100px">任务类型</label>
        <div class="layui-input-block">
            <select id="type">
                <option value="日常任务" >日常任务</option>
                <option value="紧急任务" >紧急任务</option>
            </select>
        </div>
    </div>
</div>
</form>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-normal  layui-btn-xs" lay-event="state">打回</a>
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<script type="text/html" id="toolbarDemo">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="Jw">紧急任务</button>
        <button class="layui-btn layui-btn-sm" lay-event="Rw">日常任务</button>
        <button class="layui-btn layui-btn-sm" lay-event="refresh">刷新</button>
    </div>

</script>
<script type="text/html" id="tablestate">
    <input type="checkbox" id="state" name="state" value="{{d.state}}" lay-skin="switch" lay-text="是|否" lay-filter="stateDemo" {{ d.state == "yes" ? 'checked' : '' }}>
</script>

<script type="text/html" id="checkboxTpl">
    <input type="checkbox" name="lock" value="{{d.uid}}" title="是" lay-filter="lockDemo" {{ d.uid != 0 ? 'checked' : '' }}>
</script>
<script>
    layui.use(['table','util' ,'form'],function(){
        var table = layui.table,
            util=layui.util,
            form = layui.form;

        table.render({
            elem: '#test'
            ,url:'admin/FindAllTask'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,title: '用户数据表'
            ,height:545
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', title:'ID', width:'6%', fixed: 'left', unresize: true, sort: true,hide:true}
                ,{field:'theme', title:'公告主题', width:'8%', edit: 'text'}
                ,{field:'content', title:'公告内容', width:'10.5%', edit: 'text'}
                ,{field:'time', title:'发布的时间', width:'13%', edit: 'text',templet:function (d) {
                        return util.toDateString(d.time,"yyyy-MM-dd HH:mm:ss")
                    }}
                ,{field:'type', title:'类型', width:'8%', edit: 'text'}
                ,{field:'uid', title:'接收用户ID', width:'8%', edit: 'text'}
                ,{field:'uid', title:'是否被接收', width:'10%',templet: '#checkboxTpl', unresize: true}
                ,{field:'state', title:'完成', width:'8%',templet:'#tablestate'}
                ,{field:'finishtime', title:'提交时间', width:'14%', edit: 'text',templet:function (d) {
                    if(d.finishtime=="" || d.finishtime==null){
                        return"";
                        }else{
                            return util.toDateString(d.finishtime,"yyyy-MM-dd HH:mm:ss")
                        };
                    }}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:'17%'}
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
                case 'Jw':
                    table.reload('test',{
                        url:'admin/FindAllTask'
                        ,where:{
                            type:"紧急任务"
                        },
                    })
                    break;
                case 'Rw':
                    table.reload('test',{
                        url:'admin/FindAllTask'
                        ,where:{
                            type:"日常任务"
                        },
                    })
                    break;
                case 'refresh':
                    table.reload('test',{
                        url:'admin/FindAllTask'
                        ,where:{
                            type:""
                        },
                    })
                    break;
                //自定义头工具栏右侧图标 - 提示
                case 'LAYTABLE_TIPS':
                    layer.alert('这是工具栏右侧自定义的一个图标按钮');
                    break;
            };
        });

        form.on('checkbox(lockDemo)', function(obj){
           layer.msg("主人，这只是查看文件是否被接受，不能操作");
        });
        form.on('switch(stateDemo)',function(obj){
            var data = $(obj.elem);
            var id=data.parents('tr').first().find('td').eq(1).text();
            var uid=data.parents('tr').first().find('td').eq(6).text();
            var state = this.value;
            if (state == "no") {
                state = "yes";
            } else {
                state = "no";
            }
            ;
            $.ajax({
                type: 'post',
                url: 'UpdateTskState',
                data: {
                    state: state,
                    id: id
                },
                success: function (data1) {
                    if (state=="no"){
                        layer.msg("审核未通过");
                    }else{
                        layer.msg("审核通过",{
                            time:1000
                        },function () {
                            layer.open({
                                type: 1
                                ,title: '积分奖励'
                                ,content: '<div style="padding: 20px 100px;"><input type="text"  id="integral"></div>'
                                ,btn: '确定'
                                ,btnAlign: 'c' //按钮居中
                                ,shade: 0 //不显示遮罩
                                ,yes: function(){
                                    $.ajax({
                                        type:'post',
                                        url:'integralMath',
                                        data:{
                                            integral:$('#integral').val(),
                                            id:uid
                                        },
                                        success:function () {
                                            layer.msg("奖励成功");
                                        }
                                    })
                                    $.ajax({
                                        type:'post',
                                        url:'addMyEvent',
                                        data:{
                                            uid:uid,
                                            event:'完成任务',
                                            time:new Date(),
                                            integral:'+'+$('#integral').val()
                                        },
                                        success:function (data) {
                                            console.log("完成任务");
                                        }
                                    })
                                    layer.closeAll();
                                }
                            });
                        });
                    }

                }
            })
        });
        function renderForm() {
            layui.use('form',function () {
                var form = layui.form;
                form.render();
            })
        }
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
                        url:'admin/removetask',
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
                $('#type').val(data.type);
                renderForm();
                layer.open({
                    title: '编辑',
                    type: 1,
                    btn: ['确定', '取消'],
                    content: $('#editGoods'),
                    area:['600px','400px'],
                    yes: function (index, layero) {
                        $.ajax({
                            type: 'post',
                            url: 'admin/updatetask',
                            data:{
                                id:data.id,
                                theme:$('#theme').val(),
                                content:$('#content').val(),
                                type:$('#type').val()
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
            }else if(obj.event === 'state'){
                $.ajax({
                    type:'post',
                    url:'UpdateTskFinish',
                    data:{
                        id:data.id
                    },
                    success:function () {
                        layer.msg("成功打回");
                        $.ajax({
                            type: 'post',
                            url: 'UpdateTskState',
                            data: {
                                state: 'no',
                                id: data.id
                            },
                            success: function () {

                            }
                        })
                    }
                })
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
