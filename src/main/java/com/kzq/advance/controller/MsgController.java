package com.kzq.advance.controller;

import com.kzq.advance.domain.vo.InMsgEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.security.MessageDigest;
import java.util.Arrays;

@Controller
public class MsgController {
    private static final char[] HEX_DIGITS = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};

    /**
     * 微信消息处理
     */
    @RequestMapping(value = "/weChat")
    @ResponseBody
    public Object handleMessage(@RequestBody InMsgEntity msg,String signature,String timestamp,String nonce,String echostr) {
        //1. 将token、timestamp、nonce三个参数进行字典序排序
        System.out.println("msg:"+msg);
        String[] arr = {timestamp,nonce,"zmn"};
        Arrays.sort(arr);
        //2. 将三个参数字符串拼接成一个字符串进行sha1加密
        StringBuilder sb = new StringBuilder();
        for (String temp : arr) {
            sb.append(temp);
        }
        System.out.println("sb:"+sb);
        System.out.println("signature:"+signature);
        System.out.println("encode(sb.toString()):"+encode(sb.toString()));

        //3. 开发者获得加密后的字符串可与signature对比，标识该请求来源于微信
        if(encode(sb.toString()).equals(signature)){
            System.out.println("echostr:"+echostr);

            //接入成功
            return echostr;
        }
        //接入失败
        return null;
    }



        // 把密文转换成十六进制的字符串形式
        private static String getFormattedText(byte[] bytes) {
            int len = bytes.length;
            StringBuilder buf = new StringBuilder(len * 2);
            // 把密文转换成十六进制的字符串形式
            for (int j = 0; j < len; j++) {
                buf.append(HEX_DIGITS[(bytes[j] >> 4) & 0x0f]);
                buf.append(HEX_DIGITS[bytes[j] & 0x0f]);
            }
            return buf.toString();
        }

        public static String encode(String str) {
            if (str == null) {
                return null;
            }
            try {
                MessageDigest messageDigest = MessageDigest.getInstance("SHA1");
                messageDigest.update(str.getBytes());
                return getFormattedText(messageDigest.digest());
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }
