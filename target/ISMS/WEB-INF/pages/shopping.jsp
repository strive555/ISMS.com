<%--
  Created by IntelliJ IDEA.
  User: 奎坤
  Date: 2020/2/16
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
  <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://www.layuicdn.com/layui/css/layui.css">
  <script src="js/jquery.min.js"></script>
  <script src="https://www.layuicdn.com/layui/layui.js"></script>
</head>
<style>
  body{background-color: #3c3f41}
</style>
<body>
<div class="row" id="biuuu_city_list"></div>
</body>
<script>
  function refresh() {
    $.ajax({
      url: 'findshopping',
      success: function (data) {
        console.log(data);
        layui.use(['laypage', 'layer'], function () {
          var laypage = layui.laypage
                  , layer = layui.layer;

          //测试数据
          var adddata = [];

          for (var i = 0; i < data.length; i++) {

            adddata.push(
                    '<br><div class="col-sm-2">\n' +
                    '        <div class="card"  >\n' +
                    '            <div class="card-body" >\n' +
                    '               <img src="uploads/'+data[i].image+'"  style="width: 100%; height: 230px;">\n' +
                    '                <h5 class="card-title">'+data[i].name+'</h5>\n' +
                    '                <h5 class="card-title">'+data[i].integral+'</h5>\n' +
                    '                <p class="card-text">'+data[i].introduce+'</p>\n' +
                    '                <a  onclick='+'sp("'+data[i].name+'","'+data[i].image+'","'+data[i].integral+'","'+data[i].introduce+'","<%=session.getAttribute("userid")%>")'+' class="btn btn-primary">立即兑换</a>\n' +
                    '            </div>\n' +
                    '        </div>\n' +
                    '    </div>');

          }
          //调用分页
          laypage.render({
            elem: 'demo20'
            ,limit:100000000
            ,count: data.length
            ,jump: function (obj) {
              //模拟渲染
              document.getElementById('biuuu_city_list').innerHTML = function () {
                var arr = []
                        , thisData = adddata.concat().splice(obj.curr * obj.limit - obj.limit, obj.limit);
                layui.each(thisData, function (index, item) {
                  arr.push(item );
                });
                return arr.join('');
              }();
            }
          });
        })
      }
    })
  }
  setInterval("refresh()",1000);

  function sp(spname,image,integral,introduce,uid){
    layui.use('layer', function(){
      var layer = layui.layer;
        $.ajax({
          type: 'post',
          url: 'exchangecommodity',
          data: {
            cname: spname,
            cimage: image,
            cintegral: integral,
            cintroduce: introduce,
            uid: uid,
            time: new Date()
          },
          success: function (data) {
            console.log(data);
            if (data == 1000) {
              layer.msg("兑换成功");
            } else {
              layer.msg("兑换失败，您的可兑换积分不足");
            }
          }
        })
    })
  }
</script>
</html>
