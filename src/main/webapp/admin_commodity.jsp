<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/3/18
  Time: 9:35
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
<div class="demoTable">
    <div class="layui-inline">
        <input class="layui-input"  id="uid" autocomplete="off" placeholder="根据商品id">
    </div>
    <div class="layui-inline" style="width: 200px">
        <select class="layui-input" id="commodity_state" >
            <option value="">根据兑换情况</option>
            <option value="on" >已完成</option>
            <option value="null" >未完成</option>
        </select>
    </div>
    <button class="layui-btn" data-type="reload" id="find" title="不填写搜索信息，可当作页面刷新按钮哦">搜索</button>
</div>
<table class="layui-hide" id="test" lay-filter="test"></table>

<script type="text/html" id="commodity">
    <img src="uploads/{{d.image}}" style="height: 30px;width: 30px">
</script>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon"></i></a>
</script>

<script type="text/html" id="img">
    <img src="uploads/{{d.cimage}}" style="height: 30px;width:30px;">
</script>

<script type="text/html" id="switchState">
    <input type="checkbox" id="state" name="state" value="{{d.state}}" lay-skin="switch" lay-text="是|否" lay-filter="stateDemo" {{ d.state == "on" ? 'checked' : '' }}>
</script>
<script>
    layui.use(['table','form' ,'util'],function(){
        var table = layui.table
            ,form = layui.form
            ,util = layui.util;

        table.render({
            elem: '#test'
            ,url:'admin/findAllExchange'
            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
            ,title: '用户数据表'
            ,height:545
            ,cols: [[
                {type: 'checkbox', fixed: 'left'}
                ,{field:'id', width:'8%', title: 'ID',fixed: 'left',unresize: true,sort: true}
                ,{field:'uid', width:'8%', title: '用户'}
                ,{field:'cimage', width:'8%', title: '商品图片',templet:'#img'}
                ,{field:'cname', width:'15%', title: '商品名'}
                ,{field:'cintegral', title: '商品积分',  width:'10%',sort: true}
                ,{field:'cintroduce', width:'16%', title: '商品详情'}
                ,{field:'time', width:'15%', title: '兑换时间',sort: true,templet:function (d) {
                        return util.toDateString(d.time,"yyyy-MM-dd HH:mm:ss")
                    }}
                ,{field:'state', title:'完成兑换', width:'10%',templet:'#switchState', unresize: true}
                ,{fixed: 'right', title:'操作', toolbar: '#barDemo', width:'10%'}
            ]]
            ,page: true
        });


        $('#find').click(function () {
            if ($('#uid').val()==""){
                var uid=0;
            }else{
                var uid=$('#uid').val();
            }

            table.reload('test',{
                url:'admin/findAllExchange'
                ,where:{
                    uid:uid,
                    state:$('#commodity_state').val(),
                }
            })
        });
        //监听性别操作
        form.on('switch(stateDemo)',function(obj){
            var data = $(obj.elem);
            var id=data.parents('tr').first().find('td').eq(1).text();
            console.log(id);
            var state = this.value;
            console.log(state);
            if (state == "on") {
                state = "null";
            } else {
                state = "on";
            }
            ;
            $.ajax({
                type: 'post',
                url: 'admin/Updateexchange',
                data: {
                    state: state,
                    id: id
                },
                success: function (data) {
                    if (state=="on"){
                        layer.msg("完成兑换");
                    }else{
                        layer.msg("兑换失败");
                    }

                }
            })

        });
        // form.on('switch(stateDemo)', function(obj){
        //     layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
        // });
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
                        url:'admin/removeshopping',
                        data:{
                            id:data.id
                        },
                        success:function (data) {
                            layer.msg("删除成功");
                        }
                    })
                });
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
