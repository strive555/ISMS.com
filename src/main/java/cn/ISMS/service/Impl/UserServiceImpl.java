package cn.ISMS.service.Impl;

import cn.ISMS.dao.UserDao;
import cn.ISMS.domain.*;
import cn.ISMS.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.List;

@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    //user表
    @Override
    public List<User> findAll(String where,int num,int limit) {
        System.out.println("业务层，查询所有账户信息");
        return userDao.findAll(where,num, limit);
    }

    @Override
    public String count(String where) {
        return userDao.count(where);
    }

    @Override
    public List<User> findAlluser() {
        return userDao.findAlluser();
    }

    @Override
    public void saveUser(User user) {
        System.out.println("业务层，保存账户信息");userDao.saveUser(user); }

    @Override
    public List<User> Login(String phone,String pwd) { return userDao.Login(phone,pwd); }

    @Override
    public void updatepwd(String pwd, String name) {
        userDao.updatepwd(pwd,name);
    }

    @Override
    public void updateUserdata(User user) {
        userDao.updateUserdata(user);
    }

    @Override
    public void updatemydata(User user) {
        userDao.updatemydata(user);
    }

    @Override
    public List<User> mydata(int id) {
        return userDao.mydata(id);
    }







    //user_intagral表
    @Override
    public List<UserIntegral> findIntegral() {
        return userDao.findIntegral();
    }

    @Override
    public List<UserIntegral> findMyIntegral(int id) {
        return userDao.findMyIntegral(id);
    }

    @Override
    public void table() { userDao.table(); }

    @Override
    public List<UserIntegral> findMyData(String phone) {
        return userDao.findMyData(phone);
    }

    @Override
    public void exchangeintegral(int cintegral, int uid) {
        userDao.exchangeintegral(cintegral, uid);
    }

    @Override
    public void integralmath(int integral, int id) {
        userDao.integralmath(integral, id);
    }


    //clock_in表
    @Override
    public void addclockin(ClockIn clockin) { userDao.addclockin(clockin); }

    @Override
    public void deleteclockin() {
        userDao.deleteclockin();
    }

    @Override
    public List<ClockIn> findclockin(int id) { return userDao.findclockin(id); }




//all_clock_in表
    @Override
    public void tableclockin(ClockIn clockin) {
        userDao.tableclockin(clockin);
    }

    @Override
    public void usertask(Task task) {
        userDao.usertask(task);
    }

    @Override
    public void taskfinishtime(Task task) {
        userDao.taskfinishtime(task);
    }

    @Override
    public void updatetaskstate(Task task) {
        userDao.updatetaskstate(task);
    }

    @Override
    public void updatetaskfinish(Task task) {
        userDao.updatetaskfinish(task);
    }

    @Override
    public void addexchange(Exchange exchange) {
        userDao.addexchange(exchange);
    }

    @Override
    public List<Exchange> findmyexchange(int id, int num, int limit) {
        return userDao.findmyexchange(id, num, limit);
    }

    @Override
    public String Count() {
        return userDao.Count();
    }

    @Override
    public void FileUploads(AdminFiles adminFiles) {
        userDao.FileUploads(adminFiles);
    }

    @Override
    public List<AdminFiles> findMyFiles(int uid,int num,int limit) {
        return userDao.findMyFiles(uid,num,limit);
    }

    @Override
    public String FileCount() {
        return userDao.FileCount();
    }

    @Override
    public void addMyEvent(IntegralAward integralAward) {
        userDao.addMyEvent(integralAward);
    }

    @Override
    public List<IntegralAward> findMyIntegralEvent(int uid) {
        return userDao.findMyIntegralEvent(uid);
    }
}
