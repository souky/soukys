package com.souky.common;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

public class Sessions {
	@Autowired  
    private SessionFactory sessionFactory;  
	@Autowired
	private Session session = this.sessionFactory.getCurrentSession();
	
	public Session getSession() {
		return session;
	}
	public void setSession(Session session) {
		this.session = session;
	}
}
