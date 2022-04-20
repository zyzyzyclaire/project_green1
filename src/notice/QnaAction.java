package notice;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionForward;
import user.UserVO;
import util.Function;

public class QnaAction implements Action{
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		ActionForward forward = new ActionForward();
		HttpSession session = request.getSession();
		UserVO uvo = (UserVO)session.getAttribute("session_user");
		
		if(uvo==null) {
			forward = Function.alert(request, forward, "/login.jsp", "�α����� �̿����ּ���");
		} else {
			forward.setRedirect(true);
			forward.setPath(request.getContextPath()+"/qna.jsp");
		}
	
		return forward;
	}
}
