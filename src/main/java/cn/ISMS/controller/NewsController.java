package cn.ISMS.controller;


import cn.ISMS.domain.Notice;
import cn.ISMS.domain.Task;
import cn.ISMS.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class NewsController {

    @Autowired
    private NoticeService noticeService;

    @RequestMapping("/FindNotice")
    public String  notice(Model model,HttpServletRequest request, HttpServletResponse response){
        HttpSession session = request.getSession();
       List<Notice> notice=noticeService.findnotice();
        session.setAttribute("notice",notice);

       return "home";
    }

    @RequestMapping("/ShowNotice")
    @ResponseBody
    public List<Notice>  notice(){
        List<Notice> notice=noticeService.findnotice();
        return notice;
    }

    @RequestMapping("/AddNotice")
    public void newnotice(Notice notice){
        System.out.println("Add执行了");
        noticeService.addnotice(notice);
        return;
    }

    @RequestMapping("/FindNewNotice")
    public String  findNewNotice(HttpServletRequest request, HttpServletResponse response){
        HttpSession session = request.getSession();
        List<Notice> list=noticeService.findnotice();
        session.setAttribute("findallnotice",list);
        return "home";
    }

    @RequestMapping("/refresh")
    @ResponseBody
    public Map<String,Object> refresh(HttpServletRequest request){
        HttpSession session = request.getSession();
        int id=(int)session.getAttribute("userid");
        List<Notice> newnotice=noticeService.findnewnotice(id);
        Map<String,Object> map = new HashMap<>();
        if(newnotice.isEmpty()){
            map.put("data","");
            return map;
        }else{
           map.put("data",newnotice);
            return map;
        }
    }

    @RequestMapping("/findtask")
    @ResponseBody
    public List<Task> findtask(){
        List<Task> list=noticeService.findtask();
        return list;
    }

    @RequestMapping("/removeMyNewNotice")
    @ResponseBody
    public String removeMyNewNotice(int id){
        noticeService.removeMyNewNotice(id);
        return "1000";
    }

    @RequestMapping("/RefreshTask")
    @ResponseBody
    public String task(){
        String data="500";
        List<Task> list=noticeService.findtask();
        for(Task task:list){
            if(task.getUid()==0){
                data="1000";
            }
        }
        return data;
    }
}
