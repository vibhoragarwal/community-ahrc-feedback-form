package ahrc.feedback.form.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;



import javax.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.servlet.ModelAndView;
 
import ahrc.feedback.form.model.*;

/**
 * A basic example of how to use Spring MVC annotated controllers with the Jahia CMS.
 */

@Controller
public class FeedbackController {

  
  
     @RequestMapping(method= RequestMethod.POST,value="/submitFeedback",headers="Accept=application/xml, application/json")
    public @ResponseBody Feedback submitFeedback(@RequestBody Feedback feedback, HttpServletRequest request) {
      System.out.println("**********retrieved the feedback data*************** "+feedback);
      try {
      DBConnectionFactory.createFeedback(feedback);
      } catch(Exception any){
        	any.printStackTrace();
      }
      return feedback;
    }


    public class ComplexResult {
        private String firstName;
        private String lastName;

        public ComplexResult(String firstName, String lastName) {
            this.firstName = firstName;
            this.lastName = lastName;
        }

        public String getFirstName() {
            return firstName;
        }

        public String getLastName() {
            return lastName;
        }
    }

    @RequestMapping(method= RequestMethod.GET,value="/hello",headers="Accept=application/xml, application/json")
    public @ResponseBody String getHello() {
        return "<html><h1>Hello World !</h1><html";
    }

    @RequestMapping(method= RequestMethod.GET,value="/hello/{world}",headers="Accept=application/xml, application/json")
    public @ResponseBody String getHello(@PathVariable String world) {
        return "<html><h1>Hello "+world+" !</h1><html";
    }

    @RequestMapping(method= RequestMethod.GET,value="/complex",headers="Accept=application/xml, application/json")
    public @ResponseBody ComplexResult getComplexResult() {
        return new ComplexResult("Serge", "Huber");
    }

}