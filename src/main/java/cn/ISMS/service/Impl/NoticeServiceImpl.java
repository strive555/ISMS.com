package cn.ISMS.service.Impl;

import cn.ISMS.dao.NoticeDao;
import cn.ISMS.domain.Notice;
import cn.ISMS.domain.Task;
import cn.ISMS.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;
@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeDao noticeDao;


    @Override
    public List<Notice> findnotice() {
        return   noticeDao.findnotice();
    }

    @Override
    public void addnotice(Notice notice) {
        noticeDao.addnotice(notice);
    }

    @Override
    public List<Notice> findnewnotice(int id) {
        return noticeDao.findnewnotice(id);
    }

    @Override
    public List<Task> findtask() {
        return noticeDao.findtask();
    }

    @Override
    public void removeMyNewNotice(int id) {
        noticeDao.removeMyNewNotice(id);
    }

}
