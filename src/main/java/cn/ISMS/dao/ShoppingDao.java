package cn.ISMS.dao;

import cn.ISMS.domain.Shopping;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ShoppingDao {

    @Select("select * from shopping where state = 'on' ")
    public List<Shopping> findallshopping();

    @Insert("insert into shopping(name,integral,introduce,image) values(#{name},#{integral},#{introduce},#{image})")
    public void addshopping(Shopping shopping);


}
