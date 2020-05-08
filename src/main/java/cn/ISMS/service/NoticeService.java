package cn.ISMS.service;

import cn.ISMS.domain.Notice;
import cn.ISMS.domain.Task;

import java.util.List;

public interface NoticeService {

   public List<Notice> findnotice();

   public void addnotice(Notice notice);

   public List<Notice> findnewnotice(int id);

   public List<Task> findtask();

   public void removeMyNewNotice(int id);
}
