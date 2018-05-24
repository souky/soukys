package com.jy.common.entity;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by wb on 2017/12/10 15:53
 */
public class RequestMsg {

    private String method;

    private Map<String, Object> params;

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public Map<String, Object> getParams() {
        return params;
    }

    public void setParams(Map<String, Object> params) {
        this.params = params;
    }

    public RequestMsg(){
        params = new HashMap<>();
    }
}
