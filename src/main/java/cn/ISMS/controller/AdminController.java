package cn.ISMS.controller;

import cn.ISMS.domain.*;
import cn.ISMS.service.AdminService;
import cn.ISMS.service.ShoppingService;
import cn.ISMS.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private UserService userService;

    @Autowired
    private ShoppingService shoppingService;

    @RequestMapping("/login")
    public String  login(){
        return "admin_login";
    }

    @RequestMapping("/dologin")
    @ResponseBody
    public String  dologin(String adminname,String adminpwd,HttpServletRequest request){
        String result="";
        HttpSession session = request.getSession();
        List<Admin> list=adminService.AdminLogin(adminname,adminpwd);
        List<Admin> list1=adminService.SuperAdmin(adminname, adminpwd);
        if(list.isEmpty()){
            if(list1.isEmpty()){
                result="500";
            }else{
                for(Admin admin:list1){
                    session.setAttribute("adminname",admin.getAdminname());
                    session.setAttribute("adminpwd",admin.getAdminpwd());
                    session.setAttribute("adminid",admin.getId());
                    session.setAttribute("adminempower",admin.getAdminempower());
                }
                result= "1000";
            }

        }else{
            for(Admin admin:list){
                if(admin.getEmpower()==0){
                    result="600";
                }else{
                    session.setAttribute("adminname",admin.getAdminname());
                    session.setAttribute("adminpwd",admin.getAdminpwd());
                    session.setAttribute("adminid",admin.getId());
                    session.setAttribute("adminempower",admin.getAdminempower());
                    result= "1000";
                }
            }

        }
        return result;
    }

    @RequestMapping("/refreshAdmin")
    @ResponseBody
    public void refreshadmin(int id,HttpSession session){
        List<Admin> list=adminService.refreadmin(id);
        List<Admin> list1=adminService.refreadmin_super(id);
        if(list.isEmpty()){
            if(list1.isEmpty()){

            }else{
                for(Admin admin:list1){
                    session.setAttribute("adminname",admin.getAdminname());
                    session.setAttribute("adminpwd",admin.getAdminpwd());
                    session.setAttribute("adminid",admin.getId());
                    session.setAttribute("adminempower",admin.getAdminempower());
                }
            }
        }else{
            for(Admin admin:list){
                session.setAttribute("adminname",admin.getAdminname());
                session.setAttribute("adminpwd",admin.getAdminpwd());
                session.setAttribute("adminid",admin.getId());
                session.setAttribute("adminempower",admin.getAdminempower());
            }
        }
    }





    @RequestMapping("/UpdateAdminPwd")
    @ResponseBody
    public String UpdateAdminPwd(Admin admin){
        adminService.updateadminpwd(admin);
        return "1000";
    }
    @RequestMapping("/adduser")
    @ResponseBody
    public String savauser(User user){
        List<User> list=adminService.findphone(user.getPhone());
        if(list.isEmpty()){
            adminService.saveUser(user);
            return "1000";
        }else{
            return "600";
        }
    }

    @RequestMapping("/AddUser")
    @ResponseBody
    public String AddUser(HttpServletRequest request, MultipartFile image) throws Exception {
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
        user.setPwd(multipartRequest.getParameter("pwd"));
        user.setTime(new Date());
        user.setImage(filename);
        user.setPhone(multipartRequest.getParameter("phone"));
        List<User> list=adminService.findphone(user.getPhone());
        if(list.isEmpty()){
            adminService.saveUser(user);
            return "1000";
        }else{
            return "600";
        }
    }

    @RequestMapping("/removeuser")
    @ResponseBody
    public String removeuser(int id){
        adminService.removeuser(id);
        return "1000";
    }

    @RequestMapping("/updateuser")
    @ResponseBody
    public String updateuser(User user){
        System.out.println(user.getPhone());
        if(user.getPhone().equals("001")){
            System.out.println("无手机号");
                adminService.updateUserdata(user);
                return "1000";
        }else{
            System.out.println("手机号");
            List<User> list=adminService.findphone(user.getPhone());
            if(list.isEmpty()){
                adminService.updateUserData(user);
                return "1000";
            }else{
                return "600";
            }
        }

    }

    @RequestMapping("/updateUserDate")
    @ResponseBody
    public String updateUserDate(HttpServletRequest request, MultipartFile image) throws Exception {
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
        user.setPwd(multipartRequest.getParameter("pwd"));
        user.setId(Integer.parseInt(multipartRequest.getParameter("id")));
        user.setImage(filename);
        if(multipartRequest.getParameter("phone").equals("001")){
            System.out.println("没有手机号");
            adminService.updateUserdata(user);
            return "1000";

        }else {
            System.out.println("手机号");
            user.setPhone(multipartRequest.getParameter("phone"));
            List<User> list = adminService.findphone(user.getPhone());
            if (list.isEmpty()) {
               adminService.updateUserData(user);
                return "1000";
            } else {
                return "600";
            }
        }
    }
    @RequestMapping("finduser")
    @ResponseBody
    public Map<String,Object> finduser(int limit,int page,User user){
        String where = "";
        System.out.println(user.getName()+"/"+user.getIdentity()+"/"+user.getPhone());
        if(user.getName()==null || user.getName()=="" ){
            if(user.getIdentity()==null || user.getIdentity()=="" ){
                if(user.getPhone()==null || user.getPhone()==""){

                }else {
                    where += "and phone like" + "'" + "%" + user.getPhone() + "%" + "'";
                }
            }else {
                if (user.getPhone()==null || user.getPhone()=="") {
                    where += "and identity like" + "'" + "%" + user.getIdentity() + "%" + "'";
                } else {
                    where += "and identity like" + "'" + "%" +  user.getIdentity() + "%" + "'"+ "and phone like" + "'" + "%" + user.getPhone() + "%" + "'";

                }
            }
        }else{
            if(user.getIdentity()==null || user.getIdentity()=="" ){
                if(user.getPhone()==null || user.getPhone()==""){
                    where += "and name like" + "'" + "%" + user.getName() + "%" + "'";
                }else {
                    where +="and name like" + "'" + "%" + user.getName() + "%" + "'"+"and phone like" + "'" + "%" + user.getPhone() + "%" + "'";
                }
            }else {
                if (user.getPhone()==null || user.getPhone()=="") {
                    where +="and name like" + "'" + "%" + user.getName() + "%" + "'"+"and identity like" + "'" + "%" + user.getIdentity() + "%" + "'";
                } else {
                    where +="and name like" + "'" + "%" + user.getName() + "%" + "'"+"and identity like" + "'" + "%" +  user.getIdentity() + "%" + "'"+ "and phone like" + "'" + "%" + user.getPhone() + "%" + "'";

                }
            }
        }
        int num=(page-1)*limit;
        List<User> list=userService.findAll(where,num,limit);
       String Count = userService.count(where);
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("code","0");
        map.put("status","0");
        map.put("msg","");
        map.put("count",Count);
        map.put("data",list);
        return map;
    }

    @RequestMapping("/findallshopping")
    @ResponseBody
    public Map<String,Object> findallshopping(int limit,int page,Shopping shopping){
        String where = "";
        System.out.println(shopping.getId()+"/"+shopping.getName()+"/"+shopping.getIntegral());
        if(shopping.getId()==0){
            if(shopping.getName()==null || shopping.getName()=="" ){
                if(shopping.getIntegral()==null ||shopping.getIntegral()==""){

                }else {
                    where += "and integral like" + "'" + "%" + shopping.getIntegral() + "%" + "'";
                }
            }else {
                if (shopping.getIntegral()==null ||shopping.getIntegral()=="") {
                    where += "and name like" + "'" + "%" + shopping.getName() + "%" + "'";
                } else {
                    where += "and name like" + "'" + "%" + shopping.getName() + "%" + "'"+ "and integral like" + "'" + "%" + shopping.getIntegral() + "%" + "'";

                }
            }
        }else{
            where += "and id like"+"'"+"%"+shopping.getId()+"%"+"'";
        }
        System.out.println(shopping.getId()+"/"+shopping.getName()+"/"+shopping.getIntegral());
        System.out.println(where);
        int num=(page-1)*limit;
        List<Shopping> list=adminService.findshopping(where,num,limit);
        String Count=adminService.count(where);
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("code","0");
        map.put("msg","");
        map.put("status","0");
        map.put("count",Count);
        map.put("data",list);
        return map;
    }




    @RequestMapping("/addshopping")
    @ResponseBody
    public String addshopping(HttpServletRequest request, MultipartFile image) throws Exception {

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
        Shopping shopping = new Shopping();
        shopping.setName(multipartRequest.getParameter("name"));
        shopping.setIntegral(multipartRequest.getParameter("integral"));
        shopping.setIntroduce(multipartRequest.getParameter("introduce"));
        shopping.setImage(filename);
        System.out.println(shopping);
        shoppingService.addshopping(shopping);
        return "1000";
    }


    @RequestMapping("/removeshopping")
    @ResponseBody
    public String removeshopping(int id){
        adminService.removeshopping(id);
        return "1000";
    }

    @RequestMapping("/updateshoppingimg")
    @ResponseBody
    public String updateshoppingimg(HttpServletRequest request,MultipartFile image) throws Exception {

        System.out.println("有进来");
        System.out.println(image);
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
        Shopping shopping = new Shopping();
        shopping.setId(Integer.parseInt(multipartRequest.getParameter("id")));
        shopping.setName(multipartRequest.getParameter("name"));
        shopping.setIntegral(multipartRequest.getParameter("integral"));
        shopping.setIntroduce(multipartRequest.getParameter("introduce"));
        shopping.setImage(filename);
        adminService.updateshopping(shopping);
        System.out.println(shopping);

        return "1000";
    }

    @RequestMapping("/updateshopping")
    @ResponseBody
    public String updateshopping(Shopping shopping){
        adminService.updateshopping(shopping);
        return "1000";
    }

    @RequestMapping("/UpdateState")
    @ResponseBody
    public String updatestate(String state,int id){
        adminService.updatestate(state, id);
        return "1000";
    }


    @RequestMapping("/findallnotice")
    @ResponseBody
    public Map<String,Object> findallnotice(int page,int limit){
        int num=(page-1)*limit;
        List<Notice> list=adminService.findallnotice(num,limit);
        String Count=adminService.noticecount();
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("code","0");
        map.put("msg","");
        map.put("count",Count);
        map.put("data",list);
        return map;
    }

    @RequestMapping("/addnotice")
    @ResponseBody
    public String addnotice(Task task){
        if(task.getType().equals("公告")){
            adminService.addnotice(task);
            List<User> list=userService.findAlluser();
            if(list.isEmpty()){

            }else{
                for(User user:list){
                    task.setUid(user.getId());
                    adminService.addnewnotice(task);
                }
            }

        }else{
            adminService.addtask(task);
        }
        return "1000";
    }

    @RequestMapping("/removenotice")
    @ResponseBody
    public String removenotice(int id){
        adminService.removenotice(id);
        return "1000";
    }

    @RequestMapping("/updatenotice")
    @ResponseBody
    public String updatenotice(Notice notice){
        adminService.updatenotice(notice);
        return "1000";
    }

    @RequestMapping("/FindAllTask")
    @ResponseBody
    public  Map<String,Object> findtask(Task task,int page,int limit){
        String where = "";
        int num=(page-1)*limit;
        if (task.getType()=="" || task.getType()==null) {
        }else{
            where += "and type like" + "'" + "%" + task.getType() + "%" + "'";
        }
        List<Task> list = adminService.findtask(where,num,limit);
        String Conut=adminService.taskcount(where);
        System.out.println(list);
        Map<String,Object> map = new HashMap<String, Object>();
        map.put("code","0");
        map.put("msg","");
        map.put("count",Conut);
        map.put("data",list);
        return map;
    }

    @RequestMapping("/removetask")
    @ResponseBody
    public String removetask(int id){
        adminService.removetask(id);
        return "1000";
    }
    @RequestMapping("/updatetask")
    @ResponseBody
    public String updatenotice(Task task){
        adminService.updatetask(task);
        return "1000";
    }


    @RequestMapping("/FindAllUser")
    @ResponseBody
    public List<User> findalluser(){
        List<User> list=userService.findAlluser();
        return list;
    }

    @RequestMapping("/FindAllAdminEmpower")
    @ResponseBody
    public List<Admin> FindAllAdminEmpower(){
        List<Admin> list=adminService.AllAdmin();
        return list;
    }

    @RequestMapping("/UpdateEmpower")
    @ResponseBody
    public String updateempower(int  empower,int id){

      adminService.updateempower(empower, id);
        return "1000";
    }


    @RequestMapping("/UpdateAdminEmpower")
    @ResponseBody
    public String UpdateAdminEmpower(int  empower,int id){

        adminService.updateAdminEmpower(empower, id);
        return "1000";
    }

    @RequestMapping("/UpdateAdminadminEmpower")
    @ResponseBody
    public String UpdateAdminadminEmpower(int  adminempower,int id){

        adminService.updateAdminadminEmpower(adminempower, id);
        return "1000";
    }


    @RequestMapping("/addWorkShift")
    @ResponseBody
    public String addWorkShift(WorkShift workShift){
        System.out.println(workShift);
        List<WorkShift> workshift=adminService.findWorkShift(workShift.getYear(),workShift.getMonth(),workShift.getDate(),workShift.getState());
        if(workshift.isEmpty()){
            adminService.addwordshift(workShift);
            return "1000";
        }else{
            return "500";
        }

    }

    @RequestMapping("/findWorkShift")
    @ResponseBody
    public List<WorkShift> findWorkShift(WorkShift workShift){
        List<WorkShift> list= new ArrayList<>();
        List<WorkShift> workshift=adminService.findWorkShift(workShift.getYear(),workShift.getMonth(),workShift.getDate(),workShift.getState());
        System.out.println(workshift);
        if (workshift.isEmpty()){
            return list;
        }else{
            return workshift;
        }

    }

    @RequestMapping("/addClockInIntegral")
    @ResponseBody
    public String addClockInIntegral(ClockInIntagral clockInIntagral){
        System.out.println(clockInIntagral);
        List<ClockInIntagral> list=adminService.findClockInIntegral(clockInIntagral.getYear(),clockInIntagral.getMonth(),clockInIntagral.getDate(),clockInIntagral.getState());
        if(list.isEmpty()){
            adminService.addclockinintegral(clockInIntagral);
            return "1000";
        }else{
            return "500";
        }
    }

    @RequestMapping("/findClockInIntegral")
    @ResponseBody
    public List<ClockInIntagral> findClockInIntegral(ClockInIntagral clockInIntagral){
        List<ClockInIntagral> list= new ArrayList<>();
        List<ClockInIntagral> clockinintagral=adminService.findClockInIntegral(clockInIntagral.getYear(),clockInIntagral.getMonth(),clockInIntagral.getDate(),clockInIntagral.getState());
        System.out.println(clockInIntagral);
        if (clockinintagral.isEmpty()){
            return list;
        }else{
            return clockinintagral;
        }

    }

    @RequestMapping(value = "/uploadDocs",produces="application/json;charset=utf-8")
    @ResponseBody
    public Map<String,Object> uploadDocs(HttpServletRequest request,MultipartFile file){
        Map<String, Object> uploadData = new HashMap<String, Object>();
        String Path = request.getSession().getServletContext().getRealPath("/uploads");
        String fileName = file.getOriginalFilename();
        File dir = new File(Path,fileName);
        if(!dir.exists()){
            dir.mkdirs();
        }
        try {
            file.transferTo(dir);
            System.out.println("上传");
            adminService.refreshfile(fileName,new Date());
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

    @RequestMapping("/findFiles")
    @ResponseBody
    public List<cn.ISMS.domain.File> findfiles(Date time){
        List<cn.ISMS.domain.File> list=adminService.files(time);
        return list;
    }

    @RequestMapping("/refreshNoticeIntegral")
    @ResponseBody
    public String refreshNoticeIntegral(NoticeIntegral noticeIntegral){
        adminService.deleteNewNoticeIntegral();
        adminService.addNoticeIntegral(noticeIntegral);
        adminService.addNewNoticeIntegral(noticeIntegral);
        return "1000";
    }

    @RequestMapping("/renewNoticeIntegral")
    @ResponseBody
    public String refreshNoticeIntegral(){
        adminService.deleteNewNoticeIntegral();
        return "1000";
    }

    @RequestMapping("/findNoticeIntegral")
    @ResponseBody
    public List<NoticeIntegral> findNoticeIntegral(){
        List<NoticeIntegral> list=adminService.findNoticeIntegral();
        return list;
    }

    @RequestMapping("/findAllFiles")
    @ResponseBody
    public Map<String,Object> findAllFiles(int page,int limit,AdminFiles adminFiles){
        int num=(page-1)*limit;
        String where="";
        if(adminFiles.getUid()==0){
            if(adminFiles.getFiles()=="" || adminFiles.getFiles()==null){

            }else{
                where += "and files like" + "'" + "%" + adminFiles.getFiles() + "%" + "'";
            }
        }else{
            if(adminFiles.getFiles()=="" || adminFiles.getFiles()==null){
                where += "and uid like" + "'" + "%" + adminFiles.getUid() + "%" + "'";
            }else{
                where += "and uid like" + "'" + "%" + adminFiles.getUid() + "%" + "'"+"and files like" + "'" + "%" + adminFiles.getFiles() + "%" + "'";
            }

        }
        Map<String,Object> map = new HashMap<>();
        List<AdminFiles> list=adminService.findAllFiles(where,num,limit);
        String count=adminService.filesCount(where);
        map.put("code","0");
        map.put("msg","");
        map.put("count",count);
        map.put("data",list);
        return map;
    }

    @RequestMapping("/deleteFiles")
    public String deletefiles(int id){
        adminService.deletefiles(id);
        return "1000";
    }

    @RequestMapping("/updateFiles")
    @ResponseBody
    public String updateFiles(AdminFiles adminFiles){
        adminService.updatefiles(adminFiles);
        return "1000";
    }


    @RequestMapping("/findAllAdmin")
    @ResponseBody
    public Map<String,Object> findAllAdmin(int page,int limit,Admin admin){
        int num=(page-1)*limit;
        String where="";
        if(admin.getAdminname()=="" || admin.getAdminname()==null){

        }else{
            where += "and adminname like" + "'" + "%" + admin.getAdminname() + "%" + "'";
        }
        Map<String,Object> map = new HashMap<>();
        List<Admin> list=adminService.findAllAdmin(where,num,limit);
        System.out.println(list);
        String count=adminService.AdminCount(where);
        map.put("code","0");
        map.put("msg","");
        map.put("count",count);
        map.put("data",list);
        return map;
    }

    @RequestMapping("/AddAdmin")
    @ResponseBody
    public String addAdmin(Admin admin){
        List<Admin> list=adminService.findAdmin(admin.getAdminname());
        if(list.isEmpty()){
            adminService.addAdmin(admin);
            return "1000";
        }else{
            return "500";
        }
    }

    @RequestMapping("/DeleteAdmin")
    @ResponseBody
    public String deleteAdmin(int id){
        adminService.deleteAdmin(id);
        return "1000";
    }

    @RequestMapping("/UpdateAdmin")
    @ResponseBody
    public String updateAdmin(Admin admin){
        String where="";
        if(admin.getAdminname()=="" || admin.getAdminname()==null){
            adminService.updateNonameAdmin(admin);
            return "1000";
        }else {
            List<Admin> list=adminService.findAdmin(admin.getAdminname());
            if(list.isEmpty()){
                adminService.updateAdmin(admin);
                return "1000";
            }else{
                return "500";
            }
        }

    }

    @RequestMapping("/findSuperAdmin")
    @ResponseBody
    public Map<String,Object> findSuperAdmin(){
        Map<String,Object> map = new HashMap<>();
        List<Admin> list=adminService.findSuperAdmin();
        System.out.println(list);
        map.put("code","0");
        map.put("msg","");
        map.put("count",list.size());
        map.put("data",list);
        return map;
    }

    @RequestMapping("/refreshIntegralRule")
    @ResponseBody
    public String refreshIntegralRule(Notice notice){
        adminService.deleteIntegralRule();
        adminService.refreIntegralRule(notice);
        return "1000";
    }

    @RequestMapping("/findIntegralRule")
    @ResponseBody
    public List<Notice> findIntegralRule(){

        List<Notice> list=adminService.findIntegralRule();
        return list;
    }


    @RequestMapping("/findAllWordShift")
    @ResponseBody
    public Map<String,Object> findAllWordShift(int page,int limit,WorkShift workShift){
        int num=(page-1)*limit;
        String where="";
        if(workShift.getYear()==0){

        }else{
            where += "and year like" + "'" + "%" + workShift.getYear() + "%" + "'"+"and month like" + "'" + "%" + workShift.getMonth() + "%" + "'"+"and date like" + "'" + "%" + workShift.getDate() + "%" + "'";
        }
        Map<String,Object> map = new HashMap<>();
        List<WorkShift> list=adminService.findAllWorkShift(where,num,limit);
        System.out.println(list);
        String count=adminService.WorkShiftCount(where);
        map.put("code","0");
        map.put("msg","");
        map.put("count",count);
        map.put("data",list);
        return map;
    }


    @RequestMapping("/deleteWordShift")
    @ResponseBody
    public String  deleteWordShift(int id){
        adminService.deleteWordShift(id);
        return "1000";
    }

    @RequestMapping("/updateWordShift")
    @ResponseBody
    public String  updateWordShift(WorkShift workShift){
        adminService.updateWordShift(workShift);
        return "1000";
    }


    @RequestMapping("/findAllClockInIntegral")
    @ResponseBody
    public Map<String,Object> findAllClockInIntegral(int page,int limit,ClockInIntagral clockInIntagral){
        int num=(page-1)*limit;
        String where="";
        if(clockInIntagral.getYear()==0){

        }else{
            where += "and year like" + "'" + "%" + clockInIntagral.getYear() + "%" + "'"+"and month like" + "'" + "%" + clockInIntagral.getMonth() + "%" + "'"+"and date like" + "'" + "%" + clockInIntagral.getDate() + "%" + "'";
        }
        Map<String,Object> map = new HashMap<>();
        List<ClockInIntagral> list=adminService.findAllClockInIntegral(where,num,limit);
        System.out.println(list);
        String count=adminService.ClockInIntegralCount(where);
        map.put("code","0");
        map.put("msg","");
        map.put("count",count);
        map.put("data",list);
        return map;
    }

    @RequestMapping("/deleteClockInIntegral")
    @ResponseBody
    public String  deleteClockInIntegral(int id){
        adminService.deleteClockInIntegral(id);
        return "1000";
    }

    @RequestMapping("/updateClockInIntegral")
    @ResponseBody
    public String  updateClockInIntegral(ClockInIntagral clockInIntagral){
        adminService.updateClockInIntegral(clockInIntagral);
        return "1000";
    }



    @RequestMapping("/findAllClockIn")
    @ResponseBody
    public Map<String,Object> findAllClockIn(int page,int limit,ClockIn clockIn){
        int num=(page-1)*limit;
        String where="";
        System.out.println(clockIn.getUname());
        if(clockIn.getUname()==null || clockIn.getUname()==""){

        }else{
            where += " and convert(time,DATETIME) like" + "'" + clockIn.getUname() + "%"+"'";
        }
        System.out.println(where);
        Map<String,Object> map = new HashMap<>();
        List<ClockIn> list=adminService.findAllClockIn(where,num,limit);
        System.out.println(list);
        String count=adminService.ClockInCount(where);
        map.put("code","0");
        map.put("msg","");
        map.put("count",count);
        map.put("data",list);
        return map;
    }

    @RequestMapping("/deleteClockIn")
    @ResponseBody
    public String  deleteClockIn(int id){
        adminService.deleteClockIn(id);
        return "1000";
    }

    @RequestMapping("/findAllClockInToday")
    @ResponseBody
    public Map<String,Object> findAllClockInToday(int page,int limit,ClockIn clockIn){
        int num=(page-1)*limit;
        String where="";
        System.out.println(clockIn.getUname());
        if(clockIn.getClockin()==null || clockIn.getClockin()==""){

        }else{
            where += " and clockin like" + "'" + "%"+ clockIn.getClockin() + "%"+"'";
        }
        System.out.println(where);
        Map<String,Object> map = new HashMap<>();
        List<ClockIn> list=adminService.findAllClockInToday(where,num,limit);
        System.out.println(list);
        String count=adminService.ClockInTodaysCount(where);
        map.put("code","0");
        map.put("msg","");
        map.put("count",count);
        map.put("data",list);
        return map;
    }

    @RequestMapping("/deleteClockInToday")
    @ResponseBody
    public String  deleteClockInToday(int id){
        adminService.deleteClockInToday(id);
        return "1000";
    }



    @RequestMapping("/findAllExchange")
    @ResponseBody
    public Map<String,Object> findAllExchange(int page,int limit,Exchange exchange){
        int num=(page-1)*limit;
        String where="";
        System.out.println(exchange);
        if(exchange.getUid()==0){
                if(exchange.getState()=="" || exchange.getState()==null){

                }else{
                    where += " and state like" + "'" + "%"+ exchange.getState() + "%"+"'";
                }
        }else{
            if(exchange.getState()=="" || exchange.getState()==null){
                where += " and uid like" + "'" + "%"+ exchange.getUid() + "%"+"'";
            }else{
                where += " and state like" + "'" + "%"+ exchange.getState() + "%"+"'"+" and uid like" + "'" + "%"+ exchange.getUid() + "%"+"'";
            }
        }
        System.out.println(where);
        Map<String,Object> map = new HashMap<>();
        List<Exchange> list=adminService.findAllexchange(where,num,limit);
        System.out.println(list);
        String count=adminService.AllexchangeCount(where);
        map.put("code","0");
        map.put("msg","");
        map.put("count",count);
        map.put("data",list);
        return map;
    }

    @RequestMapping("/Updateexchange")
    @ResponseBody
    public String Updateexchange(String state,int id){
        adminService.updateexchange(state, id);
        return "1000";
    }

    @RequestMapping("/findAllUserIntegral")
    @ResponseBody
    public Map<String,Object> findAlluserIntegral(int page,int limit,UserIntegral userIntegral){
        int num=(page-1)*limit;
        String where="";
        if (userIntegral.getUphone()=="" || userIntegral.getUphone()==null){

        }else{
            where += " and uphone like" + "'" + "%"+ userIntegral.getUphone() + "%"+"'";
        }
        List<UserIntegral> list=adminService.findAllUserIntegral(where,num,limit);
        String count = adminService.AllUserIntegralCount(where);
        Map<String,Object> map = new HashMap<>();
        map.put("code","0");
        map.put("msg","");
        map.put("count",count);
        map.put("data",list);
        return map;
    }

    @RequestMapping("/deleteUserIntegral")
    @ResponseBody
    public String  deleteUserIntegral(int id){
       adminService.deleteUserIntegral(id);
        return "1000";
    }

    @RequestMapping("/updateUserIntegral")
    @ResponseBody
    public String  updateUserIntegral(UserIntegral userIntegral){
        adminService.updateUserIntegral(userIntegral);
        return "1000";
    }


    @RequestMapping("/findNewNoticeIntegral")
    @ResponseBody
    public List<IntegralAward> findNewNoticeIntegral(){
        List<IntegralAward> list = adminService.findnewNoticeIntegral();
        return list;
    }

    @RequestMapping("/FindNoticeIntegral")
    @ResponseBody
    public List<IntegralAward> FindNoticeIntegral(){
        List<IntegralAward> list = adminService.FindNoticeIntegral();
        return list;
    }


    //Address
    @RequestMapping("/findAllAddress")
    @ResponseBody
    public Map<String,Object> findAllAddress(){
        List<Address> list = adminService.findAllAddress();
        Map<String,Object> map = new HashMap<>();
        map.put("data",list);
        return map;
    }
}
