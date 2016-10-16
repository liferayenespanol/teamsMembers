<%@page import="com.liferay.portal.kernel.util.Constants"%>
<%@ include file="init.jsp" %>

<%@page import="java.util.ArrayList"%>
<%@page import="com.liferay.portal.theme.ThemeDisplay"%>
<%@page import="com.liferay.portal.model.Team"%>
<%@page import="java.util.List"%>
<%@page import="com.liferay.portal.service.TeamLocalServiceUtil"%>

<portlet:defineObjects />
<liferay-theme:defineObjects />
<%

List<Team> teams = TeamLocalServiceUtil.getGroupTeams(themeDisplay.getScopeGroupId());
if(teams==null){
	teams = new ArrayList<Team>();
}
%>
<div class="show-team-members">
	<liferay-portlet:actionURL portletConfiguration="true" var="configurationActionURL" />

	<aui:form action="<%= configurationActionURL %>" method="post" name="fm">
		<aui:input name="<%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>" />

		<liferay-ui:panel collapsible="<%= true %>" extended="<%= true %>" persistState="<%= true %>" title="display-options">
			<aui:fieldset>
		
				<aui:select label="team-id" name="preferences--teamId--">
					<aui:option label="Select..." value="0" selected="<%= 0 == teamId %>" />
					<%
					
					for (Team team : teams) {
					%>

						<aui:option label="<%= team.getName() %>" value="<%=team.getTeamId() %>" selected="<%= team.getTeamId() == teamId %>" />

					<%
					}
					%>

				</aui:select>
			</aui:fieldset>
		</liferay-ui:panel>

		<aui:button type="submit" />
	</aui:form>
</div>



