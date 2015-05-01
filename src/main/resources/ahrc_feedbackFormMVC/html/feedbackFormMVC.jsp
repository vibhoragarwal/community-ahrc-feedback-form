<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<html> 
  <head> 
    <title>Simple Form Validation</title> 
    
    <template:addResources type="javascript" resources="jquery.min.js" />
    <template:addResources type="javascript" resources="jquery.validate.min.js" />
    
    
    <script type="text/javascript"> 
      $(document).ready(function() { 
        
        $("#myForm").show();
        $("#success").hide();
        
        $("#form1").validate({ 
          rules: { 
            question1: "required",// simple rule, converted to {required:true} 
            email: {// compound rule 
              required: true, 
              email: true 
            },  
            question1: { 
              required: true 
            } 
          }, 
          messages: { 
            question1: "Please provide an answer to first question." 
          } 
        }); 
        
        
        
        $('#form1').submit(function () {
          
          if(!   $("#form1").valid()) return false;
          
          alert('Submitting your feedback, thanks !');
          
          
          var selectedVal = "";
          var selected = $("#radioDiv input[type='radio']:checked");
          if (selected.length > 0) {
            selectedVal = selected.val();
          }
          
          
          var data = {};
          //   data["something"] = "val";
          var Form = this;
          
          //Gather Data also remove undefined keys(buttons)
          $.each(this, function(i, v){
            var input = $(v);
            data[input.attr("name")] = input.val();
            delete data["undefined"];
          });
          
          var other1 = $('#other1').val();
          var question2 = $('#question2').val();
          var question3 = $('#question3').val();
          var question4 = $('#question4').val();
          var question5 = $('#question5').val();
          var question6 = $('#question6').val();
          
          var jsonSt = { "question1" : selectedVal, "question2" : question2, "question3" : question3, "question4" : question4, "question5" : question5,"question6" : question6, "other1" : other1};
          $.ajax({
            
            url: $(this).attr('action'),
            type: $(this).attr('method'),
            data: JSON.stringify(jsonSt),
            contentType:'application/json; charset=utf-8',
            dataType: 'json',
            success: function (data) {
              $("#myForm").hide();
              $("#success").show();
            },
            error: function (jqXHR, textStatus, errorThrown) {
              alert(jqXHR.status+", errorThrown "+errorThrown);
            }
          })
          
          return false;
        });
        
        
        
        
      }); 
      
      
      
    </script> 
    
     <style>
      table {
         background-color: #bac9d7 !important;
	  }
    </style>
   
  </head> 
  <body> 
    <div id = "myForm">
      <form method="POST" action="/cms/submitFeedback" id="form1" name="feedbackform" >
        
        <table border="0" cellpadding="0" cellspacing="3" width="370" bgcolor="#bac9d7">
          <tr>
            <td valign="top"><strong>1.</strong></td>
            <td valign="top">
              <p><strong>How did you find out about the Commission's Web site? * </strong></p>
              <div id="radioDiv">
                <p>
                  <input type="radio" name="question1" value="Referral">
                  Referral<br />
                  <input type="radio" name="question1" value="In a Commission publication">
                  In a Commission publication<br />
                  <input type="radio" name="question1" value="In correspondence from the Commission">
                  In correspondence from the Commission<br />
                  <input type="radio" name="question1" value="At a Commission educational presentation">
                  At a Commission educational presentation<br />
                  <input type="radio" name="question1" value="Through a link from another site">
                  Through a link from another site<br />
                  <input type="radio" name="question1" value="Other">
                  Other</p></div>
              <p>If you chose Referral, Link from another site, or Other, please specify the referring party, link, or other resource.
                <br />
                <input type="text" id="other1" size="40">
              </p>
              <p>&nbsp;
                
              </p>
            </td>
          </tr>
          <tr>
            <td valign="top"><strong>2.</strong></td>
            <td valign="top">
              <p><strong>What information were you seeking? Did you find it?</strong></p>
              <p>
                <textarea rows="8" id="question2"  cols="50"></textarea>
              </p>
              <p>&nbsp;
              </p>
            </td>
          </tr>
          <tr>
            <td valign="top"><strong>3.</strong></td>
            <td valign="top">
              <p><strong>What content would you like to see on our site that is not currently available?</strong></p>
              <p>
                <textarea rows="8" id="question3"  cols="50"></textarea>
              </p>
              <p>&nbsp;
              </p>
            </td>
          </tr>
          <tr>
            <td valign="top"><strong>4.</strong></td>
            <td valign="top">
              <p><strong>Please provide your suggestions on how we can improve the accessibility of the site.</strong></p>
              <p>
                <textarea rows="8" id="question4"  cols="50"></textarea>
              </p>
              <p>&nbsp;</p>
            </td>
          </tr>
          <tr>
            <td valign="top"><strong>5.</strong></td>
            <td valign="top">
              <p><strong>Please provide any comments you have about the design (look and feel) of our site. We are interested in hearing what you like about the design as well as your suggestions for improving the design.</strong></p>
              <p>
                <textarea rows="8" id="question5"  cols="50"></textarea>
              </p>
              <p>&nbsp;</p>
            </td>
          </tr>
          <tr>
            <td valign="top"><strong>6.</strong></td>
            <td valign="top">
              <p><strong>Please provide any other comments you have about our site.
                If you have an inquiry that requires a response, please <A href="${url.base}${renderContext.site.path}/ahrc-home/about-the-commission/contact-us.html">contact the Commission</A>. We cannot respond to inquiries submitted
                on this feedback form.&nbsp;</strong></p>
              <p>
                <textarea rows="8" id="question6"  cols="50"></textarea>
              </p>
              <p>&nbsp;</p>
            </td>
          </tr>    
          <tr>
            <td valign="top"></td>
            <td valign="top">
            </td>
          </tr>    
        </table>
        <p>Thank you for taking the time to complete this questionnaire. Your comments will help us to improve our site.</p>
        
        <script type="text/javascript"> 
          
          var RecaptchaOptions = {
            theme : 'white',
            tabindex : 0 
          } 
        </script>
        <script type="text/javascript" src="http://api.recaptcha.net/challenge?k=6Ld5dwEAAAAAADv8bYBzb4E0D6oDa2isSqffXNkn"></script>
        <br />
        <p>
          <input type="submit" value="Submit Questionnaire" name="submit"><!--  onClick="return(checkform())" -->
          <input type="reset" value="Clear Form" name="clear">
        </p>
      </form>
    </div>
    <div id="success">
      <h1>Thank you for your feedback.</h1> 
    </div>
  </body> 
</html> 