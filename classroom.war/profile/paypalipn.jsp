<%@ page import="com.rameses.server.common.*" %>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<%@ page import="com.rameses.server.common.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>

<%
   try {
      Enumeration en = request.getParameterNames();
      String str = "cmd=_notify-validate";
      while(en.hasMoreElements()){
         String paramName = (String)en.nextElement();
         String paramValue = request.getParameter(paramName);
         str = str + "&" + paramName + "=" + URLEncoder.encode(paramValue);
      }
      
      //new URL("https://www.paypal.com/cgi-bin/webscr");
      URL u = new URL("https://www.sandbox.paypal.com/cgi-bin/webscr");
      URLConnection uc = u.openConnection();
      uc.setDoOutput(true);
      uc.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
      PrintWriter pw = new PrintWriter(uc.getOutputStream());
      pw.println(str);
      pw.close();

      BufferedReader in = new BufferedReader(
      new InputStreamReader(uc.getInputStream()));
      String res = in.readLine();
      in.close();
      
      String paymentStatus = request.getParameter("payment_status");
      String paymentAmount = request.getParameter("mc_gross");
      String paymentCurrency = request.getParameter("mc_currency");
      String txnId = request.getParameter("txn_id");
      String receiverEmail = request.getParameter("receiver_email");
      String custom = request.getParameter("custom");

      Map param = new HashMap();
      
      if(res.equals("VERIFIED")) {
         if(paymentStatus.equals("Completed")) {
            param.put("transactionid", custom);
            param.put("paymentcurrency", paymentCurrency);
            param.put("paymentamount", paymentAmount);
            param.put("receiveremail", receiverEmail);
            request.setAttribute("PARAM", param);
%>
            <s:invoke service="CreditService" method="validateOrder" params="${PARAM}"/>
            <c:if test="${!empty error}"> ${error} </c:if>
<%
            System.out.println("Verified transaction ID " + txnId + ". Added credits.");
         }
      }
      else if(res.equals("INVALID")) {
         System.out.println("An Invalid response was received from paypal. txn_id is: " + custom + "");
      }
   }catch(Exception ex)  {
      ex.printStackTrace();
   }
%>
