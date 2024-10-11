<%@page import="miniroom.ItemMgr"%>
<%@page import="board.BoardWriteBean"%>
<%@page import="board.BoardWriteMgr"%>
<%@page import="guestbook.GuestbookanswerBean"%>
<%@page import="guestbook.GuestbookprofileBean"%>
<%@page import="guestbook.GuestbookprofileMgr"%>
<%@page import="pjh.MemberBean"%>
<%@page import="friend.FriendRequestBean"%>
<%@page import="guestbook.GuestbookBean"%>
<%@page import="alarm.AlarmBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="fMgr" class="friend.FriendMgr" />
<jsp:useBean id="uMgr" class="pjh.MemberMgr" />
<jsp:useBean id="aMgr" class="alarm.AlarmMgr" />
<jsp:useBean id="gMgr" class="guestbook.GuestbookMgr" />
<jsp:useBean id="gaMgr" class="guestbook.GuestbookanswerMgr" />
    <%
    String id = (String) session.getAttribute("idKey");
    String url = request.getParameter("url");

    Vector<AlarmBean> vlist = aMgr.getAllAlarm(id);
    ItemMgr iMgr = new ItemMgr();
			if (vlist.size() > 0) {
			%>
			
			<%
    
    for (int i = 0; i < vlist.size(); i++) {
        AlarmBean alarmBean = vlist.get(i);
        String alarmType = alarmBean.getAlarm_type();
        int alarmContentNum = alarmBean.getAlarm_content_num();
        String alarmAt = alarmBean.getAlarm_at();
        String alarmUser_id = alarmBean.getAlarm_user_id();
        int alarmNum = alarmBean.getAlarm_num();
        boolean alarmRead = alarmBean.isAlarm_read();
        GuestbookBean gBean = null;
        FriendRequestBean fBean = null;
        MemberBean fUser = null;
        GuestbookprofileMgr gpMgr = new GuestbookprofileMgr();

        if (alarmType.equals("친구요청")) {
            fBean = fMgr.getFriendRequestItem(alarmContentNum);
            boolean isRequest_complete = fBean.isRequest_complete();
            fUser = uMgr.getMember(fBean.getRequest_senduserid());
            GuestbookprofileBean gpBean = gpMgr.getProfileByUserId(fUser.getUser_id());
            System.out.println(isRequest_complete);
    %>
    	<%if(!isRequest_complete){ %>
            <li id="<%=alarmNum%>" class="alarmlist_main_div_item">
                <input type="hidden" name="character" value="<%=iMgr.getUsingCharacter(fBean.getRequest_senduserid()).getItem_path()%>">
                <input type="hidden" name="name" value="<%=fUser.getUser_name()%>">
                <input type="hidden" name="type" value="<%=fBean.getRequest_type()%>">
                <input type="hidden" name="comment" value="<%=fBean.getRequest_comment()%>">
                <input type="hidden" name="num" value="<%=fBean.getRequest_num()%>">
                <input type="hidden" name="request_senduserid" value="<%=fBean.getRequest_senduserid()%>">
                <span class="alarmlist_main_div_item_readbool <% if (alarmRead) { %>alarmlist_main_div_item_read<% } %>">읽음</span>
                <span onclick="clickAlarmItem(event)" class="alarmlist_main_div_item_title"><%=gpBean.getProfileName()%>님이
                    <%=fBean.getRequest_type() == 1 ? "일촌" : "이촌"%> 요청을 보냈습니다.</span>
                <span class="alarmlist_main_div_item_requestAt"><%=alarmAt%></span>
            </li>
        <%}else{ %>
        <li id="<%=alarmNum%>" class="alarmlist_main_div_item">
                    <span class="alarmlist_main_div_item_readbool <% if (alarmRead) { %>alarmlist_main_div_item_read<% } %>">읽음</span>
                    <span onclick="clickAlarmItem(event)" class="alarmlist_main_div_item_title">처리된 친구요청입니다.</span>
                    <span class="alarmlist_main_div_item_requestAt"><%=alarmAt%></span>
                </li>
        <%} %>
    <%
        } else if (alarmType.equals("방명록")) {
            gBean = gMgr.getGuestbookEntry(alarmContentNum);
            GuestbookprofileBean gpBean = gpMgr.getProfileByUserId(gBean.getWriterId());

            if (gpBean == null) {
    %>
                <li id="<%=alarmNum%>" class="alarmlist_main_div_item">
                    <span class="alarmlist_main_div_item_readbool <% if (alarmRead) { %>alarmlist_main_div_item_read<% } %>">읽음</span>
                    <span onclick="clickAlarmGuestbook(event)" class="alarmlist_main_div_item_title">삭제된 방명록 알람입니다.</span>
                    <span class="alarmlist_main_div_item_requestAt"><%=alarmAt%></span>
                </li>
    <%
            } else {
    %>
                <li id="<%=alarmNum%>" class="alarmlist_main_div_item">
                    <span class="alarmlist_main_div_item_readbool <% if (alarmRead) { %>alarmlist_main_div_item_read<% } %>">읽음</span>
                    <span onclick="clickAlarmGuestbook(event)" class="alarmlist_main_div_item_title"><%=gpBean.getProfileName()%>님이 방명록을 작성하였습니다.</span>
                    <span class="alarmlist_main_div_item_requestAt"><%=alarmAt%></span>
                </li>
    <%
            }
        } else if (alarmType.equals("방명록댓글")) {
            GuestbookanswerBean gaBean = gaMgr.getAnswersByNum(alarmContentNum);
            GuestbookprofileBean gpBean = gpMgr.getProfileByUserId(gaBean.getGanswerId());

            if (gpBean == null) {
    %>
                <li id="<%=alarmNum%>" class="alarmlist_main_div_item">
                    <span class="alarmlist_main_div_item_readbool <% if (alarmRead) { %>alarmlist_main_div_item_read<% } %>">읽음</span>
                    <span onclick="clickAlarmGuestbook(event)" class="alarmlist_main_div_item_title">삭제된 방명록 댓글 알람입니다.</span>
                    <span class="alarmlist_main_div_item_requestAt"><%=alarmAt%></span>
                </li>
    <%
            } else {
    %>
                <li id="<%=alarmNum%>" class="alarmlist_main_div_item">
                    <span class="alarmlist_main_div_item_readbool <% if (alarmRead) { %>alarmlist_main_div_item_read<% } %>">읽음</span>
                    <span onclick="clickAlarmGuestbook(event)" class="alarmlist_main_div_item_title"><%=gpBean.getProfileName()%>님이 방명록댓글을 작성하였습니다.</span>
                    <span class="alarmlist_main_div_item_requestAt"><%=alarmAt%></span>
                </li>
    <%
            }
        } else if (alarmType.equals("게시판 댓글")) {
            BoardWriteMgr bwMgr = new BoardWriteMgr();
            BoardWriteBean bwBean = bwMgr.getBoard(alarmContentNum);

            if (bwBean == null) {
    %>
                <li id="<%=alarmNum%>" class="alarmlist_main_div_item">
                    <span class="alarmlist_main_div_item_readbool <% if (alarmRead) { %>alarmlist_main_div_item_read<% } %>">읽음</span>
                    <span id = "<%=bwBean.getBoard_num() %>" onclick="clickAlarmBoard(event)" class="alarmlist_main_div_item_title">삭제된 게시판 댓글 알람입니다.</span>
                    <span class="alarmlist_main_div_item_requestAt"><%=alarmAt%></span>
                </li>
    <%
            } else {
    %>
                <li id="<%=alarmNum%>" class="alarmlist_main_div_item">
                    <span class="alarmlist_main_div_item_readbool <% if (alarmRead) { %>alarmlist_main_div_item_read<% } %>">읽음</span>
                    <span id = "<%=bwBean.getBoard_num() %>" onclick="clickAlarmBoard(event)" class="alarmlist_main_div_item_title"><%=bwBean.getBoard_title()%> 게시물에 댓글이 달렸습니다.</span>
                    <span class="alarmlist_main_div_item_requestAt"><%=alarmAt%></span>
                </li>
    <%
            }
        } else if (alarmType.equals("게시판 답글")) {
            BoardWriteMgr bwMgr = new BoardWriteMgr();
            BoardWriteBean bwBean = bwMgr.getBoard(alarmContentNum);

            if (bwBean == null) {
    %>
                <li id="<%=alarmNum%>" class="alarmlist_main_div_item">
                    <span class="alarmlist_main_div_item_readbool <% if (alarmRead) { %>alarmlist_main_div_item_read<% } %>">읽음</span>
                    <span id = "<%=bwBean.getBoard_num() %>" onclick="clickAlarmBoard(event)" class="alarmlist_main_div_item_title">삭제된 게시판 답글 알람입니다.</span>
                    <span class="alarmlist_main_div_item_requestAt"><%=alarmAt%></span>
                </li>
    <%
            } else {
    %>
                <li id="<%=alarmNum%>" class="alarmlist_main_div_item">
                    <span class="alarmlist_main_div_item_readbool <% if (alarmRead) { %>alarmlist_main_div_item_read<% } %>">읽음</span>
                    <span id = "<%=bwBean.getBoard_num() %>" onclick="clickAlarmBoard(event)" class="alarmlist_main_div_item_title"><%=bwBean.getBoard_title()%> 게시물에 답글이 달렸습니다.</span>
                    <span class="alarmlist_main_div_item_requestAt"><%=alarmAt%></span>
                </li>
    <%
            }
        }
    }
    %>
			

			<%
			}
			%>