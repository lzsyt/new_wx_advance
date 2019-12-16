package com.kzq.advance;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

import javax.servlet.MultipartConfigElement;

@SpringBootApplication
@Configuration
//@ComponentScan
//@EnableAutoConfiguration
@EnableScheduling
public class AdvanceApplication extends SpringBootServletInitializer {
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(AdvanceApplication.class);
    }

    public static void main(String[] args) throws Exception {
        SpringApplication.run(AdvanceApplication.class, args);
    }


    @Bean
    public MultipartConfigElement multipartConfigElement() {
        MultipartConfigFactory factory = new MultipartConfigFactory();
        //  单个数据大小
        factory.setMaxFileSize("1024MB"); // KB,MB
        /// 总上传数据大小
        factory.setMaxRequestSize("1024MB");
        return factory.createMultipartConfig();
    }


/*
    public static void main(String[] args) {
        SpringApplication.run(AdvanceApplication.class, args);
    }
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(AdvanceApplication.class);
    }*/

}