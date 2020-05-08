package cn.ISMS.service.Impl;

import cn.ISMS.dao.ShoppingDao;
import cn.ISMS.domain.Shopping;
import cn.ISMS.service.ShoppingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("shoppingService")
public class ShoppingServiceImpl implements ShoppingService {

    @Autowired
    private ShoppingDao shoppingDao;


    @Override
    public List<Shopping> findallshopping() {
        return shoppingDao.findallshopping();
    }

    @Override
    public void addshopping(Shopping shopping) {
        shoppingDao.addshopping(shopping);
    }
}
