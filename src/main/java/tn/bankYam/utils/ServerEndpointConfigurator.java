package tn.bankYam.utils;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.annotation.Configuration;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;

@Configuration
public class ServerEndpointConfigurator extends javax.websocket.server.ServerEndpointConfig.Configurator implements ApplicationContextAware {
	private static volatile BeanFactory context;
	public static final String Session = "Session";
	public static final String Context = "Context";


	@Override
	public <T> T getEndpointInstance(Class<T> clazz) throws InstantiationException {
		return context.getBean(clazz);
	}

	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		ServerEndpointConfigurator.context = applicationContext;
	}

	@Override
	public void modifyHandshake(ServerEndpointConfig config, HandshakeRequest request, HandshakeResponse response) {
		// HttpRequest로부터 Session을 받는다.
		HttpSession session = (HttpSession) request.getHttpSession();
		// HttpSession으로 부터 Context도 받는다.
		ServletContext context = session.getServletContext();
		config.getUserProperties().put(ServerEndpointConfigurator.Session, session);
		config.getUserProperties().put(ServerEndpointConfigurator.Context, context);
	}
}
