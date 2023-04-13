package tn.bankYam;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class MainController {
    @GetMapping("/")
    public String index(HttpSession session) {
        return "main";
    }
}
