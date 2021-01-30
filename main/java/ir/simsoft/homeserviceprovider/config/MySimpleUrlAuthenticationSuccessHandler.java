package ir.simsoft.homeserviceprovider.config;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
@Component
public class MySimpleUrlAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest arg0, HttpServletResponse arg1,
                                        Authentication authentication) throws IOException, ServletException {

        boolean hasExpertRole = false;
        boolean hasAdminRole = false;
        boolean hasCustomerRole=false;
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        for (GrantedAuthority grantedAuthority : authorities) {
            if (grantedAuthority.getAuthority().equals("EXPERT")) {
                hasExpertRole = true;
                break;
            } else if (grantedAuthority.getAuthority().equals("ADMIN")) {
                hasAdminRole = true;
                break;
            }
        }

        if (hasExpertRole) {
            redirectStrategy.sendRedirect(arg0, arg1, "/expertPage");
        } else if (hasAdminRole) {
            redirectStrategy.sendRedirect(arg0, arg1, "/admin");
        }else if(hasCustomerRole){
            redirectStrategy.sendRedirect(arg0, arg1, "/customer");
        } else {
            throw new IllegalStateException();
        }
    }

}
