<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/3/16
  Time: 15:46
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
<style>
    .layui-layout-admin .layui-body{
        bottom: 0px;
    }
</style>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo">基于积分制的企业管理系统</div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <img src="static/layui/images/face/7.gif">
                    <%=session.getAttribute("adminname")%>
                </a>
                <dl class="layui-nav-child">
                    <dd><a id="updetepwd" style="color: black">安全管理</a></dd>
                    <dd><a href="admin_login">退出登录</a></dd>
                </dl>
            </li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree"  lay-filter="test">
                <li class="layui-nav-item"><a  >用户管理</a>
                    <dl class="layui-nav-child">
                        <dd><a id="usermanage">系统用户</a></dd>
                        <dd><a id="user_integral">用户积分</a></dd>
                        <%if((int)session.getAttribute("adminempower")==0){
                        } else{ %>
                        <dd><a id="manage">管理员</a></dd>
                        <% } %>
                    </dl>
                </li>
                <li class="layui-nav-item"><a >商城管理</a>
                    <dl class="layui-nav-child">
                        <dd><a id="shoppingmanage">商城商品</a></dd>
                        <dd><a id="commodity">兑换商品</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a >消息管理</a>
                    <dl class="layui-nav-child">
                        <dd><a id="publishnews">发布消息</a></dd>
                        <dd><a id="noticemanage">公告消息</a></dd>
                        <dd><a id="taskmanage">任务消息</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a>设置中心</a>
                    <dl class="layui-nav-child">
                        <dd><a id="setup">系统设置</a></dd>
                        <dd><a id="setRecords">打卡设置记录</a></dd>
                        <dd><a id="integral">积分设置记录</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a  id="files">文件中心</a></li>
                <li class="layui-nav-item"><a >权限中心</a>
                    <dl class="layui-nav-child">
                        <%if((int)session.getAttribute("adminempower")==0){
                        } else{ %>
                            <dd><a id="empower">管理员权限</a></dd>
                        <% } %>
                        <dd><a id="userempower">系统用户权限</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a>日志管理</a>
                    <dl class="layui-nav-child">
                        <dd><a id="log">今日日志</a></dd>
                        <dd><a id="alllog">历史日志</a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;height:100%;">
            <iframe id="content-body" src="" frameborder="0" height="100%" width="100%" scrolling="no"></iframe>
        </div>
    </div>

    <%--    <div class="layui-footer">--%>
    <%--        <!-- 底部固定区域 -->--%>
    <%--        © layui.com - 底部固定区域--%>
    <%--    </div>--%>
</div>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;
    });
    $('#content-body').prop('src','admin_files.jsp');
    $('#usermanage').click(function () {
        $('#content-body').prop('src','admin_user.jsp');
    })
    $('#shoppingmanage').click(function () {
        $('#content-body').prop('src','admin_shopping.jsp');
    })
    $('#commodity').click(function () {
        $('#content-body').prop('src','admin_commodity.jsp');
    })
    $('#publishnews').click(function () {
        $('#content-body').prop('src','admin_publishnews.jsp');
    })
    $('#noticemanage').click(function () {
        $('#content-body').prop('src','admin_notice.jsp');
    })
    $('#taskmanage').click(function () {
        $('#content-body').prop('src','admin_task.jsp');
    })
    $('#setup').click(function () {
        $('#content-body').prop('src','admin_time.jsp');
    })
    $('#files').click(function () {
        $('#content-body').prop('src','admin_files.jsp');
    })
    $('#manage').click(function () {
        $('#content-body').prop('src','admin_manage.jsp');
    })
    $('#empower').click(function () {
        $('#content-body').prop('src','admin_empower.jsp');
    })
    $('#userempower').click(function () {
        $('#content-body').prop('src','admin_userempower.jsp');
    })
    $('#setRecords').click(function () {
        $('#content-body').prop('src','admin_setrecords.jsp');
    })
    $('#integral').click(function () {
        $('#content-body').prop('src','admin_integral.jsp');
    })
    $('#alllog').click(function () {
        $('#content-body').prop('src','admin_alllog.jsp');
    })
    $('#log').click(function () {
        $('#content-body').prop('src','admin_log.jsp');
    })
    $('#user_integral').click(function () {
        $('#content-body').prop('src','admin_userintegral.jsp');
    })

    layui.use('layer', function(){ //独立版的layer无需执行这一句
        var $ = layui.jquery, layer = layui.layer;
        $('#updetepwd').click(function () {
            layer.open({
                title:'重置密码',
                type:1,
                btn:'确定重置',
                content:'<div style="padding: 20px 100px;"><input type="text" id="pwd"></div>',
                btnAlign: 'c', //按钮居中
                shade: 0 ,//不显示遮罩
                yes:function () {
                    var id='<%=session.getAttribute("adminid")%>'
                   $.ajax({
                       type:'post',
                       url:'admin/UpdateAdminPwd',
                       data:{
                           id:id,
                           adminpwd:$('#pwd').val()
                       },
                       success:function (data) {
                           layer.msg("重置成功",{
                               time:1000
                           },function () {
                               layer.closeAll();
                           });
                       }
                   })
                }
            })
        })
    })

    function refreadmin() {
        var id='<%=session.getAttribute("adminid")%>';
        console.log(id);
        $.ajax({
            type:'post',
            url:'admin/refreshAdmin',
            data:{
                id:id
            },
            success:function () {
            }
        })
    }
    setInterval("refreadmin()",1000);

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
