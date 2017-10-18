package eeit.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebFilter("/*")
public class GlobalService implements Filter {
    public GlobalService() {
        super();
    }

	@Override
	public void destroy() { }

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse reponse = (HttpServletResponse) resp;
		
		String action = request.getParameter("action");
		System.out.println("[Project Info] " + request.getServletContext() + "? action= " + action);
		
		chain.doFilter(request, reponse);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
	}

	

}
