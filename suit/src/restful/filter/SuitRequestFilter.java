package restful.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SuitRequestFilter implements Filter{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest request=(HttpServletRequest) arg0;//获取request对象
		HttpServletResponse response=(HttpServletResponse) arg1;//获取response对象
		HttpSession session=request.getSession();//获取session对象
		String path=request.getRequestURI();
        System.out.println(path);
        String uid=(String)session.getAttribute("account");
        System.out.println(uid);
        if(path.indexOf("/login.jsp")>-1){//登录页面不过滤
        	chain.doFilter(arg0, arg1);//递交给下一个过滤器
            return;
        }
        if(path.indexOf("/register.jsp")>-1){//注册页面不过滤
        	chain.doFilter(request, response);
            return;
        }
        
        if(uid!=null){//已经登录
        	chain.doFilter(request, response);//放行，递交给下一个过滤器
            
        }else{
            response.sendRedirect("login.jsp");
        }	
		//chain.doFilter(request, response);//放行，通过了当前过滤器，递交给下一个filter进行过滤
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
