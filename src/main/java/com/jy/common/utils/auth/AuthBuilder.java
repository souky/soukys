package com.jy.common.utils.auth;

import io.jsonwebtoken.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

import sun.misc.BASE64Encoder;

/**
 * 生成jwt
 * @author NancyJin
 *
 */
@SuppressWarnings("restriction")
public class AuthBuilder {

    private String key;
    private static final String TOKENID = "jwtauth";
    private static final String JSESSTOKEN = "JSESSTOKEN";
    private static final String JSESSID = "JSESSID";



    public AuthBuilder(String key) {
        this.key = key;
    }

    public String buildToken(String id, String name) {
        AuthUser user = new AuthUser();
        user.setId(id);
        user.setName(name);
        return buildToken(user);
    }

    public String buildToken(AuthUser user) {
        if (user == null) {
            return null;
        }
        return buildToken(key, user.getId(), user.getName(), user.getExpire());
    }

    public static String buildToken(String secretKey, String id, String name, long expireMillis) {
        JwtBuilder builder = Jwts.builder();
        builder.setIssuer(TOKENID);
        if (id != null) {
            builder.setId(id);
        }
        if (name != null && name.length() > 0) {
            builder.setSubject(name);
        }
        if(expireMillis > 0) {
            long now = System.currentTimeMillis();
            builder.setExpiration(new Date(now+expireMillis));
        }
        String token = builder.signWith(SignatureAlgorithm.HS512, secretKey).compact();

        return token;
    }



    /**
     * 判断是否登录
     *
     * @param token
     * @return
     */
    @SuppressWarnings("unused")
	private boolean isAuth(String token) {
        AuthUser user = getUser(key, token);
        return user.isAuth();
    }

    public String setCookie(HttpServletResponse response, AuthUser user) {
        return setCookie(response,user,null);
    }

    public String setCookie(HttpServletResponse response, AuthUser user, String domain) {
        return setCookie(response, key, user.getId(), user.getName(), user.getExpire(), domain, user.getAuthData());
    }

    public static String setCookie(HttpServletResponse response, String secretKey, String id, String name) {
        return setCookie(response, secretKey, id, name, 3600*24*1000, null, null);
    }

    public static String setCookie(HttpServletResponse response, String secretKey, String id, String name, long expireMillis) {
        return setCookie(response, secretKey, id, name, expireMillis, null, null);
    }

    public static String setCookie(HttpServletResponse response, String secretKey, String id, String name, long expireMillis, String
            domain, String authData) {
        String token = buildToken(secretKey, id, name, expireMillis);
        String idName;
        if(authData==null) {
            idName = id+":"+name;
        } else {
            idName = authData;
        }
        String base64Id = new BASE64Encoder().encode(idName.getBytes());
        int maxAge = -1;
        if(expireMillis>0) {
            maxAge = (int)expireMillis/1000;
            if(maxAge<=0) {
                maxAge = -1;
            }
        }
        CookieHelper.addCookie(response, JSESSID, base64Id, false, maxAge, domain);
        CookieHelper.addCookie(response, JSESSTOKEN, token, true, maxAge, domain);
        return token;
    }

    public static void clearCookie(HttpServletResponse response) {
        CookieHelper.addCookie(response, JSESSID, null, false, 0, null);
        CookieHelper.addCookie(response, JSESSTOKEN, null, true, 0, null);
    }

    public static String getCookieToken(HttpServletRequest request) {
        Cookie tokenCookie = CookieHelper.getCookieByName(request, JSESSTOKEN);
        if(tokenCookie != null) {
            return tokenCookie.getValue();
        }else {
            return null;
        }
    }

    public AuthUser getUser(HttpServletRequest request) {
        String token = getCookieToken(request);
        if(token == null) {
            return AuthUser.Empty;
        }
        AuthUser user = getUser(this.key, token);
        return user;
    }



    public static AuthUser getUser(HttpServletRequest request, String secretKey) {
        String token = getCookieToken(request);
        if(token == null) {
            return AuthUser.Empty;
        }
        AuthUser user = getUser(secretKey, token);
        return user;
    }

    /**
     * 获取登录的AuthUser
     *
     * @param token
     * @return
     */
    public static AuthUser getUser(String secretKey, String token) {
        try {
            Claims claims = Jwts.parser().requireIssuer(TOKENID).setSigningKey(secretKey).parseClaimsJws(token).getBody();
            String id = claims.getId();
            String username = claims.getSubject();
            AuthUser user = new AuthUser();
            if (id != null) {
                user.setId(id);
            }
            user.setName(username);
            if(claims.getExpiration() != null) {
                long now = System.currentTimeMillis();
                user.setExpire(claims.getExpiration().getTime()-now);
            }

            //OK, we can trust this JWT
            return user;
        } catch (SignatureException e) {
            return AuthUser.Empty;
        } catch (Exception e) {
            return AuthUser.Empty;
        }
    }




}
