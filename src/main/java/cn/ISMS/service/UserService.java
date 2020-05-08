package cn.ISMS.service;

import cn.ISMS.domain.*;

import java.util.List;

public interface UserService {

    //user表
    public List<User> findAll(String where,int num,int limit);

    public String count(String where);

    public List<User> findAlluser();

    public void saveUser(User user);

    public List<User> Login(String phone,String pwd);

    public List<User> mydata(int id);

    public void updatemydata(User user);

    public void updatepwd(String pwd,String name);

    public void updateUserdata(User user);



    //user_integral表
    public List<UserIntegral> findIntegral();

    public List<UserIntegral> findMyIntegral(int id);

    public void table();

    public List<UserIntegral> findMyData(String phone);

    public void exchangeintegral(int cintegral,int uid);

    public void integralmath(int integral,int id);




    //clock_in表
    public void addclockin(ClockIn clockin);

    public void deleteclockin();

    public List<ClockIn> findclockin(int id);




    //all_clock_in表
    public void tableclockin(ClockIn clockin);


    //task
    public void usertask(Task task);

    public void taskfinishtime(Task task);

    public void updatetaskstate(Task task);

    public void updatetaskfinish(Task task);



    //exchange
    public void addexchange(Exchange exchange);

    public List<Exchange> findmyexchange(int id,int num,int limit);

    public String Count();


    //admin_file
    public void FileUploads(AdminFiles adminFiles);

    public List<AdminFiles> findMyFiles(int uid,int num,int limit);

    public String FileCount();


    //integral_award
    public void addMyEvent(IntegralAward integralAward);

    public List<IntegralAward> findMyIntegralEvent(int uid);
}
