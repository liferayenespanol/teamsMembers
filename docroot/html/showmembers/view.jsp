<%@page import="com.liferay.portal.model.Contact"%>
<%@page import="com.liferay.portal.model.Phone"%>
<%@ include file="init.jsp" %>
<%@page import="com.liferay.portal.service.UserLocalServiceUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.liferay.portal.model.User"%>
<%@page import="java.util.List"%>
<%@page import="com.liferay.portal.model.Team"%>
<%@page import="com.liferay.portal.service.TeamLocalServiceUtil"%>
<%@page import="com.liferay.portal.theme.ThemeDisplay"%>


<portlet:defineObjects />
<liferay-theme:defineObjects />
<div class="show-team-members">
<%
List<User> users= new ArrayList<User>();
Team team=null;
try{
team = TeamLocalServiceUtil.getTeam(teamId);

if(team!=null){ 
	users = UserLocalServiceUtil.getTeamUsers(team.getTeamId());
}
}catch(Exception e){
	
}
%>

<% if(team==null){ 
%> <h2><liferay-ui:message key="must-be-select-team" /></h2><%
}else if(users==null|| users.size()==0){
	%> <h2><liferay-ui:message key="team-empty" /></h2><%
}else{%>
	<div class="members"> 
	<h2><liferay-ui:message key="members-of" /> <%=team.getName()%></h2>
	<%for(User selUser:users){
		Contact selConctact=null;
	 selConctact = selUser.getContact();
	%>
	<div class="member"> 
	<img src="<%=selUser.getPortraitURL(themeDisplay)%>" alt="<%=selUser.getFullName()%>"/> 
	<div class="member-name"><liferay-ui:message key="name" />:<strong> <%=selUser.getFullName()%></strong></div>
	<% if(selUser.getJobTitle()!=null && !selUser.getJobTitle().equals("")){%>
	<div class="member-job-title"><liferay-ui:message key="job-title" />: <%=selUser.getJobTitle()%></div>
	<%}%>
	<div class="member-email">Email: <%=selUser.getEmailAddress()%>
	</div>
	<%if(selUser.getPhones()!=null && selUser.getPhones().size()>0){%>
	<div class="member-phone"><liferay-ui:message key="phones" />: 
	<%		String phonesTxt=""; 
			for(Phone phone:selUser.getPhones()){
				if(phonesTxt.equals("")){
					phonesTxt+=phone.getNumber();
				}else{
					phonesTxt+=" - "+phone.getNumber();
				}
			}%>
			<%=phonesTxt%>
		</div>
	<%}
	if(selUser.getComments()!=null && !selUser.getComments().equals("")){
	%><div class="member-comments"><liferay-ui:message key="comments" />: <%=selUser.getComments()%></div>
	<%}
	 if(selConctact.getTwitterSn()!=null && !selConctact.getTwitterSn().equals("")){%>
	<a  href="<%=selConctact.getTwitterSn()%>" title="<%=selUser.getFullName()%>"><img src="<%=request.getContextPath()%>/icons/twitter-32.png" alt="<%=selUser.getFullName()%>"/></a>
	<%}
	 if(selConctact.getFacebookSn()!=null && !selConctact.getFacebookSn().equals("")){%>
		<a href="<%=selConctact.getFacebookSn()%>" title="<%=selUser.getFullName()%>"><img src="<%=request.getContextPath()%>/icons/facebook-32.png" alt="<%=selUser.getFullName()%>"/></a>
	<%}%>
	
	</div>
	<%}	%>
	</div>
<%}%>
</div>
