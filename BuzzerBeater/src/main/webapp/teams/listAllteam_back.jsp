<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

		<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
		<html>

		<head>
			<title>EEIT97-第一組</title>
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<!-- ***縮小視窗的置頂動態Menu顯示設定_2-1*** -->
			<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/datatables.min.css" />
			<jsp:include page="/header_css.jsp" />
			<style>
				#img1 {
					width: 55px;
					height: 40px;
					margin: auto;
				}
			</style>
		</head>

		<body>

			<jsp:include page="/header.jsp" />
			<jsp:useBean id="teamsSvc" scope="page" class="eeit.teams.model.TeamsService" />
			<!--主文(開始)-->
			<div class="container-fluid">

<!-- 					<div class="col-md-4"> -->
<%-- 						<form class="form-inline" method="post" action="<%=request.getContextPath() %>/Teams.do"> --%>
<!-- 							<select class="form-control" name="season"> -->
<!-- 					<option>賽季</option> -->
<!-- 					<option>2</option> -->
<!-- 					<option>3</option> -->
<!-- 					<option>4</option> -->
<!-- 					<option>5</option> -->
<!-- 				  </select> -->
<!-- 							<select class="form-control" name="groups"> -->
<!-- 					<option>分組</option> -->
<!-- 					<option>2</option> -->
<!-- 					<option>3</option> -->
<!-- 					<option>4</option> -->
<!-- 					<option>5</option> -->
<!-- 				  </select> -->
<!-- 							<select class="form-control" name="teams"> -->
<!-- 					<option>球隊</option> -->
<!-- 					<option>2</option> -->
<!-- 					<option>3</option> -->
<!-- 					<option>4</option> -->
<!-- 					<option>5</option> -->
<!-- 				  </select> -->
<!-- 							<input type="submit" class="btn btn-warning" value="搜尋"> -->
<!-- 							<input type="hidden" name="action" value="GET_ONE_TEAM"> -->
<!-- 						</form> -->
<!-- 					</div> -->
					

							<Form method="post" action="<%=request.getContextPath() %>/Teams.do">
								<button type="submit" class="btn btn-warning">新增球隊</button>
								<input type="hidden" name="action" value="insertTeam">
								<input type="hidden" name="teamID" value="">
								<input type="hidden" name="teamBadge" value="">
								<input type="hidden" name="teamName" value="">
								<input type="hidden" name="captainEmail" value="">
								<input type="hidden" name="captainPhone" value="">
								<input type="hidden" name="coachName" value="">
								<input type="hidden" name="bossName" value="">
								<input type="hidden" name="totalWin" value="0">
								<input type="hidden" name="totalLose" value="0">
								<input type="hidden" name="winRate" value="0">
								<input type="hidden" name="remarks" value="">
							</Form>

					<!--表格(開始)-->
					<!--****************-->
					<!-- 第一列(開始) -->
					<!--****************-->
					<div class="row">


						<div class="col-md-12">
							<table class="table table-bordered" id="table">
								<thead>
									<tr>
										<th>隊徽</th>
										<th>隊名</th>
										<th>隊長E-mail</th>
										<th>隊長電話</th>
										<th>教練</th>
										<th>老闆</th>
										<th>勝場數</th>
										<th>敗場數</th>
										<th>勝率</th>
										<th>備註</th>
										<th></th>
										<th></th>

									</tr>
								</thead>
								<tbody>
									<c:forEach var="teamsVO" items="${teamsSvc.all}">
										<tr align='center' valign='middle'>

											<td><img id="img1" src="data:image/png;base64,${teamsVO.teamBadge}"></td>
											<!--隊徽-->
											<td><a href="<%=request.getContextPath()%>/Teams.do?action=GET_ONE_TEAM&teamID=${teamsVO.teamID}">${teamsVO.teamName}</a></td>
											<!--球名-->
											<td>${teamsVO.captainEmail}</td>
											<!--隊長E-mail-->
											<td>${teamsVO.captainPhone}</td>
											<!--隊長電話-->
											<td>${teamsVO.coachName}</td>
											<!--教練-->
											<td>${teamsVO.bossName}</td>
											<!--老闆-->
											<td>${teamsVO.totalWin}</td>
											<!--勝場數-->
											<td>${teamsVO.totalLose}</td>
											<!--敗場數-->
											<td>${teamsVO.winRate}</td>
											<!--勝率-->
											<td>${teamsVO.remarks}</td>
											<!--備註-->

											<td>
												<Form method="post" action="<%=request.getContextPath() %>/Teams.do">
													<button type="submit" class="btn btn-info">修改</button>
													<input type="hidden" name="action" value="UpdateTeam">
													<input type="hidden" name="teamID" value="${teamsVO.teamID}">
													<input type="hidden" name="teamBadge" value="${teamsVO.teamBadge}">
													<input type="hidden" name="teamName" value="${teamsVO.teamName}">
													<input type="hidden" name="captainEmail" value="${teamsVO.captainEmail}">
													<input type="hidden" name="captainPhone" value="${teamsVO.captainPhone}">
													<input type="hidden" name="coachName" value="${teamsVO.coachName}">
													<input type="hidden" name="bossName" value="${teamsVO.bossName}">
													<input type="hidden" name="totalWin" value="${teamsVO.totalWin}">
													<input type="hidden" name="totalLose" value="${teamsVO.totalLose}">
													<input type="hidden" name="winRate" value="${teamsVO.winRate}">
													<input type="hidden" name="remarks" value="${teamsVO.remarks}">
												</Form>
											</td>
											<td>
												<Form method="post" action="<%=request.getContextPath() %>/Teams.do">
													<button type="submit" class="btn btn-danger">刪除</button> <input type="hidden" name="teamID" value="${teamsVO.teamID}">
													<input type="hidden" name="action" value="delete">
												</Form>
											</td>
										</tr>



									</c:forEach>
							</table>

						</div>

					</div>
					<jsp:include page="/footer.jsp" />

			</div>
			<!--主文(結束)-->

			<jsp:include page="/footer_css.jsp" />
			<script type="text/javascript" src="<%=request.getContextPath()%>/js/datatables.min.js"></script>
			<script>
				$(document).ready(function () {
					 $('#table').DataTable({
						    columnDefs: [{ width: 200, targets: 6}],
						    "lengthMenu": [[5, 10, 15, -1], [5, 10, 15, "All"]],
						    "pagingType": "full_numbers",
						    "language": {
						     "lengthMenu":"每一頁顯示_MENU_ 筆資料",
						     "zeroRecords":"查無資料",
						     "info":"現在正在第_PAGE_ 頁，總共有_PAGES_ 頁",
						     "infoEmpty":"無資料",
						     "infoFiltered":"(總共搜尋了_MAX_ 筆資料)",
						     "search":"搜尋：",
						     "paginate":{
						      "first":"第一頁",
						      "previous":"上一頁",
						      "next":"下一頁",
						      "last":"最末頁"     
						    }
						     }
						   })
				});
			</script>

		</body>

		</html>