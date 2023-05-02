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

    @GetMapping("map")
    public String map(HttpSession session) {
        return "map";
    }

    @GetMapping("subsidiary")
    public String subsidiary(HttpSession session) {
        return "subsidiary";
    }

    @GetMapping("introduce")
    public String introduce(HttpSession session) {
        return "introduce";
    }


    @GetMapping("products")
    public String products(HttpSession session) {
        return "products";
    }
    @GetMapping("terms")
    public String terms(HttpSession session) {
        return "terms";
    }
}
