<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>EEIT97-第一組</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page="/header_css.jsp" />
    <!-- ***縮小視窗的置頂動態Menu顯示設定_2-1*** -->
    
    <style>
		#video{
			width:100%;
			height:530px;
			padding-bottom:30px;
			border-radius:30px;
		}
		#topictext{
			color:blue;
		}
		
		#mediaplayer{
			background-color:#BEBEBE;
			padding-left:-15px;
		}
		video::-internal-media-controls-download-button {
   	 		display:none;
		}

		video::-webkit-media-controls-enclosure {
    		overflow:hidden;
		}

		video::-webkit-media-controls-panel {
    		width: calc(100% + 30px); 
		}
    </style>

</head>
<body>
<jsp:useBean id="gameMediaSvc" scope="page" class="eeit.gamemedia.model.GameMediaService" />
<jsp:include page="/header.jsp"/>
    <!--主文(開始)-->
    <div class="container">
        <div class="jumbotron">
            <!--表格(開始)-->
            <!--****************-->
            <!-- 第一列(開始) -->
            <!--****************-->
            <div class="row">
            	
            	
            </div>
            <div class="row">
            	<div class="col-md-4"><h2>精彩賽事影音</h2></div>
			</div>
			<br/>
            <div class="row" id="mediaplayer" oncontextmenu="window.event.returnValue=false">
                <!--第一列-左邊表格-格式_.col-md-8-->                
                <div class="col-md-8">
                	<video controls id="video">
            			<source src="<%=request.getContextPath()%>/videos/${gameMediaSvc.getOneGameMedia(6001).gameVideo}" type="video/mp4">
            		</video>
				</div>
				<div class="col-md-4">
					<c:forEach var="gameMediaSvc" items="${gameMediaSvc.all}">
						<h5>${gameMediaSvc.mediasName}</h5>
					</c:forEach>
				</div>
                <!--第一列-右邊表格-格式_.col-md-4-->
<!--               	<div> -->
<!--                 	<video controls id="video1"> -->
<%--             			<source src="<%=request.getContextPath()%>/videos/${gameMediaSvc.getOneGameMedia(6001).gameVideo}" type="video/mp4"> --%>
<!--             		</video> -->
<!-- 				</div> -->
<!-- 				<div> -->
<!--                 	<video controls id="video1"> -->
<%--             			<source src="<%=request.getContextPath()%>/videos/${gameMediaSvc.getOneGameMedia(6001).gameVideo}" type="video/mp4"> --%>
<!--             		</video> -->
<!-- 				</div> -->
<!-- 				<div> -->
<!--                 	<video controls id="video1"> -->
<%--             			<source src="<%=request.getContextPath()%>/videos/${gameMediaSvc.getOneGameMedia(6001).gameVideo}" type="video/mp4"> --%>
<!--             		</video> -->
<!-- 				</div> -->
           	</div>
			<jsp:include page="/footer.jsp" />  
        </div>
    </div>
    <!--主文(結束)-->
    <script>
 
    </script>

<jsp:include page="/footer_css.jsp" />        
</body>
</html>
