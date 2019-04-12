package restful.interceptor;

import java.lang.reflect.Method;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Context;

import org.jboss.resteasy.core.Headers;
import org.jboss.resteasy.core.ResourceMethodInvoker;
import org.jboss.resteasy.core.ServerResponse;
import org.jboss.resteasy.spi.HttpRequest;
import org.jboss.resteasy.spi.interception.PreProcessInterceptor;

import restful.annotation.Power;
import restful.bean.Result;

@SuppressWarnings("deprecation")
public class Interceptor4PreProcess implements PreProcessInterceptor {

	@Context
	HttpServletRequest request;

	@Override
	public ServerResponse preProcess(HttpRequest httpRequest, ResourceMethodInvoker resourceMethodInvoker) {
		Method method = resourceMethodInvoker.getMethod();
		if (method.isAnnotationPresent(Power.class)) {			
			//System.out.println(method.getAnnotation(Power.class).value());
			int permission = (int) request.getSession().getAttribute("permission");
			
			if (permission < method.getAnnotation(Power.class).value()) {
				return new ServerResponse(new Result(101, "你不能执行此操作", "", ""), 203, new Headers<Object>());
			}
		}
		return null;
	}
}
