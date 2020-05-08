<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/2/16
  Time: 16:36
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
    body{
        background-color: #3c3f41;
    }
    .site-doc-icon li .layui-anim {
        width: 65%;
        height: 50%;
        line-height: 300px;
        margin:10%;
        text-align: center;
        background-color: #009688;
        cursor: pointer;
        color: #fff;
        border-radius: 50%;
    }
</style>
<body>
<br><br>
<div class="card mb-5" style="max-width: 100%;">
    <div class="row no-gutters">
        <div class="col-md-4">
            <ul class="site-doc-icon site-doc-anim">
                <li>
                    <div class="layui-anim" data-anim="layui-anim-rotate"><font size="10" id="integral"></font></div>
                </li>
            </ul>
            <div style="position:relative;left:10%"><font size="10" id="shoppingintegral"></font></div>
        </div>
        <div class="col-md-8">
            <div class="card-body">
                <h5 class="card-title">积分规则</h5>
                <p class="card-text" id="rule"></p>
            </div>
        </div>
    </div>
</div>
<script>
    layui.use([], function () {
        var $ = layui.jquery;
        //演示动画开始
        $('.site-doc-icon .layui-anim').on('click', function(){
            var othis = $(this), anim = othis.data('anim');

            //停止循环
            if(othis.hasClass('layui-anim-loop')){
                return othis.removeClass(anim);
            }
            othis.removeClass(anim);
            setTimeout(function(){
                othis.addClass(anim);
            });
        });
        //演示动画结束
    })
    function refresh() {
        $.ajax({
            type:'post',
            url:'findmyintegral',
            success:function (data) {
                console.log(data);
                document.getElementById('integral').innerHTML=data[0].uintegral;
                document.getElementById('shoppingintegral').innerHTML="商店可用积分"+data[0].allintegral;
            }
        })
    }
    setInterval("refresh()",1000);

    function integralrule() {
        $.ajax({
            type:'post',
            url:'admin/findIntegralRule',
            success:function (data) {
                document.getElementById('rule').innerHTML=data[0].content;
            }
        })
    }
    setInterval("integralrule()",1000);
</script>
</body>
</html>
