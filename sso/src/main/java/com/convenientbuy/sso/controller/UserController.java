package com.convenientbuy.sso.controller;

import com.convenientbuy.common.pojo.Result;
import com.convenientbuy.common.utils.ExceptionUtil;
import com.convenientbuy.pojo.CbUser;
import com.convenientbuy.sso.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.json.MappingJacksonValue;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by bonismo@hotmail.com
 * 下午9:47 on 16/12/19.
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService service;

    @RequestMapping("/check/{param}/{type}")
    @ResponseBody
    public Object checkData(@PathVariable String param, @PathVariable Integer type, String callback) {
        Result result = null;
        // 参数有效性校验
        if (StringUtils.isBlank(param)) {
            result = Result.build(400, "校验内容不能为空");
        }
        if (type == null) {
            result = Result.build(400, "校验内容类型不能为空");
        }
        if (type != 1 && type != 2 && type != 3) {
            result = Result.build(400, "校验内容类型错误");
        }
        if (null != result) {
            if (null != callback) {
                // jsonp 跨域请求
                MappingJacksonValue mappingJacksonValue = new MappingJacksonValue(result);
                mappingJacksonValue.setJsonpFunction(callback);
                return mappingJacksonValue;
            } else {
                return result;
            }
        }
        try {
            result = service.checkData(param, type);
        } catch (Exception e) {
            e.printStackTrace();
            result = Result.build(500, ExceptionUtil.getStackTrace(e));
        }
        if (null != callback) {
            MappingJacksonValue mappingJacksonValue = new MappingJacksonValue(result);
            mappingJacksonValue.setJsonpFunction(callback);
            return mappingJacksonValue;
        } else {
            return result;
        }
    }

    /**
     * 用户注册
     *
     * @param user
     * @return
     */
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    @ResponseBody
    public Result createUser(CbUser user) {
        try {
            Result result = service.createUser(user);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return Result.build(500, ExceptionUtil.getStackTrace(e));
        }
    }

    /**
     * 登录
     *
     * @param username
     * @param password
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Result userLogin(String username, String password, HttpServletRequest request, HttpServletResponse response) {
        try {
            Result result = service.userLogin(username, password, request, response);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            return Result.build(500, ExceptionUtil.getStackTrace(e));
        }
    }

    /**
     * jsonp 跨域调用
     *
     * @param token
     * @param callback
     * @return
     */
    @RequestMapping("/token/{token}")
    @ResponseBody
    public Object getUserByToken(@PathVariable String token, String callback) {
        Result result = null;
        try {
            result = service.getUserByToken(token);
        } catch (Exception e) {
            e.printStackTrace();
            result = Result.build(500, ExceptionUtil.getStackTrace(e));
        }

        if (StringUtils.isBlank(callback)) {
            return result;
        } else {
            // jsonp 跨域
            MappingJacksonValue mappingJacksonValue = new MappingJacksonValue(result);
            mappingJacksonValue.setJsonpFunction(callback);
            return mappingJacksonValue;
        }
    }
}
