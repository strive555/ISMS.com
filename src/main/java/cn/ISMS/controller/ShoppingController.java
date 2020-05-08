package cn.ISMS.controller;

import cn.ISMS.domain.Shopping;
import cn.ISMS.domain.User;
import cn.ISMS.service.ShoppingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class ShoppingController {

    @Autowired
    private ShoppingService shoppingService;

    @RequestMapping("/findshopping")
    @ResponseBody
    public List<Shopping> findshopping(Model model){
        List<Shopping> list = shoppingService.findallshopping();
        model.addAttribute("alldata",list);
        return list;
    }

    @RequestMapping("/shopping")
    public ModelAndView findshopping(){
        ModelAndView mv = new ModelAndView();//new一个ModelAndView对像
        List<Shopping> list = shoppingService.findallshopping();
        mv.addObject("list",list);
        mv.setViewName("shopping");
        return mv;
    }


}
