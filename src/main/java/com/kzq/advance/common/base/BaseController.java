package com.kzq.advance.common.base;


import com.kzq.advance.common.result.Result;
import com.kzq.advance.common.utils.Charsets;
import com.kzq.advance.common.utils.StringEscapeEditor;
import com.kzq.advance.common.utils.URLUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @description：基础 controller
 * @author：zhixuan.wang
 * @date：2015/10/1 14:51
 */
public abstract class BaseController {
    // 控制器本来就是单例，这样似乎更加合理
    protected Logger logger = LogManager.getLogger(getClass());

    @InitBinder
    public void initBinder(ServletRequestDataBinder binder) {
        /**
         * 自动转换日期类型的字段格式
         */
        binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"), true));
        /**
         * 防止XSS攻击
         */
        binder.registerCustomEditor(String.class, new StringEscapeEditor());
    }


    /**
     * ajax失败
     * @param msg 失败的消息
     * @return {Object}
     */
    public Object renderError(String msg) {
        Result result = new Result();
        result.setMsg(msg);
        return result;
    }
    
    /**
     * ajax成功
     * @return {Object}
     */
    public Object renderSuccess() {
        Result result = new Result();
        result.setSuccess(true);
        return result;
    }
    
    /**
     * ajax成功
     * @param msg 消息
     * @return {Object}
     */
    public Object renderSuccess(String msg) {
        Result result = new Result();
        result.setSuccess(true);
        result.setMsg(msg);
        return result;
    }

    /**
     * ajax成功
     * @param obj 成功时的对象
     * @return {Object}
     */
    public Object renderSuccess(Object obj) {
        Result result = new Result();
        result.setSuccess(true);
        result.setObj(obj);
        return result;
    }
    



	/**
	 * redirect跳转
	 * @param url 目标url
	 */
	protected String redirect(String url) {
		return new StringBuilder("redirect:").append(url).toString();
	}
	
	/**
	 * 下载文件
	 * @param file 文件
	 */
	protected ResponseEntity<Resource> download(File file) {
		String fileName = file.getName();
		return download(file, fileName);
	}
	
	/**
	 * 下载
	 * @param file 文件
	 * @param fileName 生成的文件名
	 * @return {ResponseEntity}
	 */
	protected ResponseEntity<Resource> download(File file, String fileName) {
		Resource resource = new FileSystemResource(file);
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
		String header = request.getHeader("User-Agent");
		// 避免空指针
		header = header == null ? "" : header.toUpperCase();
		HttpStatus status;
		if (header.contains("MSIE") || header.contains("TRIDENT") || header.contains("EDGE")) {
			fileName = URLUtils.encodeURL(fileName, Charsets.UTF_8);
			status = HttpStatus.OK;
		} else {
			fileName = new String(fileName.getBytes(Charsets.UTF_8), Charsets.ISO_8859_1);
			status = HttpStatus.CREATED;
		}
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		headers.setContentDispositionFormData("attachment", fileName);
		return new ResponseEntity<Resource>(resource, headers, status);
	}
}
