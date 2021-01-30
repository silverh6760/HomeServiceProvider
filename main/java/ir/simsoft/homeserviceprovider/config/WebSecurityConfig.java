package ir.simsoft.homeserviceprovider.config;
import ir.simsoft.homeserviceprovider.serviceclasses.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

import java.util.ArrayList;
import java.util.List;


@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private MySimpleUrlAuthenticationSuccessHandler successHandler;

    @Override
    protected void configure(HttpSecurity http) throws Exception {

//        List<RequestMatcher> requestMatchers=new ArrayList<>();
//        requestMatchers.add(new AntPathRequestMatcher("/user/register"));
//        requestMatchers.add(new AntPathRequestMatcher("/home"));
//        requestMatchers.add(new AntPathRequestMatcher("/home/loginPage"));

        http.csrf().disable()
                .authorizeRequests()
                .antMatchers("/user/**","/","/home","/user/home/**","/user/register","/user/welcome/**").permitAll()
                .antMatchers("/expertPage/**").hasAnyAuthority("EXPERT")
                .antMatchers("/admin/**").hasAnyAuthority("ADMIN")
                //.antMatchers(HttpMethod.POST,"/user/register","/user/register/**").permitAll()
                .antMatchers(HttpMethod.POST,"/user/checkPassword","/user/checkPassword/**").permitAll()
                .antMatchers(HttpMethod.POST,"/user/checkEmail","/user/checkEmail/**").permitAll()
//                .antMatchers(HttpMethod.POST,"/user/checkFileSize","/user/checkFileSize/**").permitAll()
                .anyRequest().authenticated()

                .and()
                .formLogin()
                .loginPage("/home/loginPage")
                .loginProcessingUrl("/doLogin")
                .usernameParameter("email")
                .passwordParameter("password")
                .successHandler(successHandler)
//                .defaultSuccessUrl("/home").permitAll()
//                .successForwardUrl()
                .failureUrl("/home/loginError")
                .permitAll()
                .and()
                .logout()
                .permitAll()
                .and().httpBasic();


//        http.csrf().disable()
//                .authorizeRequests()
//                .antMatchers("/user","/").permitAll()
//                .and().httpBasic();
    }
    @Bean
    public PasswordEncoder passwordEncoder(){

        return new BCryptPasswordEncoder();
    }
    @Autowired
    private UserService userService;
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userService).passwordEncoder(passwordEncoder());
    }

//    @Bean
//    public AuthenticationSuccessHandler myAuthenticationSuccessHandler(){
//        return new MySimpleUrlAuthenticationSuccessHandler();
//    }
}
