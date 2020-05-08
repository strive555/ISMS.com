package cn.ISMS.service;

import cn.ISMS.domain.Shopping;

import java.util.List;

public interface ShoppingService {

    public List<Shopping> findallshopping();

    public void addshopping(Shopping shopping);

}
