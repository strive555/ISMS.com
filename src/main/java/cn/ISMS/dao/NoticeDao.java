package cn.ISMS.dao;

import cn.ISMS.domain.Notice;
import cn.ISMS.domain.Task;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Repository
public interface NoticeDao {

    @Select("select * from notice order by id desc")
    public List<Notice> findnotice();

    @Insert("insert into newnotice(theme,content,time) values(#{theme},#{content},#{time})")
    public void addnotice(Notice notice);

    @Select("select * from newnotice where user=#{id} order by id desc")
    public List<Notice> findnewnotice(int id);

    @Select("select * from task order by id desc")
    public List<Task> findtask();

    @Delete("delete from newnotice where user=#{id}")
    public void removeMyNewNotice(int id);

}
