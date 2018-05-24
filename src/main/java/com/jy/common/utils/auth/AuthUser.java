package com.jy.common.utils.auth;

/**
 * Created by fld on 16/5/18.
 */
public class AuthUser {
    private String id;
    private String name;

    //超时时间, 毫秒 milliseconds
    private long expire;

    private String authData;

    public static final AuthUser Empty = new AuthUser();

    public AuthUser() {
        expire = -1L;
    }

    public boolean isAuth() {
        if (id != null) {
            return true;
        } else {
            return false;
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getExpire() {
        return expire;
    }

    public void setExpire(long expire) {
        this.expire = expire;
    }

    public String getAuthData() {
        return authData;
    }

    public void setAuthData(String authData) {
        this.authData = authData;
    }
}
