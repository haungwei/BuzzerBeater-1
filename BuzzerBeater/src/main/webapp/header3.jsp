<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="shortcut icon" href="<%=request.getContextPath()%>/images/favicon1.ico" type="image/x-icon">
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon1.ico" type="image/x-icon" /> 
<jsp:useBean id="date" scope="page" class="java.util.Date"/>
<jsp:useBean id="seasonSvc" scope="page" class="eeit.season.model.SeasonService"/>
<jsp:useBean id="teamsSvc" scope="page" class="eeit.teams.model.TeamsService"/>
<jsp:useBean id="gamesSvc" scope="page" class="eeit.games.model.GamesService"/>
<%-- <jsp:useBean id="groupsSvc" scope="page" class="eeit.groups.model.GroupsService"/> --%>

<title>Buzzer Beater</title>
<!--標頭(開始)-->
<nav class="navbar navbar-default navbar-fixed navbar-transparent white bootsnav" >
	<div class="container">
		<div class="attr-nav" style="padding-left:40px">
			<ul>
				<li class="dropdown">
					<!--  新刪修"按鈕"(開始)-->
					
					<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"><img src="<%=request.getContextPath()%>/images/favicon4.ico"></a>
					<ul class="dropdown-menu cart-list">
											<c:choose>
					   <c:when test="${empty LoginOK}">
						<li>
							<a href="#">未登入使用</a>	
						</li>
					   </c:when> 
					    <c:when test="${LoginOK.auth == 'admin'}">
<%-- 							<li><a href="#">${LoginOK.auth}登入使用</a></li> --%>
								<li><a href="<%=request.getContextPath() %>/memberInfo/memberInfoBack.jsp">權限管理</a></li>
								<li><a href="<%=request.getContextPath() %>/season/seasonList_back.jsp">賽季管理</a></li>
<!-- 							<li><a href="">分組</a></li> -->
<!-- 							<li><a href="">賽程</a></li> -->
								<li><a href="<%=request.getContextPath() %>/teams/listAllteam_back.jsp">球隊</a></li>
								<li><a href="<%=request.getContextPath() %>/players/listAllPlayer_back.jsp">球員</a></li>
								<li><a href="<%=request.getContextPath() %>/personaldata/PersonalDataback.jsp">數據</a></li>
								<li><a href="<%=request.getContextPath() %>/gamemedia/videoBackEnd.jsp">影片</a></li>
								<li><a href="<%=request.getContextPath() %>/gamemedia/photoBackEnd.jsp">照片</a></li>
								<li><a href="<%=request.getContextPath() %>/groupreg/check_Sign_up2.jsp">繳費</a></li>				 
						</c:when>
						<c:when test="${LoginOK.auth == 'parttime'}">
<%-- 							<li><a href="#">${LoginOK.auth}登入使用</a></li> --%>
<%-- 							<li><a href="<%=request.getContextPath() %>/season/seasonList_back.jsp">賽季管理</a></li> --%>
								<li><a href="<%=request.getContextPath() %>/players/listAllPlayer_back.jsp">球員</a></li>
								<li><a href="<%=request.getContextPath() %>/personaldata/PersonalDataback.jsp">數據</a></li>
								<li><a href="<%=request.getContextPath() %>/gamemedia/videoBackEnd.jsp">影片</a></li>
								<li><a href="<%=request.getContextPath() %>/gamemedia/photoBackEnd.jsp">照片</a></li>
						</c:when>
						<c:when test="${LoginOK.auth == 'teams'}">
<%-- 								<li><a href="#">${LoginOK.auth}登入使用</a></li> --%>
								<li><a href="<%=request.getContextPath() %>/Teams.do?action=GET_MY_TEAM&teamID=${LoginOK.teamID}">我的球隊</a></li>
								<li><a href="<%=request.getContextPath() %>/teams/insertMyTeam.jsp">分組報名</a></li>
								<li><a href="<%=request.getContextPath() %>/groupreg/check_Sign_up_member_3.jsp">繳費</a></li>
						</c:when>
						<c:otherwise>
						   <li>
								<a href="#">${LoginOK.auth}登入使用</a>
						   </li>
						</c:otherwise>
					</c:choose>	
					</ul>
					
					</li>
				</li>
<!-- 				新刪修"按鈕"(結束) -->
				<!--登入登出"按鈕"(開始)-->
				<li >			
					<c:if test="${empty LoginOK}">
						<a href="#" class="cd-signin" onclick="document.getElementById('id01').style.display='block'" >
							登入
						</a>
					</c:if>								
					<c:if test="${!empty LoginOK}">		
						<a style="padding-top: 20px;">			
							<img  src="${pictureUri}"  style="width:40px; height:40px;text-decoration:none;margin-bottom: -5px;"> 
							<c:set var="var01" value="${LoginOK.name}" />
							${var01}
						</a>
					</c:if>		
				</li>
				<li>
<%-- 				<a href="<%=request.getContextPath()%>/LoginOutServlet.do" onclick="signOut();"> --%>
				<a href="https://www.google.com/accounts/Logout?continue=https://appengine.google.com/_ah/logout?continue=http://localhost:8080/BuzzerBeater/LoginOutServlet.do" >
<%-- 				<a href="<%=request.getContextPath()%>/LoginOutServlet.do" class="cd-signup" > --%>
			         <c:choose>
							<c:when test="${empty LoginOK}">
							</c:when>
							<c:otherwise>
								<c:set var="var02" value="登出" />
							</c:otherwise>
						</c:choose> ${var02}
				 </a></li>
		
				<!--登入登出"按鈕"(結束)-->
			</ul>
		</div>

		<jsp:include page="/header_login.jsp" />

		<div class="navbar-header">
			<!-- 縮小視窗(左列)(開始) -->
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#navbar-menu">
				<i class="fa fa-bars"></i>
			</button>
			<!-- 縮小視窗(左列)(結束) -->
			<!-- logo(開始) -->
			<a class="navbar-brand" href="<%=request.getContextPath() %>/index.jsp" style="padding-top: 1px"> 
			<img src="<%=request.getContextPath()%>/images/700_700.png"
				class="logo logo-display" alt="" > 
			<img src="<%=request.getContextPath()%>/images/700_700.png"
				class="logo logo-scrolled" alt="" >
			</a>
			<!-- logo(結束) -->
		</div>
		<!-- 選單列表(開始) -->
		<div class="collapse navbar-collapse" id="navbar-menu">
			<ul class="nav navbar-nav navbar-right" data-in="fadeInDown" style="margin-right: 15px">
				<li><a href="<%=request.getContextPath() %>/index.jsp">首頁</a></li>
				<li class="dropdown">
					<a href="<%=request.getContextPath() %>/season/seasonList.jsp" class="dropdown-toggle" data-toggle="dropdown">賽季</a>
					<ul class="dropdown-menu">
						<c:forEach var="seasonSet" items="${seasonSvc.season}" begin="0" end="3">
							<li><a href="<%=request.getContextPath() %>/groups/groupList.jsp?seasonID=${seasonSet.seasonID}">${seasonSet.seasonName}</a></li>
						</c:forEach>
					</ul>
				</li>
				<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">賽程</a>
					<ul class="dropdown-menu">
						<c:forEach var="games" items="${gamesSvc.all}" begin="1" end="5">
							<li><a style="font-size: 6px;" href="<%=request.getContextPath()%>/PersonalData.do?action=Get_singlefieldData&gameID=${games.gameID}">${games.teamAVO.teamName} vs ${games.teamBVO.teamName}</a></li>
						</c:forEach>
					</ul>
				</li>
				<li class="dropdown"><a href="<%=request.getContextPath() %>/teams/listAllteam_front.jsp" class="dropdown-toggle" data-toggle="dropdown">球隊</a>
					<ul class="dropdown-menu">
						<c:forEach var="teams" items="${teamsSvc.teams}">
							<li><a href="<%=request.getContextPath()%>/Teams.do?action=GET_ONE_TEAM&teamID=${teams.teamID}">${teams.teamName}</a></li>
						</c:forEach>
					</ul>
				</li>
				<li class="dropdown"><a href="<%=request.getContextPath() %>/players/listAllPlayer_front.jsp" class="dropdown-toggle" data-toggle="dropdown">球員</a>
<!-- 					<ul class="dropdown-menu"> -->
<!-- 					</ul> -->
				</li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown">數據</a>
					<ul class="dropdown-menu">
						<li><a href="<%=request.getContextPath() %>/personaldata/personalData.jsp">個人數據<!--這行的href輸入超連結頁面--></a></li>
						<li><a href="<%=request.getContextPath() %>/personaldata/TeamDataindex.jsp">球隊數據<!--這行的href輸入超連結頁面--></a></li>
					</ul></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"    
					data-toggle="dropdown">影音<!--這行的href輸入超連結頁面--></a>
					<ul class="dropdown-menu">
						<li><a href="<%=request.getContextPath() %>/gamemedia/photo.jsp">照片<!--這行的href輸入超連結頁面--></a></li>
						<li><a href="<%=request.getContextPath() %>/gamemedia/video.jsp">影片<!--這行的href輸入超連結頁面--></a></li>
					</ul>
				</li>
			</ul>
		</div>
		<!-- 選單列表(結束) -->
	</div>
</nav>
<!--標頭(結束)-->


<!--至頂空白(開始)-->
<div class="pageheader fixed-demo dark">
	<div class="container"></div>
</div>
<!--至頂空白(結束)-->
<div class="clearfix"></div>




