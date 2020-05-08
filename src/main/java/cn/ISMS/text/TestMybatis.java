package cn.ISMS.text;

import cn.ISMS.dao.UserDao;
import cn.ISMS.domain.User;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class TestMybatis {

//    @Test
//    public void run1() throws Exception {
//        //加载配置文件
//        InputStream in=Resources.getResourceAsStream("SqlMapConfig.xml");
//        //创建SqlSesiionFactory对象
//        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(in);
//        //创建Session对象
//        SqlSession session = factory.openSession();
//        //获取到代理对象
//        UserDao dao=session.getMapper(UserDao.class);
//        //查询所有信息
//        List<User> list=dao.findAll();
//        for(User userdata:list){
//            System.out.println(userdata);
//        }
//        //关闭资源
//        session.close();
//        in.close();
//    }
//    @Test
//    public void run2() throws Exception {
//        //加载配置文件
//        InputStream in=Resources.getResourceAsStream("SqlMapConfig.xml");
//        //创建SqlSesiionFactory对象
//        SqlSessionFactory factory = new SqlSessionFactoryBuilder().build(in);
//        //创建Session对象
//        SqlSession session = factory.openSession();
//        //获取到代理对象
//        UserDao dao=session.getMapper(UserDao.class);
//        //保存信息
//        User user = new User();
//        user.setName("零");
//        user.setPhone("0");
//         dao.saveUser(user);
//
//         //提交
//        session.commit();
//        //关闭资源
//        session.close();
//        in.close();
//    }
}
