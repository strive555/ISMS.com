package cn.ISMS.controller;

import cn.ISMS.domain.*;
import cn.ISMS.service.AdminService;
import cn.ISMS.service.UserService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private AdminService adminService;

    @RequestMapping("/LOGIN")
    public String login(){ return "login";}

    @RequestMapping("/Login")
    @ResponseBody
    public String login(User user,HttpServletRequest request){
        String result="";
        HttpSession session = request.getSession();
        List<User> list=userService.Login(user.getPhone(),user.getPwd());
        if(list.isEmpty()){
            result="500";
        }else{
            for(User userdata:list){
                if(userdata.getEmpower()==0){
                   result="600";
                }else{
                    session.setAttribute("userid",userdata.getId());
                    session.setAttribute("useridentity",userdata.getIdentity());
                    session.setAttribute("username",userdata.getName());
                    session.setAttribute("userimage",userdata.getImage());
                    session.setAttribute("userphone",userdata.getPhone());
                    session.setAttribute("userprovince",userdata.getProvince());
                    session.setAttribute("usercity",userdata.getCity());
                    session.setAttribute("userarea",userdata.getArea());
                    session.setAttribute("userpwd",userdata.getPwd());
                    List<UserIntegral> mydata=userService.findMyData(user.getPhone());
                    System.out.println(userdata.getImage());
                    if(mydata.isEmpty()){
                        user.setName(userdata.getName());
                        user.setPhone(userdata.getPhone());
                        user.setId(userdata.getId());
                        user.setImage(userdata.getImage());
                        adminService.adduser_integral(user);
                    }else{

                    }
                    result="1000";
                }
                }

        }
        return result;
    }

    @RequestMapping("/register")
    public void register(User user, HttpServletRequest request, HttpServletResponse response) throws IOException {
        userService.saveUser(user);
        response.sendRedirect(request.getContextPath()+"/login");
        return;
    }


    @RequestMapping("/findintegral")
    @ResponseBody
    public List<UserIntegral> findIntegral(){
        List<UserIntegral> list=userService.findIntegral();
            return list;
    }

    @RequestMapping("/findmyintegral")
    @ResponseBody
    public List<UserIntegral> findMyIntegral(HttpServletRequest request){
        HttpSession session = request.getSession();
        int id=(int)session.getAttribute("userid");
        List<UserIntegral> list=userService.findMyIntegral(id);
        for(UserIntegral userIntegral:list){
            session.setAttribute("userallintagral",userIntegral.getAllintegral());
            session.setAttribute("useruintegral",userIntegral.getUintegral());
        }
        return list;
    }

    @RequestMapping("/updatepwd")
    @ResponseBody
    public String  updatepwd(String pwd,String name){
        userService.updatepwd(pwd, name);
        return "1000";
    }

    @RequestMapping("/updatemydata")
    @ResponseBody
    public String upload(HttpServletRequest request, MultipartFile image) throws Exception {
        HttpSession session = request.getSession();
        // 先获取到要上传的文件目录
        String path = request.getSession().getServletContext().getRealPath("/uploads");
        // 创建File对象，一会向该路径下上传文件
        File file = new File(path);

        // 判断路径是否存在，如果不存在，创建该路径
        if(!file.exists()) {
            file.mkdirs();
        }

        // 获取到上传文件的名称
        String filename=image.getOriginalFilename();

        //保存唯一名称
//       String uuid=UUID.randomUUID().toString().replace("-","");
//       filename=uuid+"_"+filename;
        long time= new Date().getTime();
        filename=time+filename;

        // 上传文件
        image.transferTo(new File(file, filename));

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
        User user = new User();
        user.setName(multipartRequest.getParameter("name"));
        user.setPhone(multipartRequest.getParameter("phone"));
        user.setIdentity(multipartRequest.getParameter("identity"));
        user.setProvince(multipartRequest.getParameter("province"));
        user.setCity(multipartRequest.getParameter("city"));
        user.setArea(multipartRequest.getParameter("area"));
        user.setId(Integer.parseInt(multipartRequest.getParameter("id")));
        user.setImage(filename);
        if(multipartRequest.getParameter("phone").equals("001")){
            userService.updateUserdata(user);
            return "1000";
        }else {
            List<User> list = adminService.findphone(user.getPhone());
            if (list.isEmpty()) {
                userService.updatemydata(user);
                return "1000";
            } else {
                return "600";
            }
        }
    }

    @RequestMapping("/UpdateMyData")
    @ResponseBody
    public String UpdateMyData(User user){

        if(user.getPhone().equals("001")){
            userService.updateUserdata(user);
            return "1000";
        }else{
            List<User> list=adminService.findphone(user.getPhone());
            if(list.isEmpty()){
                userService.updatemydata(user);
                return "1000";
            }else{
                return "600";
            }
        }

    }

    @RequestMapping("/mydatarefresh")
    @ResponseBody
    public List<User> MyData(int id,HttpServletRequest request){
        HttpSession session = request.getSession();
        List<User> list=userService.mydata(id);
        for(User userdata:list){
            session.setAttribute("userid",userdata.getId());
            session.setAttribute("useridentity",userdata.getIdentity());
            session.setAttribute("username",userdata.getName());
            session.setAttribute("userimage",userdata.getImage());
            session.setAttribute("userphone",userdata.getPhone());
            session.setAttribute("userprovince",userdata.getProvince());
            session.setAttribute("usercity",userdata.getCity());
            session.setAttribute("userarea",userdata.getArea());
            session.setAttribute("userpwd",userdata.getPwd());
        }
        return list;
    }


    @RequestMapping("/addclockin")
   @ResponseBody
    public String addclockin(ClockIn clockin){
        userService.addclockin(clockin);
        userService.tableclockin(clockin);
        return "1000";
    }

    @RequestMapping("/delectclockin")
    @ResponseBody
    public String delectclockin(){
        userService.deleteclockin();
        return "1000";
    }

    @RequestMapping("/findclockin")
    @ResponseBody
    public String findclockin(int id,HttpServletRequest request){
        HttpSession session = request.getSession();
        List<ClockIn> list=userService.findclockin(id);
        session.setAttribute("clockincondition",list);
        for(ClockIn clockin:list){
            if(clockin.getClockin().equals("签退")){
                session.setAttribute("userclockin",clockin.getClockin());
            }else{
                session.removeAttribute("userclockin");
            }
        }
        if(list.isEmpty()){
            return "500";
        }else{
            return "1000";
        }

    }


    @RequestMapping("/usertask")
    @ResponseBody
    public String usertask(Task task){
        userService.usertask(task);
        return "1000";
    }

    @RequestMapping("/exchangecommodity")
    @ResponseBody
    public String exchangecommodity(Exchange exchange){
        String result="";
        List<UserIntegral> list=userService.findMyIntegral(exchange.getUid());
        for (UserIntegral integral:list){
            if(integral.getAllintegral()>=exchange.getCintegral()){
                userService.addexchange(exchange);
                userService.exchangeintegral(exchange.getCintegral(),exchange.getUid());
                result= "1000";
            }else{
                result= "500";
            }
        }
        return result;
    }

    @RequestMapping("/FindMyExchange")
    @ResponseBody
    public Map<String,Object> findmyexchange(int page,int limit,HttpServletRequest request){
        HttpSession session = request.getSession();
        int id =(int)session.getAttribute("userid");
        int num=(page-1)*limit;
        List<Exchange> list=userService.findmyexchange(id,num,limit);
        String count=userService.Count();
        System.out.println(list+"/"+num+"/"+limit);
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("code","0");
        map.put("msg","");
        map.put("count",count);
        map.put("data",list);
        return map;
    }


    @RequestMapping("/integralMath")
    @ResponseBody
    public String intagralmath(int integral,int id){
        System.out.println(integral+"/"+id);
        userService.integralmath(integral,id);
        return "1000";
    }

    @RequestMapping("/TaskFinishTime")
    @ResponseBody
    public String taskfinishTime(Task task){
        System.out.println(task);
        userService.taskfinishtime(task);
        return "1000";
    }

    @RequestMapping("/UpdateTskState")
    @ResponseBody
    public String UpdateTskState(Task task){
        System.out.println(task);
        userService.updatetaskstate(task);
        return "1000";
    }

    @RequestMapping("/UpdateTskFinish")
    @ResponseBody
    public String UpdateTskFinish(Task task){
        System.out.println(task);
        userService.updatetaskfinish(task);
        return "1000";
    }

    @RequestMapping(value = "/Fileupload",produces="application/json;charset=utf-8")
    @ResponseBody
    public Map<String,Object> Fileupload(HttpServletRequest request,MultipartFile file){
        HttpSession session = request.getSession();
        int uid=(int)session.getAttribute("userid");
        String uname=(String)session.getAttribute("username");
        Map<String, Object> uploadData = new HashMap<String, Object>();
        String Path = request.getSession().getServletContext().getRealPath("/AdminUploads");
        String fileName = file.getOriginalFilename();
        File dir = new File(Path,fileName);
        if(!dir.exists()){
            dir.mkdirs();
        }
        AdminFiles adminFiles = new AdminFiles();
        adminFiles.setUid(uid);
        adminFiles.setUname(uname);
        adminFiles.setFiles(fileName);
        adminFiles.setTime(new Date());
        try {
            file.transferTo(dir);
            System.out.println("上传");
            userService.FileUploads(adminFiles);
            uploadData.put("code", 0);
            uploadData.put("msg", "上传成功");
            uploadData.put("data", "");
        } catch (IOException e) {
            uploadData.put("code", -1);
            uploadData.put("msg", "上传失败");
            uploadData.put("data", "");
        }
        return uploadData;
    }

    @RequestMapping("/findMyFiles")
    @ResponseBody
    public Map<String,Object> findMyFiles(int page,int limit,int uid){
        int num=(page-1)*limit;
        Map<String,Object> map = new HashMap<>();
        List<AdminFiles>  list=userService.findMyFiles(uid,num,limit);
        String count=userService.FileCount();
        map.put("code","0");
        map.put("msg","");
        map.put("count",count);
        map.put("data",list);
        System.out.println(map);
        return map;
    }

    @RequestMapping("/addMyEvent")
    @ResponseBody
    public String addMyEvent(IntegralAward integralAward){
        userService.addMyEvent(integralAward);
        return "1000";
    }

    @RequestMapping("/findMyEvent")
    @ResponseBody
    public Map<String,Object> findMyEvent(HttpServletRequest request){
        HttpSession session = request.getSession();
        int uid = (int)session.getAttribute("userid");
        Map<String,Object> map = new HashMap<>();
        List<IntegralAward> list=userService.findMyIntegralEvent(uid);
       map.put("code","0");
       map.put("msg","");
       map.put("data",list);
       return map;
    }
}
